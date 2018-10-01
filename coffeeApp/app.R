# Credit: build on the example in https://rstudio.github.io/leaflet/shiny.html
library(sf)
library(shiny)
library(spData)
library(leaflet)
library(tidyverse)
world_coffee = left_join(world, coffee_data)
pal = colorNumeric(palette = "RdYlBu", domain = c(0, 4000))

ui = fluidPage(
  sidebarPanel(
    sliderInput("range", "Coffee Production", 0, 4000,
                value = c(1000, 4000), step = 100),
    selectInput("year", "Year", c(2016, 2017)),
    checkboxInput("legend", "Show legend", FALSE)
  ),
  mainPanel(
    leafletOutput("map")
  )
)

server = function(input, output, session) {
  
  map_centre = st_centroid(world %>% filter(name_long == "Brazil")) %>% 
    st_coordinates()
  
  # This reactive expression returns a character string representing the selected variable
  yr = reactive({
    paste0("coffee_production_", input$year)
  })
  
  # Reactive expression for the data subset to what the user selected
  filteredData = reactive({
    world_coffee$Production = world_coffee[[yr()]]
    filter(world_coffee, Production >= input$range[1] &
                         Production <= input$range[2])
  })
  
  output$map = renderLeaflet({
    # Things that do not change go here:
    leaflet() %>% addTiles() %>%
      setView(lng = map_centre[, "X"], map_centre[, "Y"], zoom = 2)
  })
  
  # Changes to the map performed in an observer
  observe({
    proxy = leafletProxy("map", data = filteredData()) %>% 
      clearShapes()
    # Show or hide legend
    proxy %>% clearControls() %>% addPolygons(fillColor = ~pal(Production))
    if (input$legend) {
      proxy %>% addLegend(position = "bottomright",
                          pal = pal, values = ~Production)
    }
  })
}

shinyApp(ui, server)