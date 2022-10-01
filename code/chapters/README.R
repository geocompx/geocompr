## ---- echo = FALSE----------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "figures/"
)
is_online = curl::has_internet()


## ----contributors, include=FALSE--------------------------------------------------------------------------------------------------------------------------
contributors = source("code/list-contributors.R")[[1]]
# save for future reference:
readr::write_csv(contributors, "extdata/contributors.csv")
# table view:
# knitr::kable(contributors, caption = "Contributors to Geocomputation with R")
# text view
c_txt = contributors$name
c_url = contributors$link
c_rmd = paste0("[", c_txt, "](", c_url, ")")
contributors_text = paste0(c_rmd, collapse = ", ")


## ----readme-install-github, eval=FALSE--------------------------------------------------------------------------------------------------------------------
## install.packages("remotes")
## # To reproduce the first Part (chapters 1 to 8):
## remotes::install_github("geocompr/geocompkg")


## ----readme-install-github-2, message=FALSE, eval=FALSE, results='hide'-----------------------------------------------------------------------------------
## # To reproduce all chapters (install lots of packages, may take some time!)
## remotes::install_github("geocompr/geocompkg", dependencies = TRUE)


## ----readme-render-book, eval=FALSE-----------------------------------------------------------------------------------------------------------------------
## bookdown::render_book("index.Rmd") # to build the book
## browseURL("_book/index.html") # to view it


## ----gen-code, results='hide', echo=FALSE, eval=FALSE-----------------------------------------------------------------------------------------------------
## geocompkg:::generate_chapter_code()


## ----extra-pkgs, message=FALSE, eval=FALSE----------------------------------------------------------------------------------------------------------------
## source("code/extra-pkgs.R")


## ----source-readme, eval=FALSE----------------------------------------------------------------------------------------------------------------------------
## source("code/01-cranlogs.R")
## source("code/sf-revdep.R")
## source("code/09-urban-animation.R")
## source("code/09-map-pkgs.R")


## ----render-book, eval=FALSE------------------------------------------------------------------------------------------------------------------------------
## rmarkdown::render("README.Rmd", output_format = "github_document", output_file = "README.md")


## ----scripts,  eval=FALSE, echo=FALSE---------------------------------------------------------------------------------------------------------------------
## # We aim to make every script in the `code` folder reproducible.
## # To check they can all be reproduced run the following:
## # Aim: test reproducibility of scripts
## script_names = list.files("code", full.names = T)
## avoid = "pkgs|anim|us|saga|sliver|tsp|parti|polycent|cv|svm|data|location|eco|rf|cran|hex"
## dontrun = grepl(avoid, script_names)
## script_names = script_names[!dontrun]
## counter = 0
## for(i in script_names[45:length(script_names)]) {
##   counter = counter + 1
##   print(paste0("Script number ", counter, ": ", i))
##   source(i)
## }


## ----gen-stats, echo=FALSE, message=FALSE, warning=FALSE, eval=FALSE--------------------------------------------------------------------------------------
## # source("code/generate-chapter-code.R")
## book_stats = readr::read_csv("extdata/word-count-time.csv",
##                              col_types=('iiDd'))
## 
## # to prevent excessive chapter count
## if(Sys.Date() > max(book_stats$date) + 5) {
##   book_stats_new = geocompkg:::generate_book_stats()
##   book_stats = bind_rows(book_stats, book_stats_new)
##   readr::write_csv(book_stats, "extdata/word-count-time.csv")
## }
## book_stats = dplyr::filter(book_stats, chapter <= 15)
## library(ggplot2)
## book_stats$chapter = formatC(book_stats$chapter, width = 2, format = "d", flag = "0")
## book_stats$chapter = fct_rev(as.factor(book_stats$chapter))
## book_stats$n_pages = book_stats$n_words / 300


## ----bookstats, warning=FALSE, echo=FALSE, fig.width=8, fig.height=5, eval=FALSE--------------------------------------------------------------------------
## ggplot(book_stats) +
##   geom_area(aes(date, n_pages, fill = chapter), position = "stack") +
##   ylab("Estimated number of pages") +
##   xlab("Date") +
##   scale_x_date(date_breaks = "2 month",
##                limits = c(min(book_stats$date), as.Date("2018-10-01")),
##                date_labels = "%b %Y") +
##   coord_cartesian(ylim = c(0, 350))


## ----gen-cite, warning=FALSE------------------------------------------------------------------------------------------------------------------------------
# geocompkg:::generate_citations()


## ----pkg_df, message=FALSE--------------------------------------------------------------------------------------------------------------------------------
pkg_df = readr::read_csv("extdata/package_list.csv")

