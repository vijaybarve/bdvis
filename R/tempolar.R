#' tempolar - Polar plot of temporal data 
#' @import sqldf
#' @import plotrix
#' @param indf input data frame containing biodiversity data set
#' @param timescale Temporal scale of the graph d - daily, w - weekly 
#'      m - monthly. Default is d.
#' @param title Title for the graph. Default is "Temporal coverage".
#' @param color color of the graph plot. Dafault is "red".
#' @param plottype plot types of r - lines, p - polygon and s - symbols. 
#'      Dafault is p.
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
    plottype2 <- "p"
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
    radial.plot(daytab$dct,
                ((((daytab$dayofYear-1)*360)/366)*(3.14/180)),
                line.col=color2, labels=month.abb,
                clockwise=T, start=1.62,
                radial.lim = c(0,max(daytab$dct)),
                main=title2,boxed.radial=FALSE,
                show.grid.labels=3,rp.type=plottype2)
  }
  if(timescale2=="w"){
    if(is.na(weektab[1,1])){weektab=weektab[2:dim(weektab)[1],]}
    if(dim(weektab)[1]==54){
      weektab[1,2]=weektab[1,2]+weektab[54,2]
      weektab=weektab[1:53,]
    }
    radial.plot(weektab$wct,
                ((((weektab$weekofYear-1)*360)/53)*(3.14/180)),
                line.col=color2,start=1.62, labels=month.abb,
                radial.lim = c(0,max(weektab$wct)),
                clockwise=TRUE,main=title2,boxed.radial=FALSE,
                show.grid.labels=3,rp.type=plottype2,lwd=4)
  }
  if(timescale2=="m"){
    if(is.na(monthtab[1,1])){monthtab=monthtab[2:dim(monthtab)[1],]}
    radial.plot(monthtab$mct,
                ((((monthtab$monthofYea-1)*360)/12)*(3.14/180)),
                line.col=color2,start=1.62, labels=month.abb,
                radial.lim = c(0,max(monthtab$mct)),
                clockwise=TRUE,main=title2,boxed.radial=FALSE,
                show.grid.labels=3,rp.type=plottype2,lwd=4)  
  }
}