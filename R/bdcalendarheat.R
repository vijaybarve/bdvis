#' Calendar Heat map of biodiversity data
#' @import sqldf
#' @param indf input data frame containing biodiversity data set
#' @param title title custome title for the plot
#' @examples \dontrun{
#' bdcalendarheat(inat)
#' }
#' @export
bdcalendarheat <- function(indf=NA,title=NA){
  if(is.na(title)){
    title="number of records"
  }
  indf$Date_collected = as.Date(indf$Date_collected,"%Y-%m-%d")
  dat=sqldf("select Date_collected, count(*) as recs from indf group by Date_collected")
  #dat=dat[2:dim(dat)[1],]
  dat=na.omit(dat)
  Year = as.numeric(strftime(as.Date(dat$Date_collected,na.rm=T), format = "%Y"))
  CurrentYear = as.numeric(strftime(as.Date(Sys.Date()), format = "%Y"))
  if(max(Year)>CurrentYear){
    dat=dat[which(Year <= CurrentYear ),]
  }
  Year = as.numeric(strftime(as.Date(dat$Date_collected,na.rm=T), format = "%Y"))
  if(max(Year)-min(Year) > 6) {
    dat=dat[which(Year > (max(Year)-6) ),]
  }
  calendarHeat(dat$Date_collected, dat$recs, varname=title)
}
