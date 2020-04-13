FROM rockerdev/geospatial:3.6.3
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		software-properties-common \
                ed \
		less \
		locales \
		vim-tiny \
		wget \
		ca-certificates \
  && add-apt-repository --enable-source --yes "ppa:marutter/rrutter3.5" \
	&& add-apt-repository --enable-source --yes "ppa:marutter/c2d4u3.5" \ 
	&& add-apt-repository --enable-source --yes "ppa:ubuntugis/ubuntugis-unstable" 
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
 		 libudunits2-dev libgdal-dev libgeos-dev libproj-dev liblwgeom-dev
RUN R -e "remotes::install_cran('tinytest')"
# install the r-spatial stack linking to new OSGeo pkgs
RUN R -e "install.packages(c('sf', 'lwgeom', 'rgdal', 'sp', 'stars'))"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
# RUN apt-get update && \
  # set repos to CRAN to allow package updates
 #   echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site 
