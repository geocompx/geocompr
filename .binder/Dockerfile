FROM rocker/binder:3.6.3
LABEL maintainer='Robin Lovelace'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

