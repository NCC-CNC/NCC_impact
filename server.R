shinyServer(function(input, output, session) {

  # Get inputs -----------------------------------------------------------------
  user_map <- reactive({
    as.character(input$map_selection)
  })

  # Initialize leaflet map -----------------------------------------------------
  output$ncc_map <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      fitBounds(-141.00002, 41.68132, -52.68001, 76.59341) %>%
      addSidebar(
        id = "map_sidebar",
        options = list(position = "right", fit = FALSE)
      ) %>%
      addMiniMap(
        tiles = providers$Esri.WorldStreetMap, toggleDisplay = T,
        position = "bottomleft"
      )
  })

  # Update leaflet map ---------------------------------------------------------
  observeEvent(user_map(), {

    # Themes
    if (user_map() == "Themes") {

    }

    # Project Management Plan
    if (user_map() == "Project Management Plan") {
      leafletProxy("ncc_map")
    }
  })


  # Close server
})
