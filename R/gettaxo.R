#'gettaxo - Get higher taxonomy fields data
#'@import plyr
#'@import taxize
#'@import sqldf
#'@param indf input data frame containing biodiversity data set
#'@return indf with added / updated columns
#'\itemize{
#'  \item{"kingdome"}{Kingdome of the Scientific name}
#'  \item{"phylum"}{Phylum of the Scientific name}
#'  \item{"order"}{Order of the Scientific name}
#'  \item{"family"}{Family of the Scientific name}
#'  \item{"genus"}{Genus of the Scientific name}
#'}
#'@examples \dontrun{
#'inat=gettaxo(inat)
#'}
#'@export
gettaxo <- function(indf){
  indf=sqldf("select * from indf order by Scientific_name")
  indf$Kingdom[1]=""
  indf$Phylum[1]=""
  indf$Class[1]=""
  indf$Order[1]=""
  indf$Family[1]=""
  indf$Genus[1]=""
  sciname=""
  dat1<-NULL
  for(i in 1:dim(indf)[1]){
    if (!indf$Scientific_name[i]==sciname){
      dat <- classification(get_uid(indf$Scientific_name[i]))
      if(!is.na(dat)){
        dat1<-NULL
        dat1 <- ldply(dat, function(x) x[x$Rank %in% c("kingdome","phylum","class","order","family","genus","species"), "ScientificName"])
        dat2 <- ldply(dat, function(x) x[x$Rank %in% c("kingdome","phylum","class","order","family","genus","species"), "Rank"])
      }
    }
    if(!is.null(dat1)) {
      names(dat1) <- dat2
      if(!is.null(dat1)) print(dat1)
      if(!is.null(dat1$phylum)) indf$Kingdome[i] <- dat1$kingdome
      if(!is.null(dat1$phylum)) indf$Phylum[i] <- dat1$phylum
      if(!is.null(dat1$class)) indf$Class[i] <- dat1$class
      if(!is.null(dat1$order)) indf$Order[i] <- dat1$order
      if(!is.null(dat1$family)) indf$Family[i] <- dat1$family
      if(!is.null(dat1$genus)) indf$Genus[i] <- dat1$genus
    }
    sciname <- indf$Scientific_name[i] 
  }
  return(indf)
}
