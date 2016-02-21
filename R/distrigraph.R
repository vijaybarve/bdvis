#' Distribution graphs
#' 
#' Graphs dispalying distribution of biodiversity data
#' 
#' @import sqldf
#' @param indf input data frame containing biodiversity data set
#' @param ptype type of graph i.e. cell, species, efforts
#' @param ... any additional parameters for plot. Standard papramaterrs like graph type, color etc.
#' @examples \dontrun{
#'  distrigraph(inat,ptype="cell",col="tomato")
#'  distrigraph(inat,ptype="species",ylab="Species")
#'  distrigraph(inat,ptype="efforts",col="red")
#'  distrigraph(inat,ptype="efforts",col="red",type="s")
#' }
#' @export
distrigraph <- function(indf,ptype=NA,...){
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
             Year = as.numeric(strftime(as.Date(indf$Date_collected,na.rm=T), format = "%Y"))
             indf=cbind(indf,Year)
             mat=sqldf("select Year, count(*) as Records from indf group by Year order by Year")
             plot(mat,main="Distribution of collection effforts over time",...)
           },
           stop("Enter valid plot type (ptype) i.e. cell, species, efforts")
    )
  }
}