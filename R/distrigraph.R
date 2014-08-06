#' distrigraph - Distribution graphs
#' @import sqldf
#' @param indf input data frame containing biodiversity data set
#' @param type type of graph i.e. cell, species, efforts
#' @param ... any additional parameters for plot 
#' @examples \dontrun{
#'  distrigraph(inat2,type="cell")
#'  distrigraph(inat2,type="species")
#'  distrigraph(inat2,type="efforts",col="red")
#' }
#' @export
distrigraph <- function(indf,type=NA,...){
  custgraph='col="red"'
  if(!is.na(type)){
    switch(type,
           cell={
             mat=sqldf("select Cell_id, count(*) as Records from indf group by Cell_id")
             hist(mat$Records,main="Distribution of Records per cell",xlab="Records",...)
           },
           species={
             mat=sqldf("select Scientific_name, count(*) as Records from indf group by Scientific_name")
             hist(mat$Records,main="Distribution of Records per Species",xlab="Records",...)
           },
           efforts={
             Year = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%Y"))
             indf=cbind(indf,Year)
             mat=sqldf("select Year, count(*) as Records from indf group by Year order by Year")
             plot(mat,type="l",main="Distribution of collection effforts over time",...)
             plot(mat,type="p",main="Distribution of collection effforts over time",...)
           },
           stop("Enter valid type i.e. cell, species, efforts")
    )
  }
}