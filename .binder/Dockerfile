FROM ghcr.io/geocompx/docker:binder

## Declares build arguments
ARG NB_USER
ARG NB_UID

COPY --chown=${NB_USER} . /home/rstudio
