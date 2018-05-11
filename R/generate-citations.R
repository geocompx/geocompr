#' Cite R packages
#'
#' See https://github.com/csgillespie/efficientR/blob/master/appendix.Rmd
generate_citations = function() {
  desc = read.dcf("DESCRIPTION")
  headings = dimnames(desc)[[2]]
  fields = which(headings %in% c("Depends", "Imports", "Suggests"))
  pkgs = paste(desc[fields], collapse = ", ")
  pkgs = gsub("\n", " ", pkgs)
  pkgs = strsplit(pkgs, ",")[[1]]
  pkgs = gsub(" ", "", pkgs)
  pkgs = gsub("\\(.*)", "", pkgs) # Remove versions from packages
  to_install = !pkgs %in% rownames(installed.packages())
  
  if(sum(to_install) > 0){
    install.packages(pkgs[to_install])
  }
  
  i = 1
  pkgs = pkgs[order(pkgs)]
  pkgs_df = data.frame(Name = pkgs, Title = NA, cite = NA, version = NA)
  for(i in seq_along(pkgs)){
    f = system.file(package = pkgs[i], "DESCRIPTION")
    # Title is always on 3rd line
    title = readLines(f)
    title = title[grep("Title: ", title)]
    pkgs_df$Title[i] = gsub("Title: ", "", title)
    pkgs_df$cite[i] = paste0("[@R-", pkgs[i], "]")
    pkgs_df$version[i] = as.character(packageVersion(pkgs[i]))
  }
  pkgs_df[,2] = paste(pkgs_df[,2], pkgs_df[,3])
  pkgs_df = pkgs_df[,-3]
  write.csv(pkgs_df, "extdata/package_list.csv", row.names = FALSE)
  knitr::write_bib(pkgs, file="packages.bib")
}

#' Download citations
#' # Dependes on a zotero API key (e.g. stored in Sys.getenv("ZOTERO")):
#' # dl_citations(f = "refs.bib", 216746, Sys.getenv("ZOTERO"), collection = "VJS7CTCC")
dl_citations = function(f, user, collection, key = NULL) {
  if(is.null(key)) {
    req = paste0("https://www.zotero.org/api/groups/",
                 user,
                 "/collections/",
                 collection,
                 "/items/top?limit=100&format=bibtex&v=1")
    bib = httr::GET(req, httr::write_disk(f, overwrite = TRUE)) # old download method - no longer works
  } else {
    bib = RefManageR::ReadZotero(user = user, .params = list(key = key, collection = collection))
    # Get bibliography (run once from project root)
    RefManageR::WriteBib(bib = bib, file = f)
  }
}
