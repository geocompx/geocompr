FROM geocompr/geocompr:rstudio_preview
RUN R -e "remotes::install_cran('tinytest')"
# install the r-spatial stack linking to new OSGeo pkgs
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/Robinlovelace/geocompr/archive/master.zip && \
  unzip master.zip && \
  mv geocompr-master /home/rstudio/geocompr && \
  cd geocompr && \
  make html
RUN chown -Rv rstudio /home/rstudio/geocompr 
