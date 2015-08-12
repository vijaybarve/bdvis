#' format_bdvis - Convert data to bdvis native format
#' @param indf input data frame containing biodiversity data set
#' @param gettaxo Run gettaxo function to get higher taxonomy if true
#' @examples \dontrun{
#' inat=format_bdvis(inat)
#' }
#' @export
format_bdvis <- function(indf=NA,gettaxo=F){
  chgname <- function (orig,new){
    if(is.element(orig,names(indf))){
      names(indf)[which(names(indf)==orig)]=new
      return(indf)
    } else {
      cat(paste("\n Field ",orig," not present in input data\n"))
    }
  }
  names(indf)=gsub("\\.","_",names(indf))
  if(is.element("Scientific.name",names(indf))){
    names(indf)=gsub("\\.","_",names(indf))
  }
  if(is.element("Observed_on",names(indf))){
    indf=chgname("Observed_on","Date_collected")
  }
  if(is.element("datetaken",names(indf))){
    indf=chgname("datetaken","Date_collected")
  }
  if(is.element("decimalLatitude",names(indf))){
    indf=chgname("decimalLatitude","Latitude")
  }  
  if(is.element("decimalLongitude",names(indf))){
    indf=chgname("decimalLongitude","Longitude")
  }  
  if(is.element("latitude",names(indf))){
    indf=chgname("latitude","Latitude")
  }  
  if(is.element("longitude",names(indf))){
    indf=chgname("longitude","Longitude")
  }  
  if(is.element("name",names(indf))){
    indf=chgname("name","Scientific_name")
  }  
  if(is.element("searchText",names(indf))){
    indf=chgname("searchText","Scientific_name")
  }  
  if(is.element("scientific_name",names(indf))){
    indf=chgname("scientific_name","Scientific_name")
  }  
  indf$Latitude=as.numeric(indf$Latitude)
  indf$Longitude=as.numeric(indf$Longitude)
  indf=getcellid(indf)
  if(gettaxo){
    indf=gettaxo(indf)
  }
  return(indf)
}