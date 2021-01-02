#Shiny app for cycle hire from https://github.com/Robinlovelace/geocompr/issues/584
# Author - Kiranmayi Vadlamudi
#25th Dec 2020

library(pacman)
p_load(sf, shiny, spData, leaflet, tidyverse, spDataLarge, units)

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
  input_pt = reactive({matrix(c(input$y, input$x), nrow = 1, ncol=2, dimnames = list(c("r1"), c("X", "Y")))})
  
  data = reactive({
      cycle_hire$dist = st_point(input_pt()) %>%  
        st_sfc() %>% 
        st_set_crs(4326) %>% 
        st_distance(cycle_hire$geometry) %>%
        t() %>% 
        set_units(.,"km")
    
      cycle_hire[order(cycle_hire$dist),]
    })
    
  filteredData = reactive({
     filter(data(), nbikes > input$num) %>% head(5)

   })
  icons = awesomeIcons(icon = "bicycle", library = "fa", squareMarker = TRUE, markerColor = "blue")
  
  #plotting the leaflet map
  output$map = renderLeaflet({
      filteredData() %>% 
        mutate(popup = str_c(str_c("Station:", name, sep=" "),
                                     str_c("Available bikes:", nbikes, sep=" "), sep = "<br/>")) %>% 
        leaflet() %>% 
        addTiles() %>%
        setView(lng = input_pt()[, "X"], input_pt()[, "Y"], zoom = 15) %>% 
        addAwesomeMarkers(icon = icons, popup = ~popup) %>% 
        addMarkers(lng = input_pt()[, "X"], input_pt()[, "Y"], label = "Your Location")
    })
}
# Run the application
shinyApp(ui = ui, server = server)  