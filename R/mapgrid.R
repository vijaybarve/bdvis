#' Maps the data points on the map in grid format
#' 
#' Maps the data points aggrigated on the map in grid format showing presence 
#'   or number of records in each gid cell by color gradiant.
#' 
#' @import sqldf
#' @import maps
#' @import ggplot2
#' @param indf input data frame containing biodiversity data set
#' @param ptype plot type of map on the grid valid values are presence, records, species. Presence will generate presence maps, species will display number of species in each map pixel and records will display number of records in each map pixel.
#' @param title title for the map
#' @param bbox bounding box for the map in format c(xmin,xmax,ymin,ymax)
#' @param legscale Set legend scale to a higher value than the max value in the data
#' @param mapdatabase database to be used default world
#' @param region specify region(s) to map i.e. countries default '.' for whole world map
#' @param customize additional customization string to customize the map output using ggplo2 parameters
#' @examples \dontrun{
#' mapgrid(inat,ptype="records")
#' }
#' @export
mapgrid <- function(indf=NA, ptype="records",title = "", bbox=NA, 
                    legscale=0, mapdatabase = "world", region = ".", 
                    customize = NULL)
{
  names(indf)=gsub("\\.","_",names(indf))
  indf=indf[which(!is.na(indf$Latitude)),]
  indf=indf[which(!is.na(indf$Longitude)),]
  if (ptype=="species"){
    sps=sqldf("select Scientific_name, cell_id from indf group by cell_id, Scientific_name")
    cts=sqldf("select cell_id, count(*) from sps group by cell_id")
  }
  if (ptype=="records"){
    cts=sqldf("select cell_id, count(*) from indf group by cell_id")
  }  
  if (ptype=="presence"){
    cts1=sqldf("select cell_id, count(*) as ct1 from indf group by cell_id")
    cts=sqldf("select cell_id, 1 as ct from cts1 where ct1 <> 0")
  }  
  if (!is.na(bbox[1])){
    clist=as.data.frame(cellid_bbox(bbox=bbox))
    cts1=sqldf("select * from cts where cell_id in (select * from clist)")
    cts = cts1[2:dim(cts1)[1],]
  }
  lat=long=group=NULL
  Lat= -90 + (cts$Cell_id %/% 360) 
  Long= -180 + (cts$Cell_id %% 360) 
  cts=cbind(cts,Lat,Long)
  names(cts)=c("Cell_id", "ct", "Lat", "Long"  )
  if (ptype=="presence"){
    mybreaks=seq(0:1)
    myleg=seq(0:1)
  } else{
    mybreaks=seq(0:(ceiling(log10(max(cts$ct)))))
    myleg=10^mybreaks
  }
  middf <- data.frame(
    lat = cts$Lat,
    long = cts$Long,
    count = cts$ct
  )
  if(legscale>0){
    legent=c(
      lat = 0,
      long = 0,
      count = legscale
    )
    middf=rbind(middf,legent)
  }
  legname=paste(ptype,"\n    ",max(middf$count))
  mapp <- map_data(map=mapdatabase, region=region)
  message(paste("Rendering map...plotting ", nrow(cts), " tiles", sep=""))
  if (ptype=="presence"){ 
    ggplot(mapp, aes(long, lat)) + # make the plot
      geom_polygon(aes(group=group), fill="white", color="gray80", size=0.8) +
      ggtitle(title) +
      geom_raster(data=middf, aes(long, lat, fill=(count), width=1, height=1),hjust = 1, vjust = 1) +  
      coord_fixed(ratio = 1) +
      scale_fill_gradient2(low = "white", mid="red", high = "red", name=ptype, space="Lab") +
      labs(x="", y="") +
      theme_bw(base_size=14) + 
      theme(legend.position = c(.1, .25), legend.key = element_blank()) +
      blanktheme() +
      customize
  } else {
    ggplot(mapp, aes(long, lat)) + # make the plot
      geom_polygon(aes(group=group), fill="white", color="gray80", size=0.8) +
      ggtitle(title) +
      geom_raster(data=middf, aes(long, lat, fill=log10(count), width=0.1, height=0.1),hjust = 1, vjust = 1) +  
      coord_fixed(ratio = 1) +
      scale_fill_gradient2(low = "white", mid="blue", high = "red", name=legname, 
                           breaks = mybreaks, labels = myleg, space="Lab") +
      labs(x="", y="") +
      theme_bw(base_size=14) + 
      theme(legend.position = c(.1, .25), legend.key = element_blank()) +
      blanktheme() +
      customize
  }
}

# Function borrowed from rgbif package
blanktheme <- function(){
  theme(axis.line=element_blank(),
        axis.text.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank(),
        plot.margin = rep(unit(0,"null"),4))
}

cellid_bbox <- function(bbox=c(-90,90,-180,180)){
  retvect=NULL
  for (Longitude in bbox[1]:bbox[2]){
    for (Latitude in bbox[3]:bbox[4]){
      #print(paste(Latitude,Longitude))
      Cell_id <- (((Latitude %/% 1) + 90) * 360) + ((Longitude %/% 1) + 180)
      retvect=rbind(retvect,Cell_id)
    }
  }
  return(as.vector(retvect))
}