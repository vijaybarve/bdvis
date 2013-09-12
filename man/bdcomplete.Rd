\name{bdcomplete}
\alias{bdcomplete}
\title{bdcomplete - Computes completeness values for cells (currently returns Chao2 index)}
\usage{
  bdcomplete(indf, recs = 50)
}
\arguments{
  \item{indf}{input data frame containing biodiversity data
  set}

  \item{recs}{Minimum number of records per grid cell}
}
\description{
  bdcomplete - Computes completeness values for cells
  (currently returns Chao2 index)
}
\examples{
\dontrun{
bdcomplete(inat)
}
}

