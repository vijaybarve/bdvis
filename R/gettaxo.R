#'gettaxo - Get higher taxonomy fields data
#'@import plyr
#'@import taxize
#'@param indf input data frame containing biodiversity data set
#'@export
#'@examples \dontrun{
#'inat=gettaxo(inat)
#'}
gettaxo <- function(indf){
  indf$Kingdom[1]=""
  indf$Phylum[1]=""
  indf$Class[1]=""
  indf$Order[1]=""
  indf$Family[1]=""
  indf$Genus[1]=""
  for(i in 1:dim(indf)[1]){
    dat <- classification(get_uid(indf$Scientific_name[i]))
    #print(dat)
    if(!is.na(dat)){
      dat1<-NULL
      dat1 <- ldply(dat, function(x) x[x$Rank %in% c("kingdome","phylum","class","order","family","genus","species"), "ScientificName"])
      dat2 <- ldply(dat, function(x) x[x$Rank %in% c("kingdome","phylum","class","order","family","genus","species"), "Rank"])
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
    }
  }
  return(indf)
}
