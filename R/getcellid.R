#'Assigns GBIF style degree cell ids
#'  
#'Assigns GBIF style degree cell ids and Centi degree (0.1) cell ids for each record which are used in functions like \link[bdvis]{mapgrid}
#'  
#'@param indf input data frame containing biodiversity data set
#'@export
#'@examples \dontrun{
#'getcellid(inat)
#'}
getcellid <- function (indf){
  indf$Latitude <- as.numeric(indf$Latitude)
  indf$Longitude <- as.numeric(indf$Longitude)
  indf$Cell_id <- (((indf$Latitude %/% 1) + 90) * 360) + ((indf$Longitude %/% 1) + 180)
  indf$Centi_cell_id <- ((((indf$Latitude %% 1) * 10) %/% 1 ) * 10) + (((indf$Longitude %% 1) * 10) %/% 1)
  return(indf)
}
