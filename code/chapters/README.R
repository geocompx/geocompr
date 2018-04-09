## ---- echo = FALSE-------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "figures/"
)
is_online = curl::has_internet()

## ---- include=FALSE------------------------------------------------------
contributors = source("code/list-contributors.R")[[1]]
# save for future reference:
readr::write_csv(contributors, "extdata/contributors.csv")
# table view:
# knitr::kable(contributors, caption = "Contributors to Geocomputation with R")
# text view
contributors_text = paste0(contributors$name, collapse = ", ")

## ---- eval=is_online, message=FALSE--------------------------------------
devtools::install_github("robinlovelace/geocompr")

## ---- eval=FALSE---------------------------------------------------------
## bookdown::render_book("index.Rmd") # to build the book
## browseURL("_book/index.html") # to view it

## ---- results='hide'-----------------------------------------------------
geocompr:::generate_chapter_code()

## ------------------------------------------------------------------------
source("code/extra-pkgs.R")

## ----cranlogs, message=FALSE, warning=FALSE, fig.show='hide'-------------
source("code/cranlogs.R")
source("code/sf-revdep.R")
source("code/09-usboundaries.R")

## ---- eval=FALSE---------------------------------------------------------
## rmarkdown::render("README.Rmd", output_format = "github_document", output_file = "README.md")

## ---- echo=FALSE, message=FALSE, warning=FALSE---------------------------
source("R/generate-chapter-code.R")
book_stats = readr::read_csv("extdata/word-count-time.csv",
                             col_types=('iiDd'))

# to prevent excessive chapter count
if(Sys.Date() > max(book_stats$date) + 5) {
  book_stats_new = generate_book_stats()
  book_stats = bind_rows(book_stats, book_stats_new)
  readr::write_csv(book_stats, "extdata/word-count-time.csv")
}
book_stats = dplyr::filter(book_stats, chapter <= 13) 
library(ggplot2)
book_stats$chapter = formatC(book_stats$chapter, width = 2, format = "d", flag = "0")
book_stats$chapter = fct_rev(as.factor(book_stats$chapter))
book_stats$n_pages = book_stats$n_words / 300

## ----bookstats, warning=FALSE, echo=FALSE, fig.width=8, fig.height=4-----
ggplot(book_stats) +
  geom_area(aes(date, n_pages, fill = chapter), position = "stack") +
  ylab("Estimated number of pages") +
  xlab("Date") + 
  scale_x_date(date_breaks = "2 month",
               limits = c(min(book_stats$date), as.Date("2018-08-01")),
               date_labels = "%b %Y") +
  coord_cartesian(ylim = c(0, 300))

## ---- warning=FALSE------------------------------------------------------
geocompr:::generate_citations()

## ---- message=FALSE------------------------------------------------------
pkg_df = readr::read_csv("extdata/package_list.csv")

## ------------------------------------------------------------------------
knitr::kable(pkg_df)

