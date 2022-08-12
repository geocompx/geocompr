# Filename: list_contributors.R (2018-03-16)
#
# TO DO: List all geocompr contributors
#
# Author(s): Jannes Muenchow & Robin Lovelace
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
library(gh)
library(tidyverse)

#**********************************************************
# 2 CONTRIBUTOR LIST---------------------------------------
#**********************************************************

# git has to be in PATH
out_json = gh::gh(endpoint = "/repos/robinlovelace/geocompr/contributors", .limit = "Inf")
link = vapply(out_json, "[[", FUN.VALUE = "", "html_url")
name = gsub(pattern = "https://github.com/", "", link)
commits = paste0("https://github.com/Robinlovelace/geocompr/commits?author=", name)
out_df = data_frame(name, link)
# remove book authors
filter(out_df, !grepl("robin|jannes|jn|jakub|nowosad", name, TRUE)) 
