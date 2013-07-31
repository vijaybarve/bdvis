#' mapgrid - Maps the data points on the map in grid format
#' @import sqldf
#' @import maps
#' @param indf input data frame containing biodiversity data set
#' @param ptype type of map on the grid valid values are presence, records, species
#' @examples \dontrun{
#' mapgrid(inat,ptype="records")
#' }
#' @export
mapgrid <- function(indf=NA, ptype){
  names(indf)=gsub("\\.","_",names(indf))
  print(ptype)
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
  
  cts = cts[2:dim(cts)[1],]
  Lat= -90 + (cts$Cell_id %/% 360)
  Long= -180 + (cts$Cell_id %% 360)
  cts=cbind(cts,Lat,Long)
  names(cts)=c("Cell_id", "ct", "Lat", "Long"  )
  
  z = log10(cts$ct)
  
  plotclr <- c(
    colorRampPalette(c("blue", "purple", "orange"))(175))
  z_scl <- (z - min(z, na.rm=T))/(max(z, na.rm=T) - min(z, na.rm=T))
  color_scl = round(z_scl*length(plotclr))
  color_scl[color_scl == 0] = 1
  
  #plot(indf$Longitude, indf$Latitude, type = "n")
  map()
  #map(xlim=c(60,100),ylim=c(5,35))
  for (i in 1:dim(cts)[1]) {
    points(cts$Long[i],cts$Lat[i],col= plotclr[color_scl[i]],pch=15,cex=1.5)
  }
}