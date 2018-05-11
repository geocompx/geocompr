## ---- echo=FALSE---------------------------------------------------------
is_on_travis = identical(Sys.getenv("TRAVIS"), "true")
is_online = curl::has_internet()

## ---- message=FALSE, eval=is_online--------------------------------------
devtools::install_github("robinlovelace/geocompr")

## ---- eval=FALSE---------------------------------------------------------
## bookdown::render_book("index.Rmd") # to build the book
## browseURL("_book/index.html") # to view it

