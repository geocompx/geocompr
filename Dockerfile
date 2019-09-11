FROM rocker/geospatial
RUN R -e "remotes::install_github('r-spatial/lwgeom')"
RUN R -e "remotes::install_github('geocompr/geocompkg')"
# install RQGIS3 from github
RUN R -e "remotes::install_github('r-spatial/RQGIS3')"
RUN apt-get update && \
  # set repos to CRAN to allow package updates
    echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site && \
  # software-properties-common contains add-apt-repository needed for ubuntugis
  # apt-get install -y gpg software-properties-common && \
  apt-get install -y gpg && \
  # install QGIS and dependencies
  sh -c 'echo "deb http://qgis.org/debian-ltr stretch main" >> /etc/apt/sources.list' && \
  sh -c 'echo "deb-src http://qgis.org/debian-ltr stretch main" >> /etc/apt/sources.list' && \
  # installing ubuntugis-unstable did not work
  # sh -c 'echo "deb http://qgis.org/ubuntugis-ltr xenial main" >> /etc/apt/sources.list' && \
  # sh -c 'echo "deb-src http://qgis.org/ubuntugis-ltr xenial main" >> /etc/apt/sources.list' && \
  # sh -c 'echo "deb http://ppa.launchpad.net/ubuntugis/ubuntugis-unstable/ubuntu xenial main" >> /etc/apt/sources.list' && \
  # add-apt-repository ppa:ubuntugis/ubuntugis-unstable && \
  wget -O - https://qgis.org/downloads/qgis-2019.gpg.key | gpg --no-tty --import && \
  gpg --export --armor --no-tty --yes 51F523511C7028C3 | apt-key add - && \
  apt-get update && apt-get install -qqy --no-install-recommends --fix-missing \
  python3-pip \
  python3-setuptools \
  python3-qgis \
  qgis \
  qgis-plugin-grass\
  # install SAGA 2.3.1
  saga \
  # install libs needed for virtual display
  vnc4server \
  xvfb && \
  # ImageMagik for animated maps - see https://www.tecmint.com/install-imagemagick-on-debian-ubuntu/
  wget https://github.com/ImageMagick/ImageMagick/archive/7.0.8-64.tar.gz && \
  tar xvzf 7.0.8-64.tar.gz && \
  cd ImageMagick-7.0.8-64/ && \
  ./configure && \ 
  make && \
  make install && \ 
  ldconfig /usr/local/lib && \
  apt-get clean && \
  # clean up a bit
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  rm -rf ImageMagick-7.0.8-64/
  echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site && \
  pip3 install pyvirtualdisplay # install virtual display for Python
RUN R -e "remotes::install_cran('magick')"
# make Python3 default for reticulate/RStudio
RUN echo "RETICULATE_PYTHON=/usr/bin/python3" >> /usr/local/lib/R/etc/Renviron 
