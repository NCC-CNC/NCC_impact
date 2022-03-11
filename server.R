shinyServer(function(input, output, session) {

  # Get inputs -----------------------------------------------------------------
  # Map
  user_map <- reactive({
    as.character(input$map_selection)
  })
  
  # Basemap
  user_basemap <- reactive({
    as.character(input$basemap_selection)
  })
  
  # Initialize leaflet map -----------------------------------------------------
  output$ncc_map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldStreetMap) %>%
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
      
      leafletProxy("ncc_map") %>%
        clearGroup("pmp") %>%
        addPolygons(data = PMP_sub,
                    layerId = ~id,
                    group = "pmp",
                    fillColor = "#33862B",
                    color = "black",
                    weight = 1,
                    fillOpacity = 0.7,
                    label = ~htmlEscape(NAME),
                    popup = PMP_popup(PMP_sub),
                    highlightOptions = highlightOptions(weight = 3, color = '#00ffd9'))
      
      
      # PMP selection
      observeEvent(input$ncc_map_shape_click, {
        
        print(input$ncc_map_shape_click$id)
        shinyjs::show(id = "conditionalPanel")
        
        user_pmp <- PMP_tmp %>% dplyr::filter(id== as.numeric(input$ncc_map_shape_click$id))
        output$property <- renderText({as.character(user_pmp$PROPERTY_N)})
        output$Forest <- plot_consvar("Forest", user_pmp, "ha")
        output$Grassland <- plot_consvar("Grassland", user_pmp, "ha")
        output$Wetland <- plot_consvar("Wetland", user_pmp, "ha")
        output$River <- plot_consvar("River", user_pmp, "km")
        output$Lakes <- plot_consvar("Lakes", user_pmp, "ha")
      })
    
  }
  })  
  
  # Update basemap ---------------------------------------------------------
  observe({
    leafletProxy('ncc_map') %>%
      clearTiles() %>%
      addProviderTiles(user_basemap())
  })

  # Close server
})
