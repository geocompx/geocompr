#' Extracts R code from each chapter and dumps it in the code folder
generate_chapter_code = function(dir = ".", out_dir  = "code/chapters/") {
  rmd_files = list.files(path = dir, pattern = ".Rmd")
  r_files = paste0(out_dir, rmd_files)
  r_files = gsub(pattern = "Rmd", replacement = "R", r_files)
  for(i in seq_along(rmd_files)) {
    knitr::purl(input = rmd_files[i], output = r_files[i])
  }
}

generate_chapter_code()

#' Generate a data frame of book statistics per chapter
generate_book_stats = function(dir = ".") {
  library(tidytext)
  library(dplyr)
  rmd_files = list.files(path = dir, pattern = ".Rmd")
  chapters = lapply(rmd_files, readLines)
  chapters = lapply(chapters, function(x) data_frame(line = 1:length(x), text = x))
  chapters[[1]] %>%
    unnest_tokens(words, text)
  n_words = sapply(chapters, function(x) nrow(unnest_tokens(x, words, text)))
  chapter = 1:length(n_words)
  date = Sys.Date()
  data_frame(n_words, chapter, date)
}
