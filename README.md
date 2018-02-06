
<!-- README.md is generated from README.Rmd. Please edit that file - rmarkdown::render('README.Rmd', output_format = 'github_document', output_file = 'README.md') -->
Geocomputation with R
=====================

[![Build Status](https://travis-ci.org/Robinlovelace/geocompr.svg?branch=master)](https://travis-ci.org/Robinlovelace/geocompr) [![](https://img.shields.io/docker/automated/robinlovelace/geocompr.svg)](https://hub.docker.com/r/robinlovelace/geocompr/builds/)

Introduction
============

This repository hosts the code underlying Geocomputation with R, a book by [Robin Lovelace](http://robinlovelace.net/), [Jakub Nowosad](https://nowosad.github.io/), and [Jannes Muenchow](http://www.geographie.uni-jena.de/en/Muenchow.html).

The online version of the book is developed at <http://geocompr.robinlovelace.net/>. We plan to publish the hard copy of the book with CRC Press in 2018.

Contributing
------------

We encourage contributions on any part of the book, including:

-   Improvements to the text, e.g. clarifying unclear sentences, fixing typos (see guidance from [Yihui Xie](https://yihui.name/en/2013/06/fix-typo-in-documentation/)).
-   Changes to the code, e.g. to do things in a more efficient way.
-   Suggestions on content (see the project's [issue tracker](https://github.com/Robinlovelace/geocompr/issues) and the [work-in-progress](https://github.com/Robinlovelace/geocompr/tree/master/work-in-progress) folder for chapters in the pipeline).

Please see [our\_style.md](https://github.com/Robinlovelace/geocompr/blob/master/our_style.md) for the book's style.

Reproducing the book
--------------------

To ease reproducibility, this book is also a package. Installing it from GitHub will ensure all dependencies to build the book are available on your computer (you need [**devtools**](https://github.com/hadley/devtools)):

``` r
devtools::install_github("robinlovelace/geocompr")
```

You need a recent version of the GDAL, GEOS, Proj.4 and UDUNITS libraries installed for this to work on Mac and Linux. See the **sf** package's [README](https://github.com/edzer/sfr) for information on that.

Once the dependencies have been installed you should be able to build and view a local version the book with:

``` r
bookdown::render_book("index.Rmd") # to build the book
browseURL("_book/index.html") # to view it
```

Reproducing this README
-----------------------

To reduce the book's dependencies, scripts to be run infrequently to generate input for the book are run on creation of this README.

The additional packages required for this can be installed as follows:

``` r
source("code/extra-pkgs.R")
```

With these additional dependencies installed, you should be able to run the following scripts, which create input figures for the book:

``` r
source("code/cranlogs.R")
source("code/sf-revdep.R")
```

Note: the `.Rproj` file is configured to build a website not a single page. To reproduce this [README](https://github.com/Robinlovelace/geocompr/blob/master/README.Rmd) use the following command:

``` r
rmarkdown::render("README.Rmd", output_format = "github_document", output_file = "README.md")
```

Book statistics
---------------

An indication of the book's progress over time is illustrated below (to be updated roughly every week as the book progresses).

![](figures/bookstats-1.png)

Book statistics: estimated number of pages per chapter over time.

Citations
---------

To cite packages used in this book we use code from [Efficient R Programming](https://csgillespie.github.io/efficientR/):

``` r
geocompr:::generate_citations()
```

This generates .bib and .csv files containing the packages. The current of packages used can be read-in as follows:

``` r
pkg_df = readr::read_csv("extdata/package_list.csv")
```

Other citations are stored online using Zotero and downloaded with:

``` r
geocompr:::dl_citations(f = "refs.bib", user = 418217, collection = "9K6FRP6N")
```

If you would like to add to the references, please use Zotero, join the [open group](https://www.zotero.org/groups/418217/energy-and-transport) add your citation to the open [geocompr library](https://www.zotero.org/groups/418217/energy-and-transport/items/collectionKey/9K6FRP6N).

References
----------

``` r
knitr::kable(pkg_df)
```

| Name              | Title                                                                                     | version    |
|:------------------|:------------------------------------------------------------------------------------------|:-----------|
| bookdown          | Authoring Books and Technical Documents with R Markdown \[@R-bookdown\]                   | 0.6        |
| dismo             | Species Distribution Modeling \[@R-dismo\]                                                | 1.1.4      |
| ggmap             | Spatial Visualization with ggplot2 \[@R-ggmap\]                                           | 2.6.1      |
| gstat             | Spatial and Spatio-Temporal Geostatistical Modelling, Prediction \[@R-gstat\]             | 1.1.5      |
| htmlwidgets       | HTML Widgets for R \[@R-htmlwidgets\]                                                     | 1.0        |
| kableExtra        | Construct Complex Table with 'kable' and Pipe Syntax \[@R-kableExtra\]                    | 0.7.0      |
| knitr             | A General-Purpose Package for Dynamic Report Generation in R \[@R-knitr\]                 | 1.19       |
| leaflet           | Create Interactive Web Maps with the JavaScript 'Leaflet' \[@R-leaflet\]                  | 1.1.0      |
| link2GI           | Linking Geographic Information Systems, Remote Sensing and Other \[@R-link2GI\]           | 0.2.0      |
| lwgeom            | Bindings to Selected 'liblwgeom' Functions for Simple Features \[@R-lwgeom\]              | 0.1.4      |
| mapview           | Interactive Viewing of Spatial Data in R \[@R-mapview\]                                   | 2.3.0      |
| microbenchmark    | Accurate Timing Functions \[@R-microbenchmark\]                                           | 1.4.4      |
| osmdata           | Import 'OpenStreetMap' Data as Simple Features or Spatial \[@R-osmdata\]                  | 0.0.5      |
| raster            | Geographic Data Analysis and Modeling \[@R-raster\]                                       | 2.6.7      |
| rgdal             | Bindings for the 'Geospatial' Data Abstraction Library \[@R-rgdal\]                       | 1.2.16     |
| rgeos             | Interface to Geometry Engine - Open Source ('GEOS') \[@R-rgeos\]                          | 0.3.26     |
| rmapshaper        | Client for 'mapshaper' for 'Geospatial' Operations \[@R-rmapshaper\]                      | 0.3.1      |
| rmarkdown         | Dynamic Documents for R \[@R-rmarkdown\]                                                  | 1.8        |
| rnaturalearth     | World Map Data from Natural Earth \[@R-rnaturalearth\]                                    | 0.1.0      |
| rnaturalearthdata | World Vector Map Data from Natural Earth Used in 'rnaturalearth' \[@R-rnaturalearthdata\] | 0.1.0      |
| RQGIS             | Integrating R with QGIS \[@R-RQGIS\]                                                      | 1.0.3      |
| RSAGA             | SAGA Geoprocessing and Terrain Analysis in R \[@R-RSAGA\]                                 | 0.94.5     |
| sf                | Simple Features for R \[@R-sf\]                                                           | 0.6.1      |
| sp                | Classes and Methods for Spatial Data \[@R-sp\]                                            | 1.2.7      |
| spData            | Datasets for Spatial Analysis \[@R-spData\]                                               | 0.2.7.3    |
| spDataLarge       | Large datasets for spatial analysis \[@R-spDataLarge\]                                    | 0.2.5.0    |
| stars             | Scalable, Spatiotemporal Tidy Arrays for R \[@R-stars\]                                   | 0.1.0      |
| stplanr           | Sustainable Transport Planning \[@R-stplanr\]                                             | 0.2.2.9999 |
| tabularaster      | Tidy Tools for 'Raster' Data \[@R-tabularaster\]                                          | 0.4.0      |
| tidyverse         | Easily Install and Load the 'Tidyverse' \[@R-tidyverse\]                                  | 1.2.1      |
| tmap              | Thematic Maps \[@R-tmap\]                                                                 | 1.11       |
