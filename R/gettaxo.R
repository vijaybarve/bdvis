#'gettaxo - Get higher taxonomy fields data
#'@import plyr
#'@import taxize
#'@import sqldf
#'@param indf input data frame containing biodiversity data set
#'@param genus If true use only genus level data to get taxanomy
#'@return indf with added / updated columns
#'\itemize{
#'  \item{"kingdom"}{Kingdom of the Scientific name}
#'  \item{"phylum"}{Phylum of the Scientific name}
#'  \item{"order"}{Order of the Scientific name}
#'  \item{"family"}{Family of the Scientific name}
#'  \item{"genus"}{Genus of the Scientific name}
#'}
#'@examples \dontrun{
#'inat=gettaxo(inat)
#'}
#'@export
gettaxo <- function(indf,genus=FALSE){
  indfu=sqldf("select Scientific_name from indf group by Scientific_name order by Scientific_name")
  indfu$Kingdom[1]=""
  indfu$Phylum[1]=""
  indfu$Class[1]=""
  indfu$Order[1]=""
  indfu$Family[1]=""
  indfu$Genus[1]=""
  sciname=""
  dat1<-NULL
  for(i in 1:dim(indfu)[1]){
    if(genus){
      Scientific_name=strsplit(indfu$Scientific_name[i]," ")[[1]][1]
      if(is.na(Scientific_name)){Scientific_name=""}
    } else {
      Scientific_name=indfu$Scientific_name[i]
    }
    if (!Scientific_name==sciname){
      dat <- classification(get_uid(Scientific_name))
      if(!is.na(dat)){
        dat1<-NULL
        dat1 <- ldply(dat, function(x) x[x$rank %in% c("kingdom","phylum","class","order","family","genus","species"), "name"])
        dat2 <- ldply(dat, function(x) x[x$rank %in% c("kingdom","phylum","class","order","family","genus","species"), "rank"])
      }
    }
    if(!is.null(dat1)) {
      names(dat1) <- dat2
      if(!is.null(dat1)) print(dat1)
      if(!is.null(dat1$kingdom)) indfu$Kingdom[i] <- dat1$kingdom
      if(!is.null(dat1$phylum)) indfu$Phylum[i] <- dat1$phylum
      if(!is.null(dat1$class)) indfu$Class[i] <- dat1$class
      if(!is.null(dat1$order)) indfu$Order[i] <- dat1$order
      if(!is.null(dat1$family)) indfu$Family[i] <- dat1$family
      if(!is.null(dat1$genus)) indfu$Genus[i] <- dat1$genus
    }
    sciname <- Scientific_name
  }
  indf=sqldf("select * from indf, indfu where indf.Scientific_name = indfu.Scientific_name")
  return(indf)
}