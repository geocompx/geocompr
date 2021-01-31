FROM docker.pkg.github.com/statcan/kubeflow-containers/rstudio:b97878dc4836fd80f1bc29614cf2bc9814246d94
LABEL maintainer='Robin Lovelace'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
