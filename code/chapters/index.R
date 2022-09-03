## ----index-1, echo=FALSE----------------------------------------------------------------------------------------------------------------------------------
is_on_ghactions = identical(Sys.getenv("GITHUB_ACTIONS"), "true")
is_online = curl::has_internet()
is_html = knitr::is_html_output()


## ---- echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------
# google scholar metadata
library(metathis)
if (is_html) {
  meta() |> 
    meta_google_scholar(
      title = "Geocomputation with R",
      author = c("Robin Lovelace", "Jakub Nowosad", "Jannes Muenchow"),
      publication_date = "2019",
      isbn = "9780203730058"
    ) 
}


## # Welcome {-}

## 

## This is the online home of *Geocomputation with R*, a book on geographic data analysis, visualization and modeling.

## 

## <a href="https://www.routledge.com/9781138304512"><img src="images/cover.png" width="250" height="375" alt="The geocompr book cover" align="right" style="margin: 0 1em 0 1em" /></a>

## 

## **Note**: The first edition of the book has been published by CRC Press in the [R Series](https://www.routledge.com/Chapman--HallCRC-The-R-Series/book-series/CRCTHERSER).

## You can buy the book from [CRC Press](https://www.routledge.com/9781138304512), or [Amazon](https://www.amazon.com/Geocomputation-R-Robin-Lovelace-dp-0367670577/dp/0367670577/), and see the archived **First Edition** hosted on [bookdown.org](https://bookdown.org/robinlovelace/geocompr/).

## 

## Inspired by the Free and Open Source Software for Geospatial ([FOSS4G](https://foss4g.org/)) movement, the code and prose underlying this book are open, ensuring that the content is reproducible, transparent, and accessible.

## Hosting the source code on [GitHub](https://github.com/Robinlovelace/geocompr/) allows anyone to interact with the project by opening issues or contributing new content and typo fixes for the benefit of everyone.

## 

## [![](https://img.shields.io/github/stars/robinlovelace/geocompr?style=for-the-badge)](https://github.com/robinlovelace/geocompr)

## [![](https://img.shields.io/github/contributors/robinlovelace/geocompr?style=for-the-badge)](https://github.com/Robinlovelace/geocompr/graphs/contributors)

## 

## The online version of the book is hosted at [geocompr.robinlovelace.net](https://geocompr.robinlovelace.net) and kept up-to-date by [GitHub Actions](https://github.com/Robinlovelace/geocompr/actions).

## Its current 'build status' as follows:

## 

## [![Actions](https://github.com/Robinlovelace/geocompr/workflows/Render/badge.svg)](https://github.com/Robinlovelace/geocompr/actions)




## <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.

## 

## ## How to contribute? {-}

## 

## **bookdown** makes editing a book as easy as editing a wiki, provided you have a GitHub account ([sign-up at github.com](https://github.com/join)).

## Once logged-in to GitHub, click on the 'Edit this page' icon in the right panel of the book website.

## This will take you to an editable version of the the source [R Markdown](http://rmarkdown.rstudio.com/) file that generated the page you're on.

## 

## <!--[![](figures/editme.png)](https://github.com/Robinlovelace/geocompr/edit/main/index.Rmd)-->

## 

## To raise an issue about the book's content (e.g. code not running) or make a feature request, check-out the [issue tracker](https://github.com/Robinlovelace/geocompr/issues).

## 

## Maintainers and contributors must follow this repository’s [CODE OF CONDUCT](https://github.com/Robinlovelace/geocompr/blob/main/CODE_OF_CONDUCT.md).

## 

## ## Reproducibility {-}

## 

## The quickest way to reproduce the contents of the book if you're new to geographic data in R may be in the web browser, thanks to [Binder](https://mybinder.org/).

## Clicking on the link below should open a new window containing RStudio Server in your web browser, enabling you to open chapter files and running code chunks to test that the code is reproducible.

## 

## [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/robinlovelace/geocompr/main?urlpath=rstudio)

## 

## If you see something like the image below, congratulations, it worked!

## You can start exploring Geocomputation with R in a cloud-based environment, noting [mybinder.org user guidelines](https://mybinder.readthedocs.io/en/latest/about/user-guidelines.html)):

## 

## <!-- ![](https://user-images.githubusercontent.com/1825120/134802314-6dd368c7-f5eb-4cd7-b8ff-428dfa93954c.png) -->




