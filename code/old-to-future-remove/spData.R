# Aim load data from spDataLarge if you cannot install the package
if(!require(spDataLarge)) {
  download.file("https://github.com/Nowosad/spDataLarge/archive/master.zip", "spDataLarge.zip")
  unzip("spDataLarge.zip")
  files_rda = list.files("spDataLarge-master/data/", full.names = TRUE)
  sapply(files_rda, load, envir = .GlobalEnv)
}
