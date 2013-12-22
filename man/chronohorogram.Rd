\name{chronohorogram}
\alias{chronohorogram}
\title{chronohorogram - Draws a chronohorogram of records}
\usage{
  chronohorogram(indf = NA, title = NA, startyear = 0,
    endyear = 0, colors = c("red", "blue"))
}
\arguments{
  \item{indf}{- Input data frame containing biodiversity
  data set}

  \item{title}{- Title of the plot}

  \item{startyear}{- Starting year for the plot}

  \item{endyear}{- End year for the graph}

  \item{colors}{- Colors to build color ramp}
}
\description{
  chronohorogram - Draws a chronohorogram of records
}
\examples{
\dontrun{
chronohorogram(inat)
}
}

