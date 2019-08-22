FROM rocker/binder:3.6.0
LABEL maintainer='Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN wget https://github.com/robinlovelace/geocompr/raw/master/DESCRIPTION && R -e "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl'); devtools::install_deps()"

RUN rm DESCRIPTION.1
