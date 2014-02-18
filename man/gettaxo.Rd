\name{gettaxo}
\alias{gettaxo}
\title{gettaxo - Get higher taxonomy fields data}
\usage{
  gettaxo(indf)
}
\arguments{
  \item{indf}{input data frame containing biodiversity data
  set}
}
\value{
  indf with added / updated columns \itemize{
  \item{"kingdom"}{Kingdom of the Scientific name}
  \item{"phylum"}{Phylum of the Scientific name}
  \item{"order"}{Order of the Scientific name}
  \item{"family"}{Family of the Scientific name}
  \item{"genus"}{Genus of the Scientific name} }
}
\description{
  gettaxo - Get higher taxonomy fields data
}
\examples{
\dontrun{
inat=gettaxo(inat)
}
}

