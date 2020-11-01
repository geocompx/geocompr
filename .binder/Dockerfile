# define build arguments
# based partly on https://github.com/SwissDataScienceCenter/renkulab-docker/blob/e9a1941c7b125eadf878ccdef23f962b6b0a3ebf/docker/r/Dockerfile
ARG BASE_IMAGE=rocker/geospatial

# define base images
FROM $BASE_IMAGE

## Declares build arguments
ENV NB_USER=jovyan
ARG NB_UID


# pin the version of RStudio
ENV NB_USER rstudio
ENV NB_UID 1000
ENV NB_GID 1000
ENV RSTUDIO_VERSION 1.2.5042
RUN /rocker_scripts/install_rstudio.sh
RUN /rocker_scripts/install_python.sh
RUN /rocker_scripts/install_binder.sh
CMD jupyter notebook --ip 0.0.0.0

USER root

## Copies your repo files into the Docker Container
RUN wget https://github.com/robinlovelace/geocompr/archive/master.zip
RUN unzip master.zip
RUN mv geocompr-master /home/rstudio/geocompr
# COPY * /home/rstudio
RUN chown -Rv ${NB_USER} /home/rstudio

# Set RStudio preferences
# No inline code:
RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
RUN echo '}' >> /etc/rstudio/rstudio-prefs.json

## Become normal user again
USER ${NB_USER}

## Run an install.R script, if it exists.
# RUN R -e "remotes::install_github('geocompr/geocompkg')"

RUN if [ -f install.R ]; then R --quiet -f install.R; fi



