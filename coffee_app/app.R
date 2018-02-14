# influenced by: https://rstudio.github.io/leaflet/shiny.html
library(sf)
library(shiny)
library(spData)
library(leaflet)
library(tidyverse)
world_coffee = left_join(world, coffee_data)
pal <- colorNumeric(palette = "RdYlBu", domain = c(0, 4000))

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                sliderInput("range", "Coffee Production", 0, 4000,
                            value = c(1000, 3000), step = 100
                ),
                selectInput("year", "Year", c(2016, 2017)
                ),
                checkboxInput("legend", "Show legend", FALSE)
  )
)

server <- function(input, output, session) {
  
  # This reactive expression returns a character string representing the selected variable
  yr <- reactive({
    paste0("coffee_production_", input$year)
  })
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    world_coffee$Production = world_coffee[[yr()]]
    world_coffee[world_coffee$Production >= input$range[1] & world_coffee$Production <= input$range[2], ]
  })
  
  output$map <- renderLeaflet({
    # Things that do not change go here:
    leaflet() %>% addTiles()
  })
  
  # Changes to the map performed in an observer.
  # Each thing that can change, without changing other things can have its own observer.
  observe({
    proxy <- leafletProxy("map", data = filteredData()) %>% 
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