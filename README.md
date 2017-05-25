<!-- README.md is generated from README.Rmd. Please edit that file - rmarkdown::render('README.Rmd', output_format = 'md_document', output_file = 'README.md') -->
Geocomputation with R
=====================

[![Build Status](https://travis-ci.org/Robinlovelace/geocompr.svg?branch=master)](https://travis-ci.org/Robinlovelace/geocompr) [![Gitter](https://badges.gitter.im/geocompr/lobby.svg)](https://gitter.im/geocompr/Lobby)

Introduction
============

This repository hosts the code underlying Geocomputation with R, a book by [Robin Lovelace](http://robinlovelace.net/) and [Jakub Nowosad](https://nowosad.github.io/).

The online version of the book will be developed in the open. We plan to publish the hard copy of the book with CRC Press in 2018.

Contributing
------------

We encourage contributions on any part of the book, including:

-   Improvements to the text, e.g. clarifying unclear sentences, fixing typos (see guidance from [Yihui Xie](https://yihui.name/en/2013/06/fix-typo-in-documentation/)).
-   Changes to the code, e.g. to do things in a more efficient way.
-   Suggestions on content (see the project's [issue tracker](https://github.com/Robinlovelace/geocompr/issues) and the [work-in-progress](https://github.com/Robinlovelace/geocompr/tree/master/work-in-progress) folder for chapters in the pipeline).

Please see [style.md](https://github.com/Robinlovelace/geocompr/blob/master/style.md) for the book's style.

Reproducing the book
--------------------

To ease reproducibility, this book is also a package. Installing it from GitHub will ensure all dependencies are available on your computer (you need [**devtools**](https://github.com/hadley/devtools)):

``` r
devtools::install_github("robinlovelace/geocompr")
#> Downloading GitHub repo robinlovelace/geocompr@master
#> from URL https://api.github.com/repos/robinlovelace/geocompr/zipball/master
#> Installing geocompr
#> Downloading GitHub repo nowosad/spData@master
#> from URL https://api.github.com/repos/nowosad/spData/zipball/master
#> Installing spData
#> '/usr/lib/R/bin/R' --no-site-file --no-environ --no-save --no-restore  \
#>   --quiet CMD INSTALL  \
#>   '/tmp/RtmpcoH1sN/devtools5bf9388ec893/Nowosad-spData-3c08b43'  \
#>   --library='/home/robin/R/x86_64-pc-linux-gnu-library/3.4'  \
#>   --install-tests
#> 
#> '/usr/lib/R/bin/R' --no-site-file --no-environ --no-save --no-restore  \
#>   --quiet CMD INSTALL  \
#>   '/tmp/RtmpcoH1sN/devtools5bf95b4e13c3/Robinlovelace-geocompr-e467f5f'  \
#>   --library='/home/robin/R/x86_64-pc-linux-gnu-library/3.4'  \
#>   --install-tests
#> 
```

You need a recent version of the GDAL, GEOS, Proj.4 and UDUNITS libraries installed for this to work on Mac and Linux. See the **sf** package's [README](https://github.com/edzer/sfr) for information on that.

Once the dependencies have been installed you should be able to build and view a local version the book with:

``` r
bookdown::render_book("index.Rmd") # to build the book
browseURL("_book/index.html") # to view it
```

Note: the `.Rproj` file is configured to build a website not a single page. To reproduce this [README](https://github.com/Robinlovelace/geocompr/blob/master/README.Rmd) use the following command:

``` r
rmarkdown::render("README.Rmd", output_format = "md_document", output_file = "README.md")
```

Book statistics
---------------

An indication of the book's progress over time is illustrated below (to be updated roughly every week as the book progresses).

![](README_files/figure-markdown_github/bookstats-1.png)

Book statistics: estimated number of pages per chapter over time.

Package citations
-----------------

To cite packages used in this book we use code from [Efficient R Programming](https://csgillespie.github.io/efficientR/):

``` r
geocompr:::generate_citations()
#> Warning in citation(pkg, auto = if (pkg == "base") NULL else TRUE): no date
#> field in DESCRIPTION file of package 'spData'
#> Warning in citation(pkg, auto = if (pkg == "base") NULL else TRUE): could
#> not determine year for 'spData' from package DESCRIPTION file
```

This generates .bib and .csv files containing the packages. The current list of files used is as follows:

``` r
pkg_df = readr::read_csv("extdata/package_list.csv")
#> Parsed with column specification:
#> cols(
#>   Name = col_character(),
#>   Title = col_character(),
#>   version = col_character()
#> )
knitr::kable(pkg_df)
```

| Name           | Title                                                                         | version |
|:---------------|:------------------------------------------------------------------------------|:--------|
| bookdown       | Authoring Books and Technical Documents with R Markdown \[@R-bookdown\]       | 0.4     |
| dismo          | Species Distribution Modeling \[@R-dismo\]                                    | 1.1.4   |
| gstat          | Spatial and Spatio-Temporal Geostatistical Modelling, Prediction \[@R-gstat\] | 1.1.5   |
| mapview        | Interactive Viewing of Spatial Objects in R \[@R-mapview\]                    | 2.0.1   |
| microbenchmark | Accurate Timing Functions \[@R-microbenchmark\]                               | 1.4.2.1 |
| raster         | Geographic Data Analysis and Modeling \[@R-raster\]                           | 2.5.8   |
| sf             | Simple Features for R \[@R-sf\]                                               | 0.4.3   |
| spData         | Datasets for spatial analysis packages \[@R-spData\]                          | 0.1.20  |
| tidyverse      | Easily Install and Load 'Tidyverse' Packages \[@R-tidyverse\]                 | 1.1.1   |
| tmap           | Thematic Maps \[@R-tmap\]                                                     | 1.10    |
