FROM rocker/binder:3.6.0
LABEL maintainer='Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN wget https://github.com/robinlovelace/geocompr/raw/master/DESCRIPTION && R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2019-08-22/')); devtools::install_deps()"

RUN rm DESCRIPTION.1
