# Aim: add new impact to our-impact.csv -----------------------------------
# Get impact details ------------------------------------------------------

url_issue = "https://github.com/mtennekes/tmap/issues/228"
new_impact = geocompkg:::add_impact(url_issue = url_issue)
new_impact
new_impact = c(url = url_issue, new_impact)

# Add to our-impact.csv ---------------------------------------------------

u = "https://github.com/Robinlovelace/geocompr/raw/main/our-impact.csv"
geocompkg:::add_impact(url_issue, url_old_impact = u)
