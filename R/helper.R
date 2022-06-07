
is.emptydf <- function(val){
  if(inherits(val,"data.frame")){
    if(nrow(val)==0){
      return(TRUE)
    } else {
      return(FALSE)
    }
  }
  if(is.null(val)){
    return(TRUE)
  }
  if(is.na(val)){
    return(TRUE)
  }
  return(FALSE)
}