## To reproduce the code in the book on your own computer, you need a recent version of [R](https://cran.r-project.org/) and up-to-date packages.

## These can be installed using the [**remotes**](https://github.com/r-lib/remotes) package.


## ----index-3, message=FALSE, eval=FALSE, echo=is_html, results='hide'-------------------------------------------------------------------------------------
## install.packages("remotes")
## remotes::install_github("geocompr/geocompkg")


## ---- echo=FALSE, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## remotes::install_github("nowosad/spData")
## remotes::install_github("nowosad/spDataLarge")
## 
## # During development work on the 2nd edition you may also need dev versions of
## # other packages to build the book, e.g.,:
## remotes::install_github("rspatial/terra")
## remotes::install_github("mtennekes/tmap")


## After installing the book's dependencies, you can rebuild the book for testing and educational purposes.

## To do this [download](https://github.com/Robinlovelace/geocompr/archive/refs/heads/main.zip) and unzip or [clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) the book's source code.

## After opening the `geocompr.Rproj` project in [RStudio](https://www.rstudio.com/products/rstudio/download/#download) (or opening the folder in another IDE such as [VS Code](https://github.com/REditorSupport/vscode-R)), you should be able to reproduce the contents with the following command:


## ----index-3-1, eval=FALSE, echo=is_html------------------------------------------------------------------------------------------------------------------
## bookdown::serve_book(".")


## ----index-3-2, echo=FALSE, include=FALSE-----------------------------------------------------------------------------------------------------------------
# is geocompkg installed?
geocompkg_is_installed = "geocompkg" %in% installed.packages()
if(!geocompkg_is_installed){
  message(
  'geocompkg not installed, run\nremotes::install_github("geocompr/geocompkg") # to install it'
  )
} 


## See the project's [GitHub repo](https://github.com/robinlovelace/geocompr#reproducing-the-book) for full details on reproducing the book.


## ## Supporting the project {-}

## 

## If you find the book useful, please support it by:

## 

## - Telling people about it in person

## - Communicating about the book in digital media, e.g., via the [#geocompr hashtag](https://twitter.com/hashtag/geocompr) on Twitter (see our [Guestbook at geocompr.github.io](https://geocompr.github.io/guestbook/)) or by letting us know of [courses](https://github.com/geocompr/geocompr.github.io/edit/source/content/guestbook/index.md) using the book

## - [Citing](https://github.com/Robinlovelace/geocompr/raw/main/CITATION.bib) or [linking-to](https://geocompr.robinlovelace.net/) it

## - '[Starring](https://help.github.com/articles/about-stars/)' the [geocompr GitHub repository](https://github.com/robinlovelace/geocompr)

## - Reviewing it, e.g., on Amazon or [Goodreads](https://www.goodreads.com/book/show/42780859-geocomputation-with-r)

## - Asking questions about or making suggestion on the content via [GitHub](https://github.com/Robinlovelace/geocompr/issues/372) or Twitter.

## - [Buying](https://www.amazon.com/Geocomputation-R-Robin-Lovelace-dp-0367670577/dp/0367670577) a copy

## 

## Further details can be found at [github.com/Robinlovelace/geocompr](https://github.com/Robinlovelace/geocompr#geocomputation-with-r).

## 

## <hr>

## 

## The globe icon used in this book was created by [Jean-Marc Viglino](https://github.com/Viglino) and is licensed under [CC-BY 4.0 International](https://github.com/Viglino/font-gis/blob/main/LICENSE-CC-BY.md).

## 

## <a href="https://www.netlify.com"><img src="https://www.netlify.com/img/global/badges/netlify-color-accent.svg"/></a>


## \newpage

## 

## \vspace*{5cm}

## 

## \thispagestyle{empty}

## 

## \begin{center} \Large \emph{For Katy  } \end{center}

## 

## \vspace*{2cm}

## \begin{center} \Large \emph{Dla Jagody} \end{center}

## 

## \vspace*{2cm}

## \begin{center} \Large \emph{F{\"u}r meine Katharina und alle unsere Kinder  } \end{center}


## ----contrib-preface, include=FALSE-----------------------------------------------------------------------------------------------------------------------
contributors = readr::read_csv("extdata/contributors.csv")
c_txt = contributors$name
c_url = contributors$link
c_rmd = paste0("[", c_txt, "](", c_url, ")")
contributors_text = paste0(c_txt, collapse = ", ")

