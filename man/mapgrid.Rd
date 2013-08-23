\name{mapgrid}
\alias{mapgrid}
\title{mapgrid - Maps the data points on the map in grid format}
\usage{
  mapgrid(indf = NA, ptype = "records", bbox = NA)
}
\arguments{
  \item{indf}{input data frame containing biodiversity data
  set}

  \item{ptype}{type of map on the grid valid values are
  presence, records, species}

  \item{bbox}{Bounding box for the map in format
  c(xmin,xmax,ymin,ymax)}
}
\description{
  mapgrid - Maps the data points on the map in grid format
}
\examples{
\dontrun{
mapgrid(inat,ptype="records")
}
}

