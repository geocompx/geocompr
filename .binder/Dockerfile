# define build arguments
ARG BASE_IMAGE=rocker/binder

# define base images
FROM $BASE_IMAGE

## Declares build arguments
ARG NB_USER
ARG NB_UID

## Copies your repo files into the Docker Container
USER root


# pin the version of RStudio
ENV RSTUDIO_VERSION 1.2.5042
RUN /rocker_scripts/install_rstudio.sh

## Run an install.R script, if it exists.
RUN R -e "remotes::install_github('geocompr/geocompkg')"

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

RUN if [ -f install.R ]; then R --quiet -f install.R; fi



