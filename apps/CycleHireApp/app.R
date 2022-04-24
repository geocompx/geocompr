#Shiny app for cycle hire from https://github.com/Robinlovelace/geocompr/issues/584
# Author - Kiranmayi Vadlamudi
#25th Dec 2020

pkgs = c("sf", "shiny", "spData", "leaflet", "tidyverse", "spDataLarge", "units")
invisible(lapply(pkgs, library, character.only = TRUE))

# Based on input coordinates finding the nearest bicycle points
ui <- fluidPage(
  
  # Application title
  titlePanel("Closest available cycle in London"),
  
  # Numerio Input from User
  fluidRow (
    column(3,numericInput("x", ("Enter x-coordinate of your location"), value = 51.5000000, step = 0.0000001)),
    column(3, numericInput("y", ("Enter y-coordinate of your location"), value = -0.1000000 , step = 0.0000001)),
    column(4, numericInput("num", "How many cycles are you looking for?", value  =1, step  =1))
  ),
  
  # Where leaflet map will be rendered
  fluidRow(
    leafletOutput("map", height= 500)
  )
)

server <- function(input, output) {
  #centring the leaflet map onto london - use if needed
  map_centre = matrix(c(-0.2574846,51.4948089), nrow=1, ncol=2, dimnames = list(c("r1"), c("X", "Y")))
  
  #based on input coords calculating top 5 closest stations to be displayed 
  
  #making reactive object of input location coordinates
  input_pt = reactive({matrix(c(input$y, input$x), nrow = 1, ncol=2, dimnames = list(c("r1"), c("X", "Y")))})
  #rendering the output map showing the input coordinates
  output$map = renderLeaflet({
    leaflet() %>% 
      addTiles() %>%
      setView(lng = input_pt()[, "X"], input_pt()[, "Y"], zoom = 15)
  })
  
  #Findind the top distance between input coordinates and all other cycle stations, then sorting them.
  data = reactive({
    cycle_hire$dist = st_point(input_pt()) %>%  
      st_sfc() %>% 
      st_set_crs(4326) %>% 
      st_distance(cycle_hire$geometry) %>%
      t() %>% 
      set_units(.,"km")
    
    cycle_hire[order(cycle_hire$dist),]
  })
  
  #Filtering the distance data from above to show top 5 closest stations meeting requirement of # of bikes needed  
  filteredData = reactive({
    filter(data(), nbikes >= input$num) %>% head(5) %>% 
      mutate(popup = str_c(str_c("Station:", name, sep=" "),
                           str_c("Available bikes:", nbikes, sep=" "), sep = "<br/>"))
    
  })
  
  #Making changes to the output leaflet map reflecting the cycle stations found above
  icons = awesomeIcons(icon = "bicycle", library = "fa", squareMarker = TRUE, markerColor = "blue")
  
  observe({
    proxy = leafletProxy("map", data =filteredData()) %>% clearMarkers()
    
    proxy %>%
      clearMarkers() %>% 
      addAwesomeMarkers(icon = icons, popup = ~popup) %>% 
      addMarkers(lng = input_pt()[, "X"], input_pt()[, "Y"], label = "Your Location")
    
  })
}
# Run the application
shinyApp(ui = ui, server = server)  