## ----index-1, echo=FALSE------------------------------------------------------------------------------
is_on_ghactions = identical(Sys.getenv("GITHUB_ACTIONS"), "true")
is_online = curl::has_internet()
is_html = knitr::is_html_output()


## # Welcome {-}

## 
## This is the online home of *Geocomputation with R*, a book on geographic data analysis, visualization and modeling.

## 
## 
## <a href="https://www.crcpress.com/9781138304512"><img src="images/cover.png" width="250" height="375" alt="The geocompr book cover" align="right" style="margin: 0 1em 0 1em" /></a>

## 

## **Note**: This book has now been published by CRC Press in the [R Series](https://www.crcpress.com/Chapman--HallCRC-The-R-Series/book-series/CRCTHERSER).

## You can buy the book from [CRC Press](https://www.crcpress.com/9781138304512), [Wordery](https://wordery.com/geocomputation-with-r-robin-lovelace-9781138304512), or [Amazon](https://www.amazon.com/Geocomputation-Chapman-Hall-Robin-Lovelace/dp/1138304514/).

## 
## 
## Inspired by [**bookdown**](https://github.com/rstudio/bookdown) and the Free and Open Source Software for Geospatial ([FOSS4G](http://foss4g.org/)) movement, this book is open source.

## This ensures its contents are reproducible and publicly accessible for people worldwide.

## 
## The online version of the book is hosted at [geocompr.robinlovelace.net](https://geocompr.robinlovelace.net) and kept up-to-date by [GitHub Actions](https://github.com/Robinlovelace/geocompr/actions), which provides information on its 'build status' as follows:

## 
## [![Actions](https://github.com/Robinlovelace/geocompr/workflows/Render/badge.svg)](https://github.com/Robinlovelace/geocompr/actions)




## ## How to contribute? {-}

## 
## **bookdown** makes editing a book as easy as editing a wiki, provided you have a GitHub account ([sign-up at github.com](https://github.com/)).

## Once logged-in to GitHub, click on the 'edit me' icon highlighted with a red ellipse in the image below.

## This will take you to an editable version of the the source [R Markdown](http://rmarkdown.rstudio.com/) file that generated the page you're on:

## 
## [![](figures/editme.png)](https://github.com/Robinlovelace/geocompr/edit/main/index.Rmd)

## 
## To raise an issue about the book's content (e.g. code not running) or make a feature request, check-out the [issue tracker](https://github.com/Robinlovelace/geocompr/issues).

## 
## Maintainers and contributors must follow this repository’s [CODE OF CONDUCT](https://github.com/Robinlovelace/geocompr/blob/main/CODE_OF_CONDUCT.md).

## 
## ## Reproducibility {-}

## 
## To reproduce the code in the book, you need a recent version of [R](https://cran.r-project.org/) and up-to-date packages.

## These can be installed with the following command (which requires [**devtools**](https://github.com/hadley/devtools)):




## To build the book locally, clone or [download](https://github.com/Robinlovelace/geocompr/archive/main.zip) the [geocompr repo](https://github.com/Robinlovelace/geocompr/), load R in root directory (e.g. by opening [geocompr.Rproj](https://github.com/Robinlovelace/geocompr/blob/main/geocompr.Rproj) in RStudio) and run the following lines:


## ----index-4, eval=FALSE, echo=is_html----------------------------------------------------------------
## bookdown::render_book("index.Rmd") # to build the book
## browseURL("_book/index.html") # to view it


## ## Supporting the project {-}

## 
## If you find the book useful, please support it by:

## 
## - Telling people about it in person

## - Communicating about the book in digital media e.g. via the [#geocompr hashtag](https://twitter.com/hashtag/geocompr) on Twitter (see our [Guestbook at geocompr.github.io](https://geocompr.github.io/guestbook/)) or by letting us know of [courses](https://github.com/geocompr/geocompr.github.io/edit/source/content/guestbook/index.md) using the book

## - [Citing](https://github.com/Robinlovelace/geocompr/raw/main/cite-geocompr.bib) or [linking-to](https://geocompr.robinlovelace.net/) it

## - '[Starring](https://help.github.com/articles/about-stars/)' the [geocompr GitHub repository](https://github.com/robinlovelace/geocompr)

## - Reviewing it, e.g. on Amazon or [Goodreads](https://www.goodreads.com/book/show/42780859-geocomputation-with-r)

## - Asking questions about or making suggestion on the content via [GitHub](https://github.com/Robinlovelace/geocompr/issues/372) or Twitter.

## - [Buying](https://www.amazon.com/Geocomputation-Chapman-Hall-Robin-Lovelace/dp/1138304514/) a copy

## 
## Further details can be found at [github.com/Robinlovelace/geocompr](https://github.com/Robinlovelace/geocompr#geocomputation-with-r).

## 
## <a href="https://www.netlify.com"><img src="https://www.netlify.com/img/global/badges/netlify-color-accent.svg"/></a>

## 
## <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.


## \newpage

## 
## \vspace*{5cm}

## 
## \thispagestyle{empty}

## 
## 
## \begin{center} \Large \emph{For Katy  } \end{center}

## 
## \vspace*{2cm}

## \begin{center} \Large \emph{Dla Jagody} \end{center}

## 
## \vspace*{2cm}

## \begin{center} \Large \emph{F{\"u}r meine Katharina und alle unsere Kinder  } \end{center}


## ----contrib-preface, include=FALSE-------------------------------------------------------------------
contributors = readr::read_csv("extdata/contributors.csv")
c_txt = contributors$name
c_url = contributors$link
c_rmd = paste0("[", c_txt, "](", c_url, ")")
contributors_text = paste0(c_txt, collapse = ", ")

