
<!-- README.md is generated from README.Rmd. Please edit that file - rmarkdown::render('README.Rmd', output_format = 'github_document', output_file = 'README.md') -->

# Geocomputation with R

<!-- badges: start -->

[![Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/robinlovelace/geocompr/main?urlpath=rstudio)
[![RstudioCloud](images/cloud.png)](https://rstudio.cloud/project/1642300)
[![Actions](https://github.com/Robinlovelace/geocompr/workflows/Render/badge.svg)](https://github.com/Robinlovelace/geocompr/actions)
[![Docker](https://img.shields.io/docker/pulls/geocompr/geocompr?style=plastic)](https://github.com/geocompr/docker/)
[![discord](https://img.shields.io/discord/878051191374876683?label=discord&logo=Discord&color=blue)](https://discord.gg/PMztXYgNxp)

<!-- [![DOI](https://zenodo.org/badge/84222786.svg)](https://zenodo.org/badge/latestdoi/84222786) -->
<!-- badges: end -->

## Introduction

This repository hosts the code underlying Geocomputation with R, a book
by [Robin Lovelace](https://www.robinlovelace.net/), [Jakub
Nowosad](https://jakubnowosad.com/), and [Jannes
Muenchow](https://github.com/jannes-m). If you find the contents useful,
please [cite
it](https://github.com/Robinlovelace/geocompr/raw/main/CITATION.bib) as
follows:

> Lovelace, Robin, Jakub Nowosad and Jannes Muenchow (2019).
> Geocomputation with R. The R Series. CRC Press.

The first version of the book has been published by [CRC
Press](https://www.crcpress.com/9781138304512) in the [R
Series](https://www.routledge.com/Chapman--HallCRC-The-R-Series/book-series/CRCTHERSER)
and can be viewed online at
[bookdown.org](https://bookdown.org/robinlovelace/geocompr/). Read the
latest version at
[geocompr.robinlovelace.net](https://geocompr.robinlovelace.net/).

### Note: we are actively working on the Second Edition 🏗

Since commencing work on the Second Edition in September 2021 much has
changed, including:

-   Replacement of `raster` with `terra` in Chapters 1 to 7 (see commits
    related to this update
    [here](https://github.com/Robinlovelace/geocompr/search?q=terra&type=commits))
-   Update of Chapter 7 to include mention alternative ways or
    reading-in OSM data in
    [\#656](https://github.com/Robinlovelace/geocompr/pull/656)
-   Refactor build settings so the book builds on Docker images in the
    [geocompr/docker](https://github.com/geocompr/docker) repo
-   Improve the experience of using the book in Binder (ideal for trying
    out the code before installing or updating the necessary R
    packages), as documented in issue
    [\#691](https://github.com/Robinlovelace/geocompr/issues/691)
    (thanks to [yuvipanda](https://github.com/yuvipanda))
-   Improved communication of binary spatial predicates in Chapter 4
    (see [\#675](https://github.com/Robinlovelace/geocompr/pull/675))
-   New section on the links between subsetting and clipping (see
    [\#698](https://github.com/Robinlovelace/geocompr/pull/698)) in
    Chapter 5
-   New
    [section](https://geocompr.robinlovelace.net/spatial-operations.html#de-9im-strings)
    on the dimensionally extended 9 intersection model (DE-9IM)
-   New [chapter](https://geocompr.robinlovelace.net/raster-vector.html)
    on raster-vector interactions split out from Chapter 5
-   New
    [section](https://geocompr.robinlovelace.net/spatial-class.html#the-sfheaders-package)
    on the **sfheaders** package
-   New
    [section](https://geocompr.robinlovelace.net/spatial-class.html#s2)
    in Chapter 2 on spherical geometry engines and the **s2** package
-   Replacement of code based on the old **mlr** package with code based
    on the new **mlr3** package, as described in a huge [pull
    request](https://github.com/Robinlovelace/geocompr/pull/771) and
    [popular
    tweet](https://twitter.com/robinlovelace/status/1516139001668898825)
    <!-- Todo: update this bullet point (Rl 2021-11) -->
    <!-- - Next issue  -->

<!-- Todo: add news file? (RL 2021-11) -->
<!-- See NEWS.md for a summary of the changes. -->

See
[https://github.com/Robinlovelace/geocompr/compare/1.9…main](https://github.com/Robinlovelace/geocompr/compare/1.9...main#files_bucket)
for a continuously updated summary of the changes to date. At the time
of writing (April 2022) there have been more than 10k lines of
code/prose added, lots of refactoring!

[![](https://user-images.githubusercontent.com/1825120/140612663-e62566a2-62ab-4a22-827a-e86f5ce7bd63.png)](https://github.com/Robinlovelace/geocompr/compare/1.9...main)

Contributions at this stage are very welcome.

## Contributing

We encourage contributions on any part of the book, including:

-   improvements to the text, e.g. clarifying unclear sentences, fixing
    typos (see guidance from [Yihui
    Xie](https://yihui.org/en/2013/06/fix-typo-in-documentation/));
-   changes to the code, e.g. to do things in a more efficient way;
-   suggestions on content (see the project’s [issue
    tracker](https://github.com/Robinlovelace/geocompr/issues));
-   improvements to and alternative approaches in the Geocompr solutions
    booklet hosted at
    [geocompr.github.io/solutions](https://geocompr.github.io/solutions/)
    (see a blog post on how to update solutions in files such as
    [\_01-ex.Rmd](https://github.com/Robinlovelace/geocompr/blob/main/_01-ex.Rmd)
    [here](https://geocompr.github.io/post/2022/geocompr-solutions/))

See
[our-style.md](https://github.com/Robinlovelace/geocompr/blob/main/misc/our-style.md)
for the book’s style.

Many thanks to all contributors to the book so far via GitHub (this list
will update automatically): [prosoitos](https://github.com/prosoitos),
[florisvdh](https://github.com/florisvdh),
[katygregg](https://github.com/katygregg),
[rsbivand](https://github.com/rsbivand),
[iod-ine](https://github.com/iod-ine),
[KiranmayiV](https://github.com/KiranmayiV),
[defuneste](https://github.com/defuneste),
[zmbc](https://github.com/zmbc),
[erstearns](https://github.com/erstearns),
[FlorentBedecarratsNM](https://github.com/FlorentBedecarratsNM),
[dcooley](https://github.com/dcooley),
[marcosci](https://github.com/marcosci),
[MikeJohnPage](https://github.com/MikeJohnPage),
[eyesofbambi](https://github.com/eyesofbambi),
[nickbearman](https://github.com/nickbearman),
[tyluRp](https://github.com/tyluRp),
[giocomai](https://github.com/giocomai),
[KHwong12](https://github.com/KHwong12),
[LaurieLBaker](https://github.com/LaurieLBaker),
[MarHer90](https://github.com/MarHer90),
[mdsumner](https://github.com/mdsumner),
[pat-s](https://github.com/pat-s),
[darrellcarvalho](https://github.com/darrellcarvalho),
[e-clin](https://github.com/e-clin), [gisma](https://github.com/gisma),
[ateucher](https://github.com/ateucher),
[annakrystalli](https://github.com/annakrystalli),
[kant](https://github.com/kant),
[gavinsimpson](https://github.com/gavinsimpson),
[Himanshuteli](https://github.com/Himanshuteli),
[yutannihilation](https://github.com/yutannihilation),
[jimr1603](https://github.com/jimr1603),
[jbixon13](https://github.com/jbixon13),
[olyerickson](https://github.com/olyerickson),
[yvkschaefer](https://github.com/yvkschaefer),
[katiejolly](https://github.com/katiejolly),
[kwhkim](https://github.com/kwhkim), [layik](https://github.com/layik),
[mpaulacaldas](https://github.com/mpaulacaldas),
[mtennekes](https://github.com/mtennekes),
[mvl22](https://github.com/mvl22),
[ganes1410](https://github.com/ganes1410),
[richfitz](https://github.com/richfitz),
[wdearden](https://github.com/wdearden),
[yihui](https://github.com/yihui),
[chihinl](https://github.com/chihinl),
[cshancock](https://github.com/cshancock),
[ec-nebi](https://github.com/ec-nebi),
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
[`our-impact.csv`](https://github.com/Robinlovelace/geocompr/blob/main/misc/our-impact.csv).

## Reproducing the book

To ease reproducibility, we created the `geocompkg` package. Installing
it from GitHub will install all the R packages needed build the book
(you will need a computer with necessary [system
dependencies](https://github.com/r-spatial/sf#installing) and the
[**remotes**](https://github.com/r-lib/remotes/) package installed):

``` r
install.packages("remotes")
# To reproduce the first Part (chapters 1 to 8):
remotes::install_github("geocompr/geocompkg")

# During development work on the 2nd edition you may also need dev versions of
# other packages to build the book, e.g.:
remotes::install_github("mtennekes/tmap")
```

Running the commands above should install the packages needed to run the
first part of the book (chapters 1 to 8). To install and build the book
in its entirety, run the following command (which installs additional
‘Suggests’ packages, this may take some time to run!):

``` r
# To reproduce all chapters (install lots of packages, may take some time!)
remotes::install_github("geocompr/geocompkg", dependencies = TRUE)
```

You need a recent version of the GDAL, GEOS, PROJ and udunits libraries
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
[mybinder.org](https://mybinder.org/v2/gh/robinlovelace/geocompr/main?urlpath=rstudio)
with an R installation that has all the dependencies needed to reproduce
the book:

[![Launch Rstudio
Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/robinlovelace/geocompr/main?urlpath=rstudio)

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
docker](https://www.docker.com/products/container-runtime/) and set-it
up on [your
computer](https://docs.docker.com/engine/install/linux-postinstall/) you
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

![](https://user-images.githubusercontent.com/1825120/39538109-9b50e7ac-4e33-11e8-93b3-e00e95a79294.png)

If you see something like this after following the steps above,
congratulations: it worked! See
[github.com/rocker-org](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image#running-rstudio-server)
for more info.

If you want to call QGIS from R, you can use the `qgis` tag, by running
the following command for example (which also shows how to set a
password and use a different port on localhost):

    docker run -d -p 8799:8787 -e USERID=$UID -e PASSWORD=strongpass -v $(pwd):/home/rstudio/geocompr robinlovelace/geocompr:qgis

From this point to *build* the book you can open projects in the
`geocompr` directory from the project box in the top-right hand corner,
and knit `index.Rmd` with the little `knit` button above the the RStudio
script panel (`Ctl+Shift+B` should do the same job).

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
source("code/01-cranlogs.R")
source("code/sf-revdep.R")
source("code/09-urban-animation.R")
source("code/09-map-pkgs.R")
```

Note: the `.Rproj` file is configured to build a website not a single
page. To reproduce this
[README](https://github.com/Robinlovelace/geocompr/blob/main/README.Rmd)
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

<table>
<thead>
<tr>
<th style="text-align:left;">
Name
</th>
<th style="text-align:left;">
Title
</th>
<th style="text-align:left;">
version
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
bookdown
</td>
<td style="text-align:left;">
Authoring Books and Technical Documents with R Markdown
</td>
<td style="text-align:left;">
0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
cartogram
</td>
<td style="text-align:left;">
Create Cartograms with R
</td>
<td style="text-align:left;">
0.1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
dismo
</td>
<td style="text-align:left;">
Species Distribution Modeling
</td>
<td style="text-align:left;">
1.1.4
</td>
</tr>
<tr>
<td style="text-align:left;">
geosphere
</td>
<td style="text-align:left;">
Spherical Trigonometry
</td>
<td style="text-align:left;">
1.5.7
</td>
</tr>
<tr>
<td style="text-align:left;">
ggmap
</td>
<td style="text-align:left;">
Spatial Visualization with ggplot2
</td>
<td style="text-align:left;">
2.6.1
</td>
</tr>
<tr>
<td style="text-align:left;">
ggplot2
</td>
<td style="text-align:left;">
Create Elegant Data Visualisations Using the Grammar of Graphics
</td>
<td style="text-align:left;">
3.0.0.9000
</td>
</tr>
<tr>
<td style="text-align:left;">
gstat
</td>
<td style="text-align:left;">
Spatial and Spatio-Temporal Geostatistical Modelling, Prediction
</td>
<td style="text-align:left;">
1.1.6
</td>
</tr>
<tr>
<td style="text-align:left;">
historydata
</td>
<td style="text-align:left;">
Datasets for Historians
</td>
<td style="text-align:left;">
0.2.9001
</td>
</tr>
<tr>
<td style="text-align:left;">
htmlwidgets
</td>
<td style="text-align:left;">
HTML Widgets for R
</td>
<td style="text-align:left;">
1.2
</td>
</tr>
<tr>
<td style="text-align:left;">
kableExtra
</td>
<td style="text-align:left;">
Construct Complex Table with ‘kable’ and Pipe Syntax
</td>
<td style="text-align:left;">
0.9.0
</td>
</tr>
<tr>
<td style="text-align:left;">
kernlab
</td>
<td style="text-align:left;">
Kernel-Based Machine Learning Lab
</td>
<td style="text-align:left;">
0.9.26
</td>
</tr>
<tr>
<td style="text-align:left;">
knitr
</td>
<td style="text-align:left;">
A General-Purpose Package for Dynamic Report Generation in R
</td>
<td style="text-align:left;">
1.20
</td>
</tr>
<tr>
<td style="text-align:left;">
latticeExtra
</td>
<td style="text-align:left;">
Extra Graphical Utilities Based on Lattice
</td>
<td style="text-align:left;">
0.6.28
</td>
</tr>
<tr>
<td style="text-align:left;">
leaflet
</td>
<td style="text-align:left;">
Create Interactive Web Maps with the JavaScript ‘Leaflet’
</td>
<td style="text-align:left;">
2.0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
link2GI
</td>
<td style="text-align:left;">
Linking Geographic Information Systems, Remote Sensing and Other
</td>
<td style="text-align:left;">
0.3.0
</td>
</tr>
<tr>
<td style="text-align:left;">
lwgeom
</td>
<td style="text-align:left;">
Bindings to Selected ‘liblwgeom’ Functions for Simple Features
</td>
<td style="text-align:left;">
0.1.4
</td>
</tr>
<tr>
<td style="text-align:left;">
mapview
</td>
<td style="text-align:left;">
Interactive Viewing of Spatial Data in R
</td>
<td style="text-align:left;">
2.4.0
</td>
</tr>
<tr>
<td style="text-align:left;">
microbenchmark
</td>
<td style="text-align:left;">
Accurate Timing Functions
</td>
<td style="text-align:left;">
1.4.4
</td>
</tr>
<tr>
<td style="text-align:left;">
mlr
</td>
<td style="text-align:left;">
Machine Learning in R
</td>
<td style="text-align:left;">
2.12.1
</td>
</tr>
<tr>
<td style="text-align:left;">
osmdata
</td>
<td style="text-align:left;">
Import ‘OpenStreetMap’ Data as Simple Features or Spatial
</td>
<td style="text-align:left;">
0.0.7
</td>
</tr>
<tr>
<td style="text-align:left;">
pROC
</td>
<td style="text-align:left;">
Display and Analyze ROC Curves
</td>
<td style="text-align:left;">
1.12.1
</td>
</tr>
<tr>
<td style="text-align:left;">
ranger
</td>
<td style="text-align:left;">
A Fast Implementation of Random Forests
</td>
<td style="text-align:left;">
0.10.1
</td>
</tr>
<tr>
<td style="text-align:left;">
raster
</td>
<td style="text-align:left;">
Geographic Data Analysis and Modeling
</td>
<td style="text-align:left;">
2.6.7
</td>
</tr>
<tr>
<td style="text-align:left;">
rcartocolor
</td>
<td style="text-align:left;">
‘CARTOColors’ Palettes
</td>
<td style="text-align:left;">
0.0.22
</td>
</tr>
<tr>
<td style="text-align:left;">
rgdal
</td>
<td style="text-align:left;">
Bindings for the ‘Geospatial’ Data Abstraction Library
</td>
<td style="text-align:left;">
1.3.3
</td>
</tr>
<tr>
<td style="text-align:left;">
rgeos
</td>
<td style="text-align:left;">
Interface to Geometry Engine - Open Source (‘GEOS’)
</td>
<td style="text-align:left;">
0.3.28
</td>
</tr>
<tr>
<td style="text-align:left;">
rgrass7
</td>
<td style="text-align:left;">
Interface Between GRASS 7 Geographical Information System and R
</td>
<td style="text-align:left;">
0.1.10
</td>
</tr>
<tr>
<td style="text-align:left;">
rmapshaper
</td>
<td style="text-align:left;">
Client for ‘mapshaper’ for ‘Geospatial’ Operations
</td>
<td style="text-align:left;">
0.4.0
</td>
</tr>
<tr>
<td style="text-align:left;">
rmarkdown
</td>
<td style="text-align:left;">
Dynamic Documents for R
</td>
<td style="text-align:left;">
1.10
</td>
</tr>
<tr>
<td style="text-align:left;">
rnaturalearth
</td>
<td style="text-align:left;">
World Map Data from Natural Earth
</td>
<td style="text-align:left;">
0.2.0
</td>
</tr>
<tr>
<td style="text-align:left;">
rnaturalearthdata
</td>
<td style="text-align:left;">
World Vector Map Data from Natural Earth Used in ‘rnaturalearth’
</td>
<td style="text-align:left;">
0.1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
RPostgreSQL
</td>
<td style="text-align:left;">
R Interface to the ‘PostgreSQL’ Database System
</td>
<td style="text-align:left;">
0.6.2
</td>
</tr>
<tr>
<td style="text-align:left;">
RQGIS
</td>
<td style="text-align:left;">
Integrating R with QGIS
</td>
<td style="text-align:left;">
1.0.3
</td>
</tr>
<tr>
<td style="text-align:left;">
RSAGA
</td>
<td style="text-align:left;">
SAGA Geoprocessing and Terrain Analysis
</td>
<td style="text-align:left;">
1.1.0
</td>
</tr>
<tr>
<td style="text-align:left;">
sf
</td>
<td style="text-align:left;">
Simple Features for R
</td>
<td style="text-align:left;">
0.6.3
</td>
</tr>
<tr>
<td style="text-align:left;">
sp
</td>
<td style="text-align:left;">
Classes and Methods for Spatial Data
</td>
<td style="text-align:left;">
1.3.1
</td>
</tr>
<tr>
<td style="text-align:left;">
spData
</td>
<td style="text-align:left;">
Datasets for Spatial Analysis
</td>
<td style="text-align:left;">
0.2.9.0
</td>
</tr>
<tr>
<td style="text-align:left;">
spDataLarge
</td>
<td style="text-align:left;">
Large datasets for spatial analysis
</td>
<td style="text-align:left;">
0.2.7.0
</td>
</tr>
<tr>
<td style="text-align:left;">
stplanr
</td>
<td style="text-align:left;">
Sustainable Transport Planning
</td>
<td style="text-align:left;">
0.2.4.9000
</td>
</tr>
<tr>
<td style="text-align:left;">
tabularaster
</td>
<td style="text-align:left;">
Tidy Tools for ‘Raster’ Data
</td>
<td style="text-align:left;">
0.5.0
</td>
</tr>
<tr>
<td style="text-align:left;">
tidyverse
</td>
<td style="text-align:left;">
Easily Install and Load the ‘Tidyverse’
</td>
<td style="text-align:left;">
1.2.1
</td>
</tr>
<tr>
<td style="text-align:left;">
tmap
</td>
<td style="text-align:left;">
Thematic Maps
</td>
<td style="text-align:left;">
2.0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
tmaptools
</td>
<td style="text-align:left;">
Thematic Map Tools
</td>
<td style="text-align:left;">
2.0.1
</td>
</tr>
<tr>
<td style="text-align:left;">
tree
</td>
<td style="text-align:left;">
Classification and Regression Trees
</td>
<td style="text-align:left;">
1.0.39
</td>
</tr>
<tr>
<td style="text-align:left;">
vegan
</td>
<td style="text-align:left;">
Community Ecology Package
</td>
<td style="text-align:left;">
2.5.2
</td>
</tr>
</tbody>
</table>
