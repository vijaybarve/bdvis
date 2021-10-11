
# `bdvis`

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/bdvis)](https://cran.r-project.org/package=bdvis)
[![Rdoc](https://www.rdocumentation.org/badges/version/bdvis/)](https://www.rdocumentation.org/packages/bdvis/)
[![DOI](https://zenodo.org/badge/11777972.svg)](https://zenodo.org/badge/latestdoi/11777972)

## About 
Biodiversity Data Visualizations using R. This package offers a set of
functions to visualize biodiversity occurrence data through R. Please check the 
paper describing the package Barve, V., and J. Otegui. 2016. bdvis: visualizing biodiversity data in R. Bioinformatics:btw333.  https://academic.oup.com/bioinformatics/article/32/19/3049/2196391

The development of the package started as a Google Summer of Code project.

### Installation

```r
install.packages("bdvis") 
require(bdvis) 
```

### Packages `bdvis` suggests 
(for the purpose of building examples) 
+ [rinat] (https://github.com/ropensci/rinat)


### Functions currently available

For the sake of examples, we will work with some data obtained using the package
`rinat`

```r 
install.packages("rinat") 
require(rinat)  # Data download might take some time
inat <- get_inat_obs_project("reptileindia") 
inat <- format_bdvis(inat,source='rinat')
inat <- inat[,c("id","Date_collected", "Latitude", "Longitude", 
                "Scientific_name", "Cell_id", "Centi_cell_id")]
```

#### bdsummary

```r
bdsummary(inat) 
```

#### mapgrid

```r 
mapgrid(inat,ptype="records",bbox=c(60,100,5,40),region=c("India")) 
mapgrid(inat,ptype="records",bbox=c(60,100,5,40),region=c("India"),gridscale=0.1) 
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
comp=bdcomplete(inat,recs=5)
mapgrid(comp,ptype="complete",bbox=c(60,100,5,40),region=c("India"))
```

#### distrigraph

```r 
distrigraph(inat,ptype="cell",col="tomato") 
distrigraph(inat,ptype="species",ylab="Species") 
distrigraph(inat,ptype="efforts",col="red") 
distrigraph(inat,ptype="efforts",col="red",type="s") 
distrigraph(inat,ptype="efforts",col="red",cumulative=T,type="l")
distrigraph(inat,ptype="effortspecies",col="red",cumulative=T,type="l")
``` 

#### bdcalendarheat

```r 
bdcalendarheat(inat) 
```
