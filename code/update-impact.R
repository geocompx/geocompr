library(gh)
library(tidyverse)
# ?`gh-package`
# gh("/users/:username/starred", username = "hadley")
our_impact = readr::read_csv("our-impact.csv")
our_impact = select(our_impact, url, date, type, description)
v = grepl("/issues/", our_impact$url) # valid url
# our_impact$creator = NA
# our_impact$state = NA
v = v & is.na(our_impact$state)
if(is.null(our_impact$comments)) our_impact$comments = NA
# see https://developer.github.com/v3/issues/
# gh::gh("GET /repos/tidyverse/dplyr/issues/90")
# create url requests
gh_issue_req = gsub("https://github.com/", "", our_impact$url)
gh_issue_req = gsub("^", "GET /repos/", gh_issue_req)
# testing
gh::gh(gh_issue_req[1])
obj_all = lapply(gh_issue_req[v], gh)
obj_all[[1]]$user$login # test
obj_all[[1]]$comments # test
obj_all[[1]]$state # test
obj_all[[9]]$title
lubridate::as_date(obj_all[[1]]$created_at) # test
date_open = purrr::map_chr(obj_all, ~.$created_at) %>% as.Date()
state = purrr::map_chr(obj_all, ~.$state)
our_impact$date[v] = date_open
our_impact$state[v] = state
our_impact$description[v] = purrr::map_chr(obj_all, ~.$title)
our_impact$comments[v] = purrr::map_int(obj_all, ~.$comments)
our_impact$creator[v] = purrr::map_chr(obj_all, ~.$user$login)
readr::write_csv(our_impact, "our-impact.csv")

# Outdated code to convert .md to .csv ----
# oi = readLines("our-impact.md")
# oi = oi[grepl("^- ", oi)]
# oi = gsub(" - ", ",", oi)
# oi = gsub("^- ", "", oi)
# oi = gsub("^- ", "", oi)
# grep(pattern = ",Problem", oi)
# (sc = stringr::str_count(string = oi, pattern = ","))
# oi[sc > 3]
# oi[sc < 3]
# grep("idea,", oi)
# grep("Question,", oi, ignore.case = T)
# oi[sc > 3] = gsub("names,idea,", "names,", oi[sc > 3])
# oi[sc > 3] = gsub(",Problem|,may be|,wrong|Question,", "", oi[sc > 3])
# (sc = stringr::str_count(string = oi, pattern = ","))
# oi[sc > 3]
# oi[sc < 3]
# grep(",tmap 2", oi)
# oi[sc > 3] = gsub(",tmap 2", " in tmap 2", oi[sc > 3])
# oi = gsub("`,q", "` q", oi)
# (sc = stringr::str_count(string = oi, pattern = ","))
# oi[sc > 3]
# oi[sc < 3]
# oi[sc < 3] = gsub(" http|: http", ",http", oi[sc < 3])
# (sc = stringr::str_count(string = oi, pattern = ","))
# oi[sc < 3]
# oi[sc > 3]
# oi[sc < 3] = gsub(" online", ",documentation", oi[sc < 3])
# oi[sc < 3] = gsub("^Encouraged", "2017-05-01,Encouraged", oi[sc < 3])
# oi[sc < 3] = gsub("Pull request |PR ", "or,", oi[sc < 3])
# oi[sc < 3] = gsub("Question ", "question,", oi[sc < 3])
# oi[sc < 3] = gsub("Updated documentation ", "documentation,", oi[sc < 3])
# oi[sc < 3] = gsub("$", ",NA", oi[sc < 3])
# (sc = stringr::str_count(string = oi, pattern = ","))
# oi[sc < 3]
# oi[sc > 3]
# writeLines(oi, "our-impact.csv")
# our_impact = readr::read_csv("our-impact.csv", col_names = c("date", "type","description","url"))
# our_impact = read.csv("our-impact.csv", header = F)
# colnames(our_impact) = c("date", "type","description","url")
# readr::write_csv("our-impact.csv")
# file.remove("our-impact.md")


