#' mapgrid - Maps the data points on the map in grid format
#' @import sqldf
#' @import maps
#' @import ggplot2
#' @import grid
#' @param indf - input data frame containing biodiversity data set
#' @param ptype - type of map on the grid valid values are presence, records, species
#' @param title - title for the map
#' @param bbox - Bounding box for the map in format c(xmin,xmax,ymin,ymax)
#' @param mapdatabase - database to be used default world
#' @param region - specify region(s) to map i.e. countries default . for whole world
#' @param customize - customization string
#' @examples \dontrun{
#' mapgrid(inat,ptype="records")
#' }
#' @export
mapgrid <- function(indf=NA, ptype="records",bbox=NA, title = "",
                    mapdatabase = "world", region = ".", 
                    customize = NULL)
{
  names(indf)=gsub("\\.","_",names(indf))
  
  # Type presence needs to be coded yet
  if (ptype=="species"){
    sps=sqldf("select Scientific_name, cell_id from indf group by cell_id, Scientific_name")
    cts=sqldf("select cell_id, count(*) from sps group by cell_id")
  }
  if (ptype=="records"){
    cts=sqldf("select cell_id, count(*) from indf group by cell_id")
  }  
  if (ptype=="presence"){
    #cts=sqldf("select cell_id, count(*) from indf group by cell_id")
    print("Presence option to be coded yet")
  }  
  if (!is.na(bbox[1])){
    clist=as.data.frame(cellid_bbox(bbox=bbox))
    cts1=sqldf("select * from cts where cell_id in (select * from clist)")
    cts = cts1[2:dim(cts1)[1],]
  }
  
  Lat= -90 + (cts$Cell_id %/% 360) + 1
  Long= -180 + (cts$Cell_id %% 360) + 1
  cts=cbind(cts,Lat,Long)
  names(cts)=c("Cell_id", "ct", "Lat", "Long"  )
  mybreaks=seq(0:(ceiling(log10(max(cts$ct)))))
  myleg=10^mybreaks
  middf <- data.frame(
    lat = cts$Lat,
    long = cts$Long,
    count = cts$ct
  )
  mapp <- map_data(map=mapdatabase, region=region)
  message(paste("Rendering map...plotting ", nrow(cts), " tiles", sep=""))
  ggplot(mapp, aes(long, lat)) + # make the plot
    ggtitle(title) +
    geom_raster(data=middf, aes(long, lat, fill=log10(count), width=1, height=1)) +  
    coord_fixed(ratio = 1) +
    scale_fill_gradient2(low = "white", mid="blue", high = "red", name=ptype, breaks = mybreaks, labels = myleg) +
    geom_polygon(aes(group=group), fill="white", alpha=0, color="gray80", size=0.8) +
    labs(x="", y="") +
    theme_bw(base_size=14) + 
    theme(legend.position = "bottom", legend.key = element_blank()) +
    blanktheme() +
    customize
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
