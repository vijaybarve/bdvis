\name{fixstr}
\alias{fixstr}
\title{fixstr - Fix structure of the data frame to match the key fields to GBIF style
 data fireld names}
\usage{
  fixstr(indf, Latitude = NA, Longitude = NA,
    DateCollected = NA, datefmt = NA, SciName = NA)
}
\arguments{
  \item{indf}{input data frame containing biodiversity data
  set}

  \item{Latitude}{name of Latitude field in original data
  frame}

  \item{Longitude}{name of Longitude field in original data
  frame}

  \item{DateCollected}{name of Date Collected field in
  original data frame}

  \item{datefmt}{format string for the original date field
  \link[base]{strptime}}

  \item{SciName}{name of Scientific Name field in original
  data frame}
}
\description{
  fixstr - Fix structure of the data frame to match the key
  fields to GBIF style data fireld names
}
\examples{
\dontrun{

}
}

