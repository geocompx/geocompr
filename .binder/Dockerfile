FROM rockerdev/binder:3.6.3
LABEL maintainer='Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
# install the r-spatial stack
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars', 'tmap'))"
RUN R -e "remotes::install_github('nowosad/spData)"
RUN R -e "remotes::install_github('nowosad/spDataLarge)"
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



