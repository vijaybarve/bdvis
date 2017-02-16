
# `bdvis`


## About 
Biodiversity Data Visualizations using R. This package offers a set of
functions to visualize biodiversity occurrence data through R. The development
of the package started as a Google Summer of Code project. The detailed proposal
is available on [this blog
entry](http://vijaybarve.wordpress.com/2013/04/29/gsoc-proposal-2013-biodiversity-visualizations-using-r/).

## Installation
Install the latest version using `install_github` within Hadley's [devtools](https://github.com/hadley/devtools) package.

```r
install.packages("devtools") 
require(devtools)
install_github("vijaybarve/bdvis") 
require(bdvis) 
```

Note:

Windows users have to first install
[Rtools](https://cran.r-project.org/bin/windows/Rtools/).

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

### Packages `bdvis` suggests 
(for the purpose of building examples) 
+ [rinat] (https://github.com/ropensci/rinat)


### Functions currently available

For the sake of examples, we will work with some data obtained using the package
`rinat`

```r 
install.packages("rinat") 
require(rinat)  # Data download might take some time
inat=get_inat_obs_project("reptileindia") 
inat=format_bdvis(inat,source='rinat')
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
``` 

#### bdcalendarheat

```r 
bdcalendarheat(inat) 
```