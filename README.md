<!-- README.md is generated from README.Rmd. Please edit that file - rmarkdown::render('README.Rmd', output_format = 'md_document', output_file = 'README.md') -->
Geocomputation with R
=====================

[![Build Status](https://travis-ci.org/Robinlovelace/geocompr.svg?branch=master)](https://travis-ci.org/Robinlovelace/geocompr)

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

Note: the `.Rproj` file is configured to build a website not a single page. To reproduce this [README](https://github.com/Robinlovelace/geocompr/blob/master/README.Rmd) use the following command:

``` r
rmarkdown::render("README.Rmd", output_format = "md_document", output_file = "README.md")
```

Reproducing the book
--------------------

To ease reproducibility, this book is also a package. Installing it from GitHub will ensure all dependencies are available on your computer (you need [**devtools**](https://github.com/hadley/devtools)):

``` r
devtools::install_github("robinlovelace/geocompr")
```

You need a recent version of the GDAL, GEOS, Proj.4 and UDUNITS libraries installed for this to work on Mac and Linux. See the **sf** package's [README](https://github.com/edzer/sfr) for information on that.

Once the dependencies have been installed you should be able to build and view a local version the book with:

``` r
bookdown::render_book("index.Rmd") # to build the book
browseURL("_book/index.html") # to view it
```

Book statistics
---------------

An indication of the book's progress over time is illustrated below (to be updated roughly every week as the book progresses).

![](README_files/figure-markdown_github/bookstats-1.png)

Book statistics: estimated number of pages per chapter over time.
