#' Return details of issues, with input an GitHub issue URL
#' 
#' @examples \dontrun{
#' url_issue = "https://github.com/mtennekes/tmap/issues/196"
#' geocompr:::add_impact(url_issue)
#' u = "https://github.com/Robinlovelace/geocompr/raw/master/our-impact.csv"
#' geocompr:::add_impact(url_issue, url_old_impact = u)
#' }
add_impact = function(url_issue, vars = c("created_at", "type", "title", "comments", "state", "creator"), url_old_impact = NULL) {
  gh_issue_req = gsub("https://github.com/", "", url_issue)
  gh_issue_req = gsub("^", "GET /repos/", gh_issue_req)
  res_gh = gh::gh(gh_issue_req)
  # which ones are hard? (Will need to add to this list...)
  hard = "type|creator"
  vars_hard = vars[grepl(pattern = hard, x = vars)]
  vars_easy = vars[!grepl(pattern = hard, x = vars)]
  
  res_easy = lapply(vars_easy, function(x) res_gh[[x]])
  res_hard = rep(list(NA_character_), length(vars_hard))
  names(res_hard) = vars_hard
  names(res_easy) = vars_easy
  
  ne = names(res_easy) # names of easy ones (for future reference)
  if("created_at" %in% ne) {
    res_easy[["created_at"]] = as.Date(res_easy[["created_at"]])
  }
  if("type" %in% vars_hard) {
    res_hard[["type"]] = "issue"
  }
  if("creator" %in% vars_hard) {
    res_hard[["creator"]] = res_gh$user$login
  }
  res_all = c(res_easy, res_hard)
  res_df = data.frame(res_all[vars])
  
  if(!is.null(url_old_impact)) {
    new_impact = c(url = url_issue, res_df)
    u = "https://github.com/Robinlovelace/geocompr/raw/master/our-impact.csv"
    our_impact = readr::read_csv(u)
    names(our_impact)
    names(new_impact)
    names(new_impact) = names(our_impact)
    suppressWarnings({
      our_impact_new = dplyr::bind_rows(our_impact, new_impact)
    })
    readr::write_csv(our_impact_new, "our-impact.csv")
    message(paste0("Wrote new impact to our-impact.csv:"))
    message(write.csv(res_df))
  } else {
    res_df
  }
}
