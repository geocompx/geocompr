#' Cite R packages
#' from https://github.com/csgillespie/efficientR/blob/master/appendix.Rmd
#' 
#' 
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

download_zotero_citations = function() {
        # Get bibliography (run once from project root)
        u = "https://www.zotero.org/api/groups/418217/collections/93E7I2E7/items/top?limit=100&format=bibtex&v=1"
        b = httr::GET(url = u, httr::write_disk("refs.bib", overwrite = T))
}
