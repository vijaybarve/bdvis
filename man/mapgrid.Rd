% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mapgrid.R
\name{mapgrid}
\alias{mapgrid}
\title{Maps the data points on the map in grid format}
\usage{
mapgrid(
  indf = NULL,
  comp = NULL,
  ptype = "records",
  title = "",
  bbox = NA,
  legscale = 0,
  collow = "blue",
  colhigh = "red",
  mapdatabase = NULL,
  region = NULL,
  shp = NA,
  gridscale = 1,
  customize = NULL
)
}
\arguments{
\item{indf}{input data frame containing biodiversity data set}

\item{comp}{Completeness matrix generate by function \code{\link{bdcomplete}}}

\item{ptype}{Type of map on the grid. Accepted values are "presence" for 
presence/absence maps, "records" for record-density map, "species" for 
species-density map and "complete" for completeness map}

\item{title}{title for the map. There is no default title}

\item{bbox}{bounding box for the map in format c(xmin,xmax,ymin,ymax)}

\item{legscale}{Set legend scale to a higher value than the max value in the 
data}

\item{collow}{Color for lower range in the color ramp of the grid}

\item{colhigh}{Color for higher range in the color ramp of the grid}

\item{mapdatabase}{Parameter  is deprecated}

\item{region}{Parameter is deprecated. Please use shape files.}

\item{shp}{path to shapefile to load as basemap (default NA)}

\item{gridscale}{plot the map grids at scale specified. Scale needs to 
specified in decimal degrees. Default is 1 degree which is approximately 100km.}

\item{customize}{additional customization string to customize the map output 
using ggplot2 parameters}
}
\value{
No return value, called for plotting the graph
}
\description{
Customizable grid-based spatial representation of the coordinates of the 
records in the data set.
}
\details{
This function builds a grid map colored according to the density of records 
in each cell. Grids are 1-degree cells, build with the 
\code{\link{getcellid}} function. Currently, four types of maps can be 
rendered. Presence maps show only if the cell is populated or not, without 
paying attention to how many records or species are present. Record-density 
maps apply a color gradient according to the number of records in the cell, 
regardless of the number of species they represent. Species-density maps apply 
a color gradient according to the number of different species in the cell, 
regardless of how many records there are for each one of those. Completeness 
maps apply a color gradient according to the completeness index, from 0
(incomplete) to 1 (complete).

See parameter descriptions for ways of customizing the map.
}
\examples{
\dontrun{
mapgrid(inat,ptype="records", region="India")
}
}
\concept{Spatial visualizations}
