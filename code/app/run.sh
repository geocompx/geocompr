# to build and run this app in docker run:
docker build code/app/ -t gcr.io/shiny-geoserver/lifeapp:latest
# docker push gcr.io/shiny-geoserver/lifeapp:latest
# Run locally:
docker run --rm -p 3838:3838 gcr.io/shiny-geoserver/lifeapp:latest
# docker run --rm -p 80:80 flaviobarros/shiny-wordcloud &
