oi = readLines("our-impact.md")
oi = oi[grepl("^- ", oi)]
oi = gsub(" - ", ",", oi)
oi = gsub("^- ", "", oi)
oi = gsub("^- ", "", oi)
grep(pattern = ",Problem", oi)
(sc = stringr::str_count(string = oi, pattern = ","))
oi[sc > 3]
oi[sc < 3]
grep("idea,", oi)
grep("Question,", oi, ignore.case = T)
oi[sc > 3] = gsub("names,idea,", "names,", oi[sc > 3])
oi[sc > 3] = gsub(",Problem|,may be|,wrong|Question,", "", oi[sc > 3])
(sc = stringr::str_count(string = oi, pattern = ","))
oi[sc > 3]
oi[sc < 3]
grep(",tmap 2", oi)
oi[sc > 3] = gsub(",tmap 2", " in tmap 2", oi[sc > 3])
oi = gsub("`,q", "` q", oi)
(sc = stringr::str_count(string = oi, pattern = ","))
oi[sc > 3]
oi[sc < 3]
oi[sc < 3] = gsub(" http|: http", ",http", oi[sc < 3])
(sc = stringr::str_count(string = oi, pattern = ","))
oi[sc < 3]
oi[sc > 3]
oi[sc < 3] = gsub(" online", ",documentation", oi[sc < 3])
oi[sc < 3] = gsub("^Encouraged", "2017-05-01,Encouraged", oi[sc < 3])
oi[sc < 3] = gsub("Pull request |PR ", "or,", oi[sc < 3])
oi[sc < 3] = gsub("Question ", "question,", oi[sc < 3])
oi[sc < 3] = gsub("Updated documentation ", "documentation,", oi[sc < 3])
oi[sc < 3] = gsub("$", ",NA", oi[sc < 3])
(sc = stringr::str_count(string = oi, pattern = ","))
oi[sc < 3]
oi[sc > 3]
writeLines(oi, "our-impact.csv")
our_impact = readr::read_csv("our-impact.csv", col_names = c("date", "type","description","url"))
our_impact = read.csv("our-impact.csv", header = F)
colnames(our_impact) = c("date", "type","description","url")
readr::write_csv("our-impact.csv")
file.remove("our-impact.md")
