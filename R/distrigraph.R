#' Distribution graphs
#' 
#' Build plots displaying distribution of biodiversity records among 
#' user-defined features.
#' 
#' The main use of this function is to create record histograms according to
#' different features of the data set. For example, one might want to see the 
#' evolution of records by year, or by species. This function enables easy 
#' access to such plots.
#' 
#' @import sqldf
#' @importFrom graphics hist plot
#' @param indf input data frame containing biodiversity data set
#' @param ptype Feature to represent. Accepted values are "species", "cell",  
#'   "efforts" and "effortspecies" (year)
#' @param cumulative with ptype as efforts, plot a cumulative records graph
#' @param ... any additional parameters for the \code{\link{plot}} function.
#' @examples \dontrun{
#'  distrigraph(inat,ptype="cell",col="tomato")
#'  distrigraph(inat,ptype="species",ylab="Species")
#'  distrigraph(inat,ptype="efforts",col="red")
#'  distrigraph(inat,ptype="efforts",col="red",type="s")
#' }
#' @export
distrigraph <- function(indf,ptype=NA,cumulative=F,...){
  custgraph='col="red"'
  if(!is.na(ptype)){
    switch(ptype,
           cell={
             mat=sqldf("select Cell_id, count(*) as Records from indf group by Cell_id")
             hist(mat$Records,main="Distribution of Records per cell",xlab="Records",...)
           },
           species={
             mat=sqldf("select Scientific_name, count(*) as Records from indf group by Scientific_name")
             hist(mat$Records,main="Distribution of Records per Species",xlab="Records",...)
           },
           efforts={
             Year_ = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%Y"))
             indf=cbind(indf,Year_)
             mat=sqldf("select Year_, count(*) as Records from indf group by Year_ order by Year_")
             if(!cumulative){
               plot(mat,main="Distribution of collection effforts over time",...)
             }else{
               mat1 <- as.data.frame(cbind(mat$Year_, cumsum(mat$Records)))
               names(mat1)<-c("Year","Records")
               plot(mat1,main="Accumulation of collection effforts over time",...)
             }
           },
           effortspecies={
             Year_ = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%Y"))
             indf=cbind(indf,Year_)
             matsp <- sqldf("select Scientific_name, Year_ from indf group by Scientific_name, Year_")
             mat <- sqldf("select Year_, count(*) as Records from matsp group by Year_ order by Year_")
             names(mat)<-c("Year","Species")
             if(!cumulative){
               plot(mat,main="Distribution of species collection effforts over time",...)
             }else{
               mat1 <- as.data.frame(cbind(mat$Year, cumsum(mat$Species)))
               names(mat1)<-c("Year","Species")
               for (i in 1:dim(mat1)[1]){
                 mat1$Species[i] <- length(unique(matsp$Scientific_name[which(matsp$Year_<mat$Year[i])]))
               }
               plot(mat1,main="Accumulation of species over time",...)
             }
           },
           stop("Not a valid option. See ?distrigraph for currently accepted values")
    )
  } else {
    stop("Must indicate a value for ptype.")
  }
}