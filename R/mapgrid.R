#' Maps the data points on the map in grid format
#' 
#' Customizable grid-based spatial representation of the coordinates of the 
#' records in the data set.
#' 
#' This function builds a grid map colored according to the density of records 
#' in each cell. Grids are 1-degree cells, build with the 
#' \code{\link{getcellid}} function. Currently, four types of maps can be 
#' rendered. Presence maps show only if the cell is populated or not, without 
#' paying attention to how many records or species are present. Record-density 
#' maps apply a color gradient according to the number of records in the cell, 
#' regardless of the number of species they represent. Species-density maps apply 
#' a color gradient according to the number of different species in the cell, 
#' regardless of how many records there are for each one of those. Completeness 
#' maps apply a color gradient according to the completeness index, from 0
#' (incomplete) to 1 (complete).
#' 
#' See parameter descriptions for ways of customizing the map.
#' 
#' @import sqldf
#' @import maps
#' @import ggplot2
#' @importFrom sf read_sf
#' @param indf input data frame containing biodiversity data set
#' @param comp Completeness matrix generate by function \code{\link{bdcomplete}}
#' @param ptype Type of map on the grid. Accepted values are "presence" for 
#'   presence/absence maps, "records" for record-density map, "species" for 
#'   species-density map and "complete" for completeness map
#' @param title title for the map. There is no default title
#' @param bbox bounding box for the map in format c(xmin,xmax,ymin,ymax)
#' @param legscale Set legend scale to a higher value than the max value in the 
#'   data
#' @param collow Color for lower range in the color ramp of the grid
#' @param colhigh Color for higher range in the color ramp of the grid
#' @param mapdatabase database to be used. By default, the world database is 
#'   used
#' @param region Specific region(s) to map, like countries. Default is the whole
#'   world map
#' @param shp path to shapefile to load as basemap (default NA)
#' @param gridscale plot the map grids at scale specified. Scale needs to 
#'   specified in decimal degrees. Default is 1 degree which is approximately 100km.
#' @param customize additional customization string to customize the map output 
#'   using ggplot2 parameters
#'   
#' @return No return value, called for plotting the graph
#' 
#' @examples \dontrun{
#' mapgrid(inat,ptype="records", region="India")
#' }
#' @family Spatial visualizations
#' @export
mapgrid <- function(indf = NULL, comp = NULL, ptype="records",title = "", 
                    bbox = NA, legscale=0, collow="blue",colhigh="red", 
                    mapdatabase = "world", region = ".", 
                    shp = NA, gridscale = 1,
                    customize = NULL)
{
  if(is.null(indf)){
    stop("Please provide data to plot map")
  }
  names(indf) <- gsub("\\.","_",names(indf))
  if(ptype!="complete"){
    indf <- indf[which(!is.na(indf$Latitude)),]
    indf <- indf[which(!is.na(indf$Longitude)),]
    if(nrow(indf)==0){
      stop("Nothing to plot")
    }
    indf <- getcellid(indf,gridscale)
  } else {
    if(is.null(comp)){
      stop("Please provide completeness matrix compnted using functions bdcomplete")
    }
  }
  if (ptype=="species"){
    sps <- sqldf("select Scientific_name, cust_cell_id from indf group by cust_cell_id, Scientific_name")
    cts <- sqldf("select cust_cell_id, count(*) from sps group by cust_cell_id")
  }
  if (ptype=="records"){
    cts <- sqldf("select cust_cell_id, count(*) from indf group by cust_cell_id")
  }  
  if (ptype=="presence"){
    cts1 <- sqldf("select cust_cell_id, count(*) as ct1 from indf group by cust_cell_id")
    cts <- sqldf("select cust_cell_id, 1 as ct from cts1 where ct1 <> 0")
  }
  if (ptype=="complete"){
    cts <- sqldf("select Cell_id,(c) as ct from comp")
    names(cts) <- c("cust_cell_id","ct")
  }  
  lat <- long <- group <- count_ <- NULL
  lat_cell_no <- (max(indf$Latitude) - min(indf$Latitude)) %/% gridscale
  Lat <- min(indf$Latitude) + (cts$cust_cell_id  %/% lat_cell_no) * gridscale
  Long <- min(indf$Longitude) + (cts$cust_cell_id %% lat_cell_no) * gridscale
  cts <- cbind(cts,Lat,Long)
  names(cts) <- c("Cell_id","ct", "Lat", "Long"  )  
  if (ptype=="presence"){
    mybreaks <- seq(0:1)
    myleg <- seq(0:1)
  } else{
    mybreaks <- seq(0:(ceiling(log10(max(cts$ct)))))
    myleg <- 10^mybreaks
  }
  middf <- data.frame(
    lat = cts$Lat,
    long = cts$Long,
    count_ = cts$ct
  )
  if(legscale>0){
    legent=c(
      lat = 0,
      long = 0,
      count_ = legscale
    )
    middf <- rbind(middf,legent)
  }
  legname <- paste(ptype,"\n    ",max(middf$count_))
  mapp <- map_data(map=mapdatabase, region=region)
  if(!is.na(shp)){
    mapp <- sf::read_sf(shp)
  }
  message(paste("Rendering map...plotting ", nrow(cts), " tiles", sep=""))
  if (ptype=="presence"){ 
    ggplot(mapp, aes(long, lat)) + # make the plot
      ggtitle(title) +
      geom_tile(data=middf, aes(long, lat, fill=(count_))) +  
      coord_fixed(ratio = 1) +
      scale_fill_gradient2(low = "white", mid=colhigh, high = colhigh, name=ptype, space="Lab") +
      labs(x="", y="") +
      geom_polygon(aes(group=group), fill=NA, color="gray80", size=0.8) +
      theme_bw(base_size=14) + 
      theme(legend.position = c(.1, .25), legend.key = element_blank()) +
      blanktheme() +
      customize
  } else {
    ggplot(mapp, aes(long, lat)) + # make the plot
      ggtitle(title) +
      geom_tile(data=middf, aes(long, lat, fill=log10(count_)),alpha=1) +  
      coord_fixed(ratio = 1) +
      scale_fill_gradient2(low = "white", mid=collow, high = colhigh, name=legname, alpha(.3),
                           breaks = mybreaks, labels = myleg, space="Lab") +
      labs(x="", y="") +
      geom_polygon(aes(group=group), fill=NA, color="gray80", size=0.8) +
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
        plot.margin=rep(unit(0,"null"),4))
}

cellid_bbox <- function(bbox=c(-90,90,-180,180)){
  retvect=NULL
  for (Longitude in bbox[1]:bbox[2]){
    for (Latitude in bbox[3]:bbox[4]){
      Cell_id <- (((Latitude %/% 1) + 90) * 360) + ((Longitude %/% 1) + 180)
      retvect <- rbind(retvect,Cell_id)
    }
  }
  return(as.vector(retvect))
}