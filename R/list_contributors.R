# Filename: list_contributors.R (2018-03-16)
#
# TO DO: List all geocompr contributors
#
# Author(s): Jannes Muenchow
#
#**********************************************************
# CONTENTS-------------------------------------------------
#**********************************************************
#
# 1. ATTACH PACKAGES AND DATA
# 2. CONTRIBUTOR LIST
#
#**********************************************************
# 1 ATTACH PACKAGES AND DATA-------------------------------
#**********************************************************

# attach packages
library("dplyr")
library("stringr")

#**********************************************************
# 2 CONTRIBUTOR LIST---------------------------------------
#**********************************************************

# git has to be in PATH
grepl("git", Sys.getenv("PATH"))
# cmd = "git log | grep Author: | sort | uniq"
# cmd = "git shortlog -sn -e"
cmd = "git log"
out = system(cmd, intern = TRUE)
out = unique(grep("Author: ", out, value = TRUE))
out = gsub("Author: ", "", out)
email = stringr::str_extract_all(out, "<.*?>")
name = gsub("<.*", "", out)
out = data.frame(cbind(name, email))
# remove book authors
out = dplyr::filter(out, !grepl("robin|jannes|jn|jakub|nowosad", tolower(name)))
dplyr::filter(out, !duplicated(name))
