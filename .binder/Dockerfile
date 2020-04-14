FROM rockerdev/binder:3.6.3
LABEL maintainer='Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
RUN R -e "remotes::install_github('geocompr/geocompkg')"
USER ${NB_USER}



