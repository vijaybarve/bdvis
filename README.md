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
+ [maps] (http://cran.r-project.org/web/packages/maps/index.html)
+ [sqldf] (http://cran.r-project.org/web/packages/sqldf/index.html)
+ [plotrix] (http://cran.r-project.org/web/packages/plotrix/index.html)
+ [treemap] (http://cran.r-project.org/web/packages/treemap/index.html)
+ [plyr] (http://cran.r-project.org/web/packages/plyr/index.html)
+ [taxize] (http://cran.r-project.org/web/packages/taxize/index.html)
+ [ggplot2] (http://cran.r-project.org/web/packages/ggplot2/index.html)
+ [grid] (http://cran.r-project.org/web/packages/grid/)
+ [lattice] (http://cran.r-project.org/web/packages/lattice/)
+ [chron] (http://cran.r-project.org/web/packages/chron/)

For examples
+ [rinat] (https://github.com/ropensci/rinat)


### Functions currently available

Preapre some data using package ````riNat````

```r
#install_github("rinat", "vijaybarve")
require(rinat)
# Data downlaod might take some time
inat=get_inat_obs_project("indianmoths") 
inat=fixstr(inat,DateCollected="Observed.on",SciName="Scientific.name")
inat=getcellid(inat)
```

#### bdsummary

```r
bdsummary(inat)
```

#### mapgrid

```r
mapgrid(inat,ptype="records",bbox=c(60,100,5,40))
```

#### tempolar
```r
tempolar(inat, color="green", title="iNaturalist daily", plottype="r", timescale="d")
tempolar(inat, color="blue", title="iNaturalist weekly", plottype="p", timescale="w")
tempolar(inat, color="red", title="iNaturalist monthly", plottype="r", timescale="m")
```
#### taxotree

```r
inat=gettaxo(inat)
taxotree(inat)
```

#### chronohorogram

```r
chronohorogram(inat)
```

#### bdcomplete

```r
bdcomplete(inat)
```

#### datasubset

```r
inat1=datasubset(inat,minyear=2000, maxyear=2014)
```

#### format_bdvis

```r
inat=format_bdvis(inat)
```

#### distrigraph

```r
distrigraph(inat2,type="cell")
distrigraph(inat2,type="species")
distrigraph(inat2,type="efforts",col="red)
```"
#### bdcalenderheat

```r
bdcalenderheat(inat)
```
