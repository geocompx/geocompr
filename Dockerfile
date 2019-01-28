FROM rocker/geospatial
RUN R -e "remotes::install_github('r-spatial/lwgeom')"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
