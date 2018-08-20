FROM rocker/geospatial
RUN R -e "remotes::install_github('geocompr/geocompkg')"
