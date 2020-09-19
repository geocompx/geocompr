FROM rocker/binder
LABEL maintainer='Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
USER root
# RUN mkdir /var/lib/apt/lists/partial

# RUN wget https://github.com/geocompr/geocompkg/raw/master/DESCRIPTION
# Auto-get sysreqs
# RUN Rscript -e "remotes::install_github('r-hub/sysreqs')" \
  # && sysreqs=$(Rscript -e "cat(sysreqs::sysreq_commands('DESCRIPTION', 'linux-x86_64-ubuntu-gcc'))") \
  # && sudo -s eval "$sysreqs"
# manually selected list of installs without huge QGIS dependencies:
RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y update && apt-get install -y pandoc pandoc-citeproc libxml2-dev libgmp-dev libglpk-dev make libgeos-dev libgeos++-dev jags gdal-bin libgdal-dev libgsl-dev libglu1-mesa-dev unixodbc-dev libproj-dev libpq-dev imagemagick libpng-dev libudunits2-dev zlib1g-dev libssl-dev libcurl4-openssl-dev libv8-dev default-jre-headless libssh2-1-dev libjq-dev libcairo2-dev protobuf-compiler libprotoc-dev libprotobuf-dev

# RUN apt install -y r-cran-tidyverse r-cran-bh
# install the r-spatial stack
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars', 'tmap'))"
RUN R -e "remotes::install_github('nowosad/spData')"
RUN R -e "remotes::install_github('nowosad/spDataLarge')"
RUN R -e "remotes::install_github('mtennekes/tmaptools')"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN wget https://github.com/robinlovelace/geocompr/archive/master.zip
RUN unzip master.zip
# COPY * /home/rstudio
RUN cp -Rv geocompr-master /home/jovyan/geocompr
RUN chown -Rv jovyan /home/jovyan
USER ${NB_USER}



