#'bdsummary - description
#'@import sqldf
#'@param indf input data frame containing biodiversity data set
#'@export
#'@examples \dontrun{
#'require(rinat)
#'inat<-get_inat_obs_project("reptileindia") 
#'bdsummary(inat)
#'}
bdsummary <- function(indf){
  names(indf)=gsub("\\.","_",names(indf))
  cat(paste("\n Total no of records =",dim(indf)[1],"\n"))
  if("Date_collected" %in% colnames(indf)){
    cat(paste(" Date range of the records from ",
              range(as.Date(indf$Date_collected),na.rm=T)[1]," to ",
              range(as.Date(indf$Date_collected),na.rm=T)[2],"\n"))
  }
  cat(paste(" Bounding box of records ",min(indf$Latitude,na.rm=T),",",min(indf$Longitude,na.rm=T),
            " - ",max(indf$Latitude,na.rm=T),",",max(indf$Longitude,na.rm=T),"\n"))
  cat(paste(" Taxonomic summary... \n"))
  cat(paste(" No of Families : ",length(unique(indf$Family)),"\n"))
  cat(paste(" No of Genus : ",length(unique(indf$Genus)),"\n"))
  cat(paste(" No of Species : ",length(unique(indf$Scientific_name)),"\n"))
}
