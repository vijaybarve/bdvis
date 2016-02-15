#'Draws a treemap based on Taxonomic hierarchy of records
#'
#'Draws a treemap based on Taxonomic hierarchy of records
#'
#'@import sqldf
#'@import treemap
#'@param indf input data frame containing biodiversity data set
#'@param n max number of rectangles to be plotted in the treemap
#'@param title title for the tree
#'@param legend legend title
#'@param sum1 Taxanomic fieldname to summarize data level 1
#'@param sum2 Taxanomic fieldname to summarize data level 2
#'@references Otegui, J., Arino, A. H., Encinas, M. A., & Pando, F. (2013). Assessing the Primary Data Hosted by the Spanish Node of the Global Biodiversity Information Facility (GBIF). PLoS ONE, 8(1), e55144. doi:10.1371/journal.pone.0055144
#'@export
#'@examples \dontrun{
#'taxotree(inat)
#'}
taxotree <- function(indf,n=30,title=NA,legend=NA,sum1="Family",sum2="Genus"){
  if(!is.element(sum1,names(indf))){
    cat(paste("Field",sum1," not found in dataset \n"))
    return()
  }
  if(!is.element(sum2,names(indf))){
    cat(paste("Field",sum2," not found in dataset \n"))
    return()
  }
  if (!is.na(title)) {
    title2 <- title
  } else {
    title2 <- paste("Records per",sum1)
  }
  if (!is.na(legend)) {
    legend2 <- legend
  } else {
    legend2 <- paste("Number of",sum2)
  }
  sql1=paste("select",sum1,",",sum2,",count(*) as Recs from indf group by ",sum1,",",sum2 )
  tab1=(sqldf(sql1))
  sql2=paste("select",sum1,",count(*) as Gnum, sum(Recs) as Rec1 from tab1 group by ",sum1,"order by Rec1")
  tab2=sqldf(sql2)
  tab2=tail(tab2,n)
  treemap(tab2, index=c(sum1), vSize="Rec1", vColor="Gnum", type="value",
          title=title2, title.legend=legend2)
}