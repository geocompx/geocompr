<!-- README.md is generated from README.Rmd. Please edit that file - rmarkdown::render('README.Rmd', output_format = 'md_document', output_file = 'README.md') -->
Geocomputation with R
=====================

Introduction
============

This repository hosts the code underlying Geocomputation with R, a book by [Robin Lovelace](http://robinlovelace.net/) and [Jakub Nowosad](https://nowosad.github.io/).

This book will be developed in the open and published by CRC Press in late 2018.

Contributing
------------

We encourage contributions on any part of the book, including:

-   Improvements to the text, e.g. clarifying unclear sentences, fixing typos.
-   Changes to the code, e.g. to do things in a more efficient way.
-   Suggestions on content (see the project's [issue tracker](https://github.com/Robinlovelace/geocompr/issues)).

Please see [style.md](https://github.com/Robinlovelace/geocompr/blob/master/style.md).

Reproducing the book
--------------------

To ease reproducibility, this book is also a package. Installing it from GitHub, will ensure all dependencies are available on your computer:

``` r
if(!require(devtools)) {
  install.packages("devtools")
} 
devtools::install_github("robinlovelace/geocompr")
```

You need a recent version of the GDAL, GEOS, Proj.4 and UDUNITS libraries installed for this to work on Mac and Linux. See the **sfr** package's [README](https://github.com/edzer/sfr) for information on that.

Book statistics
---------------

An indication of the book's progress over time is illustrated below (to be updated roughly every week as the book progresses).

``` r
ggplot(book_stats) +
        geom_area(aes(date, n_pages, fill = chapter), position = "stack") +
        ylab("Estimated number of pages")
```

![](README_files/figure-markdown_github/bookstats-1.png)

Book statistics: estimated number of pages per chapter over time.
