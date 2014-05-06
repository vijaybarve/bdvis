#'taxotree - Draws a treemap based on Taxonomic hierarchy of records
#'@import sqldf
#'@import treemap
#'@param indf input data frame containing biodiversity data set
#'@references Otegui, J., Arino, A. H., Encinas, M. A., & Pando, F. (2013). Assessing the Primary Data Hosted by the Spanish Node of the Global Biodiversity Information Facility (GBIF). PLoS ONE, 8(1), e55144. doi:10.1371/journal.pone.0055144
#'@export
#'@examples \dontrun{
#'taxotree(inat)
#'}
taxotree <- function(indf){
  tab1=sqldf("select Family,Genus,count(*) as Recs from indf group by Family,Genus ")
  tab2=sqldf("select Family,count(*) as Gnum, sum(Recs) as Rec1 from tab1 group by Family order by Rec1")
  tab2=tail(tab2,30)
  treemap(tab2, index=c("Family"), vSize="Rec1", vColor="Gnum", type="value",
          title="Records per family", title.legend="Number of Genus")
}