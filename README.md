
<!-- README.md is generated from README.Rmd. Please edit that file - rmarkdown::render('README.Rmd', output_format = 'github_document', output_file = 'README.md') -->

# Geocomputation with R

<!-- badges: start -->
[![Launch Rstudio
Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/robinlovelace/geocompr/master?urlpath=rstudio)
[![Launch Rstudio
Cloud](images/cloud.png)](https://rstudio.cloud/project/1642300)
[![Actions](https://github.com/Robinlovelace/geocompr/workflows/Render-Book-from-master/badge.svg)](https://github.com/Robinlovelace/geocompr/actions)
[![Docker](https://img.shields.io/docker/automated/robinlovelace/geocompr.svg)](https://hub.docker.com/r/robinlovelace/geocompr/builds/)
[![DOI](https://zenodo.org/badge/84222786.svg)](https://zenodo.org/badge/latestdoi/84222786)
<!-- badges: end -->

## Introduction

This repository hosts the code underlying Geocomputation with R, a book
by [Robin Lovelace](https://www.robinlovelace.net/), [Jakub
Nowosad](https://nowosad.github.io/), and [Jannes
Muenchow](http://www.geographie.uni-jena.de/en/Muenchow.html):

> Lovelace, Robin, Jakub Nowosad and Jannes Muenchow (2019).
> Geocomputation with R. The R Series. CRC Press.

This book has been published by [CRC
Press](https://www.crcpress.com/9781138304512) in the [R
Series](https://www.crcpress.com/Chapman--HallCRC-The-R-Series/book-series/CRCTHERSER).
The online version of this book is free to read at
<https://geocompr.robinlovelace.net/>.

## Contributing

We encourage contributions on any part of the book, including:

-   improvements to the text, e.g. clarifying unclear sentences, fixing
    typos (see guidance from [Yihui
    Xie](https://yihui.name/en/2013/06/fix-typo-in-documentation/));
-   changes to the code, e.g. to do things in a more efficient way; and
-   suggestions on content (see the project’s [issue
    tracker](https://github.com/Robinlovelace/geocompr/issues)).

See
[our-style.md](https://github.com/Robinlovelace/geocompr/blob/master/our-style.md)
for the book’s style.

Many thanks to all contributors to the book so far via GitHub (this list
will update automatically): [prosoitos](https://github.com/prosoitos),
[florisvdh](https://github.com/florisvdh),
[katygregg](https://github.com/katygregg),
[rsbivand](https://github.com/rsbivand),
[KiranmayiV](https://github.com/KiranmayiV),
[erstearns](https://github.com/erstearns),
[zmbc](https://github.com/zmbc),
[eyesofbambi](https://github.com/eyesofbambi),
[nickbearman](https://github.com/nickbearman),
[tyluRp](https://github.com/tyluRp),
[giocomai](https://github.com/giocomai),
[LaurieLBaker](https://github.com/LaurieLBaker),
[mdsumner](https://github.com/mdsumner),
[pat-s](https://github.com/pat-s), [gisma](https://github.com/gisma),
[ateucher](https://github.com/ateucher),
[annakrystalli](https://github.com/annakrystalli),
[DarrellCarvalho](https://github.com/DarrellCarvalho),
[kant](https://github.com/kant),
[gavinsimpson](https://github.com/gavinsimpson),
[Henrik-P](https://github.com/Henrik-P),
[Himanshuteli](https://github.com/Himanshuteli),
[yutannihilation](https://github.com/yutannihilation),
[jbixon13](https://github.com/jbixon13),
[yvkschaefer](https://github.com/yvkschaefer),
[katiejolly](https://github.com/katiejolly),
[KHwong12](https://github.com/KHwong12),
[layik](https://github.com/layik),
[mtennekes](https://github.com/mtennekes),
[mvl22](https://github.com/mvl22),
[ganes1410](https://github.com/ganes1410),
[richfitz](https://github.com/richfitz),
[SymbolixAU](https://github.com/SymbolixAU),
[wdearden](https://github.com/wdearden),
[yihui](https://github.com/yihui),
[chihinl](https://github.com/chihinl),
[cshancock](https://github.com/cshancock),
[gregor-d](https://github.com/gregor-d),
[jasongrahn](https://github.com/jasongrahn),
[p-kono](https://github.com/p-kono),
[pokyah](https://github.com/pokyah),
[schuetzingit](https://github.com/schuetzingit),
[sdesabbata](https://github.com/sdesabbata),
[tim-salabim](https://github.com/tim-salabim),
[tszberkowitz](https://github.com/tszberkowitz).

During the project we aim to contribute ‘upstream’ to the packages that
make geocomputation with R possible. This impact is recorded in
[`our-impact.csv`](https://github.com/Robinlovelace/geocompr/blob/master/our-impact.csv).

## Reproducing the book

To ease reproducibility, we created the `geocompkg` package. Installing
it from GitHub will install all the R packages needed build the book
(you will a computer with necessary [system
dependencies](https://github.com/r-spatial/sf#installing) and the
[**remotes**](https://github.com/r-lib/remotes/) package installed):

``` r
install.packages("remotes")
remotes::install_github("geocompr/geocompkg")
```

You need a recent version of the GDAL, GEOS, PROJ and UDUNITS libraries
installed for this to work on Mac and Linux. See the **sf** package’s
[README](https://github.com/r-spatial/sf) for information on that.

Once the dependencies have been installed you should be able to build
and view a local version the book with:

``` r
bookdown::render_book("index.Rmd") # to build the book
browseURL("_book/index.html") # to view it
```

<!-- The code associated with each chapter is saved in the `code/chapters/` folder. -->
<!-- `source("code/chapters/07-transport.R")` runs run the code chunks in chapter 7, for example. -->
<!-- These R scripts are generated with the follow command which wraps `knitr::purl()`: -->

## Geocompr in binder

For many people the quickest way to get started with Geocomputation with
R is in your web browser via Binder. To see an interactive RStudio
Server instance click on the following button, which will open
[mybinder.org](https://mybinder.org/v2/gh/robinlovelace/geocompr/master?urlpath=rstudio)
with an R installation that has all the dependencies needed to reproduce
the book:

[![Launch Rstudio
Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/robinlovelace/geocompr/master?urlpath=rstudio)

You can also have a play with the repo in RStudio Cloud by clicking on
this link (requires log-in):

[![Launch Rstudio
Cloud](images/cloud.png)](https://rstudio.cloud/project/1642300)

## Geocomputation with R in a Docker container

To ease reproducibility we have made Docker images available, at
[geocompr/geocompr](https://hub.docker.com/r/geocompr/geocompr/) on
DockerHub. These images allow you to explore Geocomputation with R in a
virtual machine that has up-to-date dependencies.

After you have [installed
docker](https://www.docker.com/community-edition#/download) and set-it
up on [your
computer](https://docs.docker.com/install/linux/linux-postinstall/) you
can start RStudio Server without a password (see the [Rocker
project](https://www.rocker-project.org/use/managing_users/) for info on
how to add a password and other security steps for public-facing
servers):

``` sh
docker run -p 8787:8787 -e DISABLE_AUTH=TRUE geocompr/geocompr
```

If it worked you should be able to open-up RStudio server by opening a
browser and navigating to <http://localhost:8787/> resulting in an
up-to-date version of R and RStudio running in a container.

Start a plain R session running:

``` sh
docker run -it geocompr/geocompr R
```

See the
[geocompr/docker](https://github.com/geocompr/docker#geocomputation-with-r-in-docker)
repo for details, including how to share volumes between your computer
and the Docker image, for using geographic R packages on your own data
and for information on available tags.

## Reproducing this README

To reduce the book’s dependencies, scripts to be run infrequently to
generate input for the book are run on creation of this README.

The additional packages required for this can be installed as follows:

``` r
source("code/extra-pkgs.R")
```

With these additional dependencies installed, you should be able to run
the following scripts, which create content for the book, that we’ve
removed from the main book build to reduce package dependencies and the
book’s build time:

``` r
source("code/cranlogs.R")
source("code/sf-revdep.R")
source("code/08-urban-animation.R")
source("code/08-map-pkgs.R")
```

Note: the `.Rproj` file is configured to build a website not a single
page. To reproduce this
[README](https://github.com/Robinlovelace/geocompr/blob/master/README.Rmd)
use the following command:

``` r
rmarkdown::render("README.Rmd", output_format = "github_document", output_file = "README.md")
```

<!-- ## Book statistics -->
<!-- An indication of the book's progress over time is illustrated below (to be updated roughly every week as the book progresses). -->
<!-- Book statistics: estimated number of pages per chapter over time. -->

## Citations

To cite packages used in this book we use code from [Efficient R
Programming](https://csgillespie.github.io/efficientR/):

``` r
# geocompkg:::generate_citations()
```

This generates .bib and .csv files containing the packages. The current
of packages used can be read-in as follows:

``` r
pkg_df = readr::read_csv("extdata/package_list.csv")
```

Other citations are stored online using Zotero.

If you would like to add to the references, please use Zotero, join the
[open group](https://www.zotero.org/groups/418217/energy-and-transport)
add your citation to the open [geocompr
library](https://www.zotero.org/groups/418217/energy-and-transport/items/collectionKey/9K6FRP6N).

We use the following citation key format:

    [auth:lower]_[veryshorttitle:lower]_[year]

This can be set from inside Zotero desktop with the Better Bibtex plugin
installed (see
[github.com/retorquere/zotero-better-bibtex](https://github.com/retorquere/zotero-better-bibtex))
by selecting the following menu options (with the shortcut `Alt+E`
followed by `N`), and as illustrated in the figure below:

    Edit > Preferences > Better Bibtex

![](figures/zotero-settings.png)

Zotero settings: these are useful if you want to add references.

We use Zotero because it is a powerful open source reference manager
that integrates well with the **citr** package. As described in the
GitHub repo
[Robinlovelace/rmarkdown-citr-demo](https://github.com/Robinlovelace/rmarkdown-citr-demo).

## References

``` r
# remotes::install_github("gadenbuie/regexplain")
# regexplain::regexplain_file("extdata/package_list.csv")
pattern = " \\[[^\\}]*\\]" # perl=TRUE
pkg_df$Title = gsub(pattern = pattern, replacement = "", x = pkg_df$Title, perl = TRUE)
knitr::kable(pkg_df)
```

| Name              | Title                                                            | version    |
|:------------------|:-----------------------------------------------------------------|:-----------|
| bookdown          | Authoring Books and Technical Documents with R Markdown          | 0.7        |
| cartogram         | Create Cartograms with R                                         | 0.1.0      |
| dismo             | Species Distribution Modeling                                    | 1.1.4      |
| geosphere         | Spherical Trigonometry                                           | 1.5.7      |
| ggmap             | Spatial Visualization with ggplot2                               | 2.6.1      |
| ggplot2           | Create Elegant Data Visualisations Using the Grammar of Graphics | 3.0.0.9000 |
| gstat             | Spatial and Spatio-Temporal Geostatistical Modelling, Prediction | 1.1.6      |
| historydata       | Datasets for Historians                                          | 0.2.9001   |
| htmlwidgets       | HTML Widgets for R                                               | 1.2        |
| kableExtra        | Construct Complex Table with ‘kable’ and Pipe Syntax             | 0.9.0      |
| kernlab           | Kernel-Based Machine Learning Lab                                | 0.9.26     |
| knitr             | A General-Purpose Package for Dynamic Report Generation in R     | 1.20       |
| latticeExtra      | Extra Graphical Utilities Based on Lattice                       | 0.6.28     |
| leaflet           | Create Interactive Web Maps with the JavaScript ‘Leaflet’        | 2.0.1      |
| link2GI           | Linking Geographic Information Systems, Remote Sensing and Other | 0.3.0      |
| lwgeom            | Bindings to Selected ‘liblwgeom’ Functions for Simple Features   | 0.1.4      |
| mapview           | Interactive Viewing of Spatial Data in R                         | 2.4.0      |
| microbenchmark    | Accurate Timing Functions                                        | 1.4.4      |
| mlr               | Machine Learning in R                                            | 2.12.1     |
| osmdata           | Import ‘OpenStreetMap’ Data as Simple Features or Spatial        | 0.0.7      |
| pROC              | Display and Analyze ROC Curves                                   | 1.12.1     |
| ranger            | A Fast Implementation of Random Forests                          | 0.10.1     |
| raster            | Geographic Data Analysis and Modeling                            | 2.6.7      |
| rcartocolor       | ‘CARTOColors’ Palettes                                           | 0.0.22     |
| rgdal             | Bindings for the ‘Geospatial’ Data Abstraction Library           | 1.3.3      |
| rgeos             | Interface to Geometry Engine - Open Source (‘GEOS’)              | 0.3.28     |
| rgrass7           | Interface Between GRASS 7 Geographical Information System and R  | 0.1.10     |
| rmapshaper        | Client for ‘mapshaper’ for ‘Geospatial’ Operations               | 0.4.0      |
| rmarkdown         | Dynamic Documents for R                                          | 1.10       |
| rnaturalearth     | World Map Data from Natural Earth                                | 0.2.0      |
| rnaturalearthdata | World Vector Map Data from Natural Earth Used in ‘rnaturalearth’ | 0.1.0      |
| RPostgreSQL       | R Interface to the ‘PostgreSQL’ Database System                  | 0.6.2      |
| RQGIS             | Integrating R with QGIS                                          | 1.0.3      |
| RSAGA             | SAGA Geoprocessing and Terrain Analysis                          | 1.1.0      |
| sf                | Simple Features for R                                            | 0.6.3      |
| sp                | Classes and Methods for Spatial Data                             | 1.3.1      |
| spData            | Datasets for Spatial Analysis                                    | 0.2.9.0    |
| spDataLarge       | Large datasets for spatial analysis                              | 0.2.7.0    |
| stplanr           | Sustainable Transport Planning                                   | 0.2.4.9000 |
| tabularaster      | Tidy Tools for ‘Raster’ Data                                     | 0.5.0      |
| tidyverse         | Easily Install and Load the ‘Tidyverse’                          | 1.2.1      |
| tmap              | Thematic Maps                                                    | 2.0.1      |
| tmaptools         | Thematic Map Tools                                               | 2.0.1      |
| tree              | Classification and Regression Trees                              | 1.0.39     |
| vegan             | Community Ecology Package                                        | 2.5.2      |
