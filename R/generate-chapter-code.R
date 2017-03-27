#' Extracts R code from each chapter and dumps it in the code folder
#'
generate_chapter_code = function(dir = ".", out_dir  = "code/") {
        rmd_files = list.files(path = dir, pattern = ".Rmd")
        r_files = paste0(out_dir, rmd_files)
        r_files = gsub(pattern = "Rmd", replacement = "R", r_files)
        for(i in seq_along(rmd_files)) {
                knitr::purl(input = rmd_files[i], output = r_files[i])
        }
}
