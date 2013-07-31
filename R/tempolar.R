#' tempolar - Polar plot of temporal data 
#' @import sqldf
#' @import plotrix
#' @param indf input data frame containing biodiversity data set
#' @param timescale Temporal scale of the graph d - daily, w - weekly m - monthly
#' @param title Title for the graph
#' @param color color of the graph plot
#' @param plottype plot types of r - lines, p - polygon and s - symbols
#' @examples \dontrun{
#' tempolar(inat)
#' }
#' @export
tempolar <- function(indf=NA, timescale=NA, title=NA, color=NA, plottype=NA){
  areColors <- function(x) {
    sapply(x, function(X) {
      tryCatch(is.matrix(col2rgb(X)), 
               error = function(e) FALSE)
    })
  }
  if (!is.na(title)) {
    title2 <- title
  } else {
    title2 <- "Temporal coverage"
  }
  if (!is.na(color) & areColors(color)) {
    color2 <- color
  } else {
    color2 <- "red"
  }
  if (!is.na(plottype)) {
    plottype2 <- plottype
  } else {
    plottype2 <- "r"
  }
  if (!is.na(timescale)) {
    timescale2 <- timescale
  } else {
    timescale2 <- "d"
  }
  
  names(indf)=gsub("\\.","_",names(indf))
  if("Date_collected" %in% colnames(indf)){
    dayofYear = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%j"))
    weekofYear = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%U"))
    monthofYear = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%m"))
    
  } else {
    dayofYear = as.numeric(strftime(as.Date(indf$observed_on,na.rm=T), format = "%j"))
    weekofYear = as.numeric(strftime(as.Date(indf$observed_on,na.rm=T), format = "%U"))
    monthofYear = as.numeric(strftime(as.Date(indf$observed_on,na.rm=T), format = "%m"))
    
  }
  indf = cbind(indf,dayofYear,weekofYear,monthofYear)
  daytab=sqldf("select dayofYear, count(*) as dct from indf group by dayofYear")
  weektab=sqldf("select weekofYear, count(*) as wct from indf group by weekofYear")
  monthtab=sqldf("select monthofYear, count(*) as mct from indf group by monthofYear")
  
  if(timescale2=="d"){
    if(is.na(daytab[1,1])){daytab=daytab[2:dim(daytab)[1],]}
    polar.plot(daytab$dct,(daytab$dayofYear/366)*360,line.col=color2,start=90, 
               clockwise=TRUE,main=title2,boxed.radial=FALSE,
               show.grid.labels=3,rp.type=plottype2)
  }
  if(timescale2=="w"){
    if(is.na(weektab[1,1])){weektab=weektab[2:dim(weektab)[1],]}
    polar.plot(weektab$wct,(weektab$weekofYear/53)*360,line.col=color2,start=90, 
               clockwise=TRUE,main=title2,boxed.radial=FALSE,
               show.grid.labels=3,rp.type=plottype2,lwd=4)
  }
  if(timescale2=="m"){
    if(is.na(monthtab[1,1])){monthtab=monthtab[2:dim(monthtab)[1],]}
    polar.plot(monthtab$mct,(monthtab$monthofYear/12)*360,line.col=color2,start=90, 
               clockwise=TRUE,main=title2,boxed.radial=FALSE,
               show.grid.labels=3,rp.type=plottype2,lwd=4)
    
  }
}