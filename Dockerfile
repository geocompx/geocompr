FROM rocker/ropensci
RUN R -e "remotes::install_github('robinlovelace/geocompr')"
