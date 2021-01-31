FROM rocker/binder:4.0.0
LABEL maintainer='Robin Lovelace'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
