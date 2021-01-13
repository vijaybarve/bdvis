#'Assign GBIF style degree cell ids and generate custom grid cell ids
#'
#'Calculate and assign a GBIF-style degree cell id and centi-degree (0.1 
#'degrees, dividing a 1 degree cell into 100 centi-degree cells) cell id to each
#'record. This function also creates a custom grid scale if parameter gridscale 
#'is supplied. This is a necessary previous step for some functions like
#'\code{\link{mapgrid}}
#'
#'@param indf input data frame containing biodiversity data set
#'@param gridscale generate custom grid scale column for mapping. Default is 0.
#'@export
#'@family Data preparation functions
#'@examples \dontrun{
#'getcellid(inat)
#'}
getcellid <- function (indf,gridscale=0){
  indf$Latitude <- as.numeric(indf$Latitude)
  indf$Longitude <- as.numeric(indf$Longitude)
  indf$Cell_id <- (((indf$Latitude %/% 1) + 90) * 360) 
  + ((indf$Longitude %/% 1) + 180)
  indf$Centi_cell_id <- ((((indf$Latitude %% 1) * 10) %/% 1 ) * 10) 
  + (((indf$Longitude %% 1) * 10) %/% 1)
  if(gridscale!=0){
    bbox <- get_bbox(indf)
    lat_diff <- bbox[2] - bbox[1]
    lat_cell_no <- lat_diff %/% gridscale
    indf$cust_cell_id <- (((indf$Latitude - bbox[1]) %/% gridscale) * lat_cell_no ) +
      ((indf$Longitude - bbox[3]) %/% gridscale )
  }
  return(indf)
}

get_bbox <- function(indf){
  top <- min(indf$Latitude)
  bottom <- max(indf$Latitude)
  left <- min(indf$Longitude)
  right <- max(indf$Longitude)
  bbox <- c(top,bottom,left,right)
  return(bbox)
}