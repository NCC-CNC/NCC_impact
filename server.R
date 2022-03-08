shinyServer(function(input, output, session) {

  # Initialize leaflet map
  output$ncc_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      fitBounds(-141.00002, 41.68132, -52.68001, 76.59341) %>%
      addSidebar(
        id = "map_sidebar",
        options = list(position = "right", fit = FALSE)) %>%
      addMiniMap(tiles = providers$Esri.WorldStreetMap, toggleDisplay = T, 
                 position = "bottomleft")
  })

  # Close server
})
