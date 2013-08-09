# `bdvis`


## About
Biodiversity Data Visualizations using R This set of functions to visualise 
biodiversity occurrence data through R. The Detailed proposal is available
on [this blog](http://vijaybarve.wordpress.com/2013/04/29/gsoc-proposal-2013-biodiversity-visualizations-using-r/) 

## Install

### Install the development version using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```R
install.packages("devtools")
require(devtools)

install_github("bdvis", "vijaybarve")
require(bdvis)
```

Note: 

Windows users have to first install [Rtools](http://cran.r-project.org/bin/windows/Rtools/).

### Packages `bdvis` depends on
+ [maps](http://cran.r-project.org/web/packages/maps/index.html)
+ [sqldf](http://cran.r-project.org/web/packages/sqldf/index.html)
+ [plotrix](http://cran.r-project.org/web/packages/plotrix/index.html)


### Functions currently available

#### summary

```coffee
bdvis::summary(inat)
```

#### mapgrid

```coffee
mapgrid(inat,ptype="species")
```

#### tempolar
```coffee
tempolar(inat, color="green", title="iNaturalist daily", plottype="r", timescale="d")
tempolar(inat, color="blue", title="iNaturalist weekly", plottype="p", timescale="w")
tempolar(inat, color="red", title="iNaturalist monthly", plottype="r", timescale="m")
```
