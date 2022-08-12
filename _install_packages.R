install.packages('rcartocolor')
install.packages("terra")
install.packages("spData")
install.packages("spDataLarge", repos = "https://nowosad.r-universe.dev")
install.packages('rmapshaper')
install.packages('kableExtra')
install.packages('rnaturalearth')
install.packages("rnaturalearthdata")
install.packages('cartogram')
# To reproduce all chapters (install lots of packages, may take some time!)
remotes::install_github("geocompr/geocompkg", dependencies = TRUE) # already installed!???

# Ch12
install.packages(c('future', 'lgr', 'mlr3', 'mlr3learners', 'mlr3spatiotempcv', 
                   'mlr3tuning', 'mlr3viz', 'progressr'))
#install.packages('mlr3extralearners')
remotes::install_github("mlr-org/mlr3extralearners") # 1:ALL
install.packages('pROC')
install.packages('kernlab')
# Ch13
install.packages(c('sfnetworks', 'stplanr', 'tidygraph'))
# Ch14
install.packages('osmdata')
# Ch15
install.packages(c('ranger', 'vegan', 'tree'))
# install.packages('qgisprocess')
remotes::install_github("paleolimbot/qgisprocess")

install.packages('pct')
