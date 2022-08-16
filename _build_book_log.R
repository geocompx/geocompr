# https://stackoverflow.com/questions/7096989/how-to-save-all-console-output-to-file-in-r
con <- file(format(Sys.time(), '_build_book_%Y%m%d_%H%M.log'))
sink(con, append = TRUE)
sink(con, append = TRUE, type='message')

source('_build_book.R', echo=TRUE, max.deparse.length=100000)

sink()
sink(type='message')

