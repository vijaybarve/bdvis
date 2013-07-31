#'getcellid - Assigns GBIF style degree Cell ids and Centi degree (0.1) cell ids 
#'  for each record.
#'@param indf input data frame containing biodiversity data set
#'@export
#'@examples \dontrun{
#'getcellid(inat)
#'}
getcellid <- function (indf){
  indf$Cell.id <- (((indf$Latitude %/% 1) + 90) * 360) + ((indf$Longitude %/% 1) + 180)
  indf.Centi.cell.id <- ((((indf$Latitude %% 1) * 10) %/% 1 ) * 10) + (((indf$Longitude %% 1) * 10) %/% 1)
  return(indf)
}
