library(shiny)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)

# Leaflet bindings are a bit slow; for now we'll just sample to compensate
set.seed(100)
#antData <- antData[sample.int(nrow(antData), 10000),]

shinyServer(function(input, output, session) {

  ## Interactive Map ###########################################

  # Create the map
  output$map <- renderLeaflet({
    leaflet() %>%
      addTiles(
        urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
        attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
      ) %>%
      setView(lng = -93.85, lat = 37.45, zoom = 4)
  })

  # A reactive expression that returns the set of points that are
  # in bounds right now
  pointsInBounds <- reactive({
    if (is.null(input$map_bounds))
      return(grid[FALSE,])
    bounds <- input$map_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)

    subset(antData,
      latitude >= latRng[1] & latitude <= latRng[2] &
        longitude >= lngRng[1] & longitude <= lngRng[2])
  })

  # This observer is responsible for maintaining the circles and legend,
  # according to the variables the user has chosen to map to color and size.
  observe({
    sizeBy <- input$size
    scales <- c(3000000,1000000,500000,300000)

    colorData <- grid[[sizeBy]]
    pal <- colorBin("Spectral", colorData, 7, pretty = FALSE)
    radius <- grid[[sizeBy]] / max(grid[[sizeBy]]) * scales[match(sizeBy,colnames(grid))]   # 300k is a good number 
    
    leafletProxy("map", data = grid) %>%
      clearShapes() %>%
      addCircles(~longitude, ~latitude, radius=radius, 
        stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData)) %>%
      addLegend("bottomleft", pal=pal, values=colorData, title=sizeBy,
        layerId="colorLegend")
  })

}
)
