FROM robinlovelace/geocompr:qgis-base
RUN R -e "remotes::install_github('r-spatial/lwgeom')"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
# install RQGIS3 from github
RUN R -e "remotes::install_github('r-spatial/RQGIS3')"
RUN apt-get update && \
  # set repos to CRAN to allow package updates
    echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site 
RUN R -e "remotes::install_cran('magick')"
# make Python3 default for reticulate/RStudio
RUN echo "RETICULATE_PYTHON=/usr/bin/python3" >> /usr/local/lib/R/etc/Renviron 
