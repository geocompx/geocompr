FROM rockerdev/binder:3.6.3
LABEL maintainer='Robin Lovelace, Jakub Nowosad, Jannes Muenchow'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}
FROM rockerdev/geospatial:3.6.3
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
		vim \
		wget \
		ca-certificates \
  && add-apt-repository --enable-source --yes "ppa:marutter/rrutter3.5" \
	&& add-apt-repository --enable-source --yes "ppa:marutter/c2d4u3.5" \ 
	&& add-apt-repository --enable-source --yes "ppa:ubuntugis/ubuntugis-unstable" 
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
 	  libudunits2-dev libgdal-dev libgeos-dev libproj-dev liblwgeom-dev
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars'))"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN R -e "remotes::install_cran('tinytest')"
RUN R -e "remotes::install_cran('tinytex')"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
# RUN unzip master.zip \
#   && cp -Rv rocker-versioned2-master/scripts /rocker_scripts
# Next lines aim to install RStudio Server preview - commented out as Binder fails to launch with these lines in there
# RUN /rocker_scripts/install_rstudio.sh RSTUDIO_VERSION=preview
# RUN wget https://s3.amazonaws.com/rstudio-ide-build/server/bionic/amd64/rstudio-server-1.3.938-amd64.deb
# RUN dpkg -i rstudio-server-*-amd64.deb
# RUN rm rstudio-server-*-amd64.deb
# RUN echo '{' >> /etc/rstudio/rstudio-prefs.json
# RUN echo '    "rmd_chunk_output_inline": false' >> /etc/rstudio/rstudio-prefs.json
# RUN echo '}' >> /etc/rstudio/rstudio-prefs.json



