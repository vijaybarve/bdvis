#' datasubset - Subset data for bdvis
#' @param indf input data frame containing biodiversity data set
#' @param sql sql string to run query on indf
#' @param minyear Minimum year value
#' @param maxyear Maximum year value
#' @param scname Scientific_name to select
#' @examples \dontrun{
#' inat1=datasubset(inat,minyear=2000, maxyear=2014)
#' }
#' @export
datasubset <- function(indf=NA,sql="",minyear=-1,maxyear=-1,scname=NA){
  prc=F
  if(minyear!= -1){
    indf=indf[which(as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%Y"))>=minyear),]
    prc=T
  }
  if(maxyear!= -1){
    indf=indf[which(as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%Y"))<=maxyear),]
    prc=T
  }
  if(!is.na(scname)){
    indf=indf[which(indf$Scientific_name==scname),]
    prc=T
  }
  if(sql!=""){
    indf=sqldf(sql)
  }
  return(indf)
}
