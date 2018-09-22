
# `bdvis`

Note: this is a fork of the original [repo](https://github.com/vijaybarve/bdvis), containing tools for interactive analysis.

### Installation

```r
devtools::install_github("boyanangelov/bdvis")
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
distrigraph(inat,ptype="efforts",col="red",cumulative=T,type="l")
distrigraph(inat,ptype="effortspecies",col="red",cumulative=T,type="l")
```

#### bdcalendarheat

```r
bdcalendarheat(inat)
```

#### run_gui

If you are more comfortable with a Graphical User Interface (GUI), you can use this function.

```r
run_gui()
```
