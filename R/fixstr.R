#'fixstr - Fix structure of the data frame to match the key fields to GBIF style 
#'  data fireld names
#'@param indf input data frame containing biodiversity data set
#'@param Latitude name of Latitude field in original data frame
#'@param Longitude name of Longitude field in original data frame
#'@param DateCollected name of Date Collected field in original data frame
#'@param SciName name of Scientific Name field in original data frame
#'@export
#'@examples \dontrun{
#'
#'}
fixstr <- function (indf, Latitude =NA, Longitude=NA, DateCollected=NA,
                    SciName=NA){
  chgname <- function (orig,new){
    if(is.element(orig,names(indf))){
      names(indf)[which(names(indf)==orig)]=new
      return(indf)
    } else {
      cat(paste("\n Field ",orig," not present in input data\n"))
    }
  }
  if (!is.na(Latitude)) {
    indf=chgname(Latitude,"Latitude")
  } 
  if (!is.na(Longitude)) {
    indf=chgname(Longitude,"Longitude")
  } 
  if (!is.na(DateCollected)) {
    indf=chgname(DateCollected,"Date_collected")
  } 
  if (!is.na(SciName)) {
    indf=chgname(SciName,"Scientific_name")
  } 
  
  return(indf)
}
