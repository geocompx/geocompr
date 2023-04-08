FROM geocompr/geocompr
RUN su rstudio && \
  cd /home/rstudio && \
  wget https://github.com/geocompx/geocompr/archive/main.zip && \
  unzip main.zip && \
  mv geocompr-main /home/rstudio/geocompr && \
  cd geocompr && \
  Rscript -e 'bookdown::render_book("index.Rmd", output_format = "bookdown::gitbook", clean = FALSE)'
RUN chown -Rv rstudio /home/rstudio/geocompr 
