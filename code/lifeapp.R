# library(sf)
library(shiny)
library(leaflet)
library(spData)
world$geometry = world$geom
ui = fluidPage(
  sliderInput(inputId = "life", "Life expectancy", 49, 84, value = 80),
  leafletOutput(outputId = "map")
)
server = function(input, output) {
  output$map = renderLeaflet({
    leaflet() %>% addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
      addPolygons(data = world[world$lifeExp < input$life, ])})
}
shinyApp(ui, server)
