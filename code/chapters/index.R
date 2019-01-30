## ----index-1, echo=FALSE-------------------------------------------------
is_on_travis = identical(Sys.getenv("TRAVIS"), "true")
is_online = curl::has_internet()

## **Note**: This book has now been published by CRC Press in the [R Series](https://www.crcpress.com/Chapman--HallCRC-The-R-Series/book-series/CRCTHERSER).

## ----index-3, message=FALSE, eval=is_online------------------------------
devtools::install_github("geocompr/geocompkg")

## ----index-4, eval=FALSE-------------------------------------------------
## bookdown::render_book("index.Rmd") # to build the book
## browseURL("_book/index.html") # to view it

## ----contrib-preface, include=FALSE--------------------------------------
contributors = readr::read_csv("extdata/contributors.csv")
c_txt = contributors$name
c_url = contributors$link
c_rmd = paste0("[", c_txt, "](", c_url, ")")
contributors_text = paste0(c_rmd, collapse = ", ")

