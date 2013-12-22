#'chronohorogram - Draws a chronohorogram of records
#'@import sqldf
#'@import plotrix
#'@param indf - Input data frame containing biodiversity data set
#'@param title - Title of the plot
#'@param startyear - Starting year for the plot
#'@param endyear - End year for the graph
#'@param colors - Colors to build color ramp 
#'@export
#'@examples \dontrun{
#'chronohorogram(inat)
#'}
chronohorogram <- function (indf=NA,title=NA,startyear=0,endyear=0,
                            colors=c("red", "blue")){
  if (!is.na(title)) {
    title2 <- title
  } else {
    title2 <- "Chronohorogram"
  }
  if (startyear==0){
    startyear=1980
  } 
  if (endyear==0){
    endyear=2015
  }
  dat1=sqldf("select Date_collected, count(*) as ct from indf group by Date_collected")
  if(is.na(dat1$Date_collected[1])){dat1=dat1[2:dim(dat1)[1],]}
  if(as.character(dat1$Date_collected[1])==""){dat1=dat1[2:dim(dat1)[1],]}
  d=as.numeric(strftime(as.Date(dat1$Date_collected,na.rm=T), format = "%j"))
  y=as.numeric(strftime(as.Date(dat1$Date_collected,na.rm=T), format = "%Y"))
  rind=which(y<=endyear & y>=startyear)
  d=d[rind]
  y=y[rind]
  crp=colorRampPalette(colors)( round(log10(max(dat1$ct)+2)) +1 ) 
  radial.plot(y,(d/366)*360,rp.type="s", start=1.62, labels=month.abb,
              clockwise=TRUE, point.col=crp[(round(log10(dat1[,2])+2))-1], 
              point.symbols=20, grid.bg="black",radial.lim=c(startyear,endyear),
              show.radial.grid=T,show.grid.labels=F,show.grid=T,
              main=title2)
}