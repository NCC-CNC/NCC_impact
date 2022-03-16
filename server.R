shinyServer(function(input, output, session) {

  # Get inputs -----------------------------------------------------------------
  # Map
  user_map <- reactive({
    as.character(input$map_selection)
  })
  
  # Conservation values (rasters)
  user_raster <- reactive({
    as.character(input$raster_selection)
  })
  
  # Initialize leaflet map -----------------------------------------------------
  output$ncc_map <- renderLeaflet({
    leaflet() %>%
      addProviderTiles(providers$Esri.WorldTopoMap, group = "Topographic") %>%
      addProviderTiles(providers$Esri.WorldImagery, group = "Imagery") %>%
      addProviderTiles(providers$Esri.WorldStreetMap, group = "Streets") %>%
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
        addMapPane("pmp_pane", zIndex = 600) %>% # Always top layer
        
        # Add project mgmt. polygon
        addPolygons(data = PMP_sub,
                    layerId = ~id, # click event id selector
                    group = "Project Mgmt. Plan",
                    fillColor = "#33862B",
                    color = "black",
                    weight = 1,
                    fillOpacity = 0.7,
                    label = ~htmlEscape(NAME),
                    popup = PMP_popup(PMP_sub), # fct_popup.R
                    options = pathOptions(pane = "pmp_pane"),
                    highlightOptions = highlightOptions(weight = 3, color = '#00ffd9')) %>%
        
        addLayersControl(overlayGroups = c("Project Mgmt. Plan"),
                         baseGroups = c("Streets", "Imagery", "Topographic"),
                         position = "bottomleft",
                         options = layersControlOptions(collapsed = F)) 
      

      # PMP selection ----------------------------------------------------------
      observeEvent(input$ncc_map_shape_click, {
        
        # Project mgmt. plan user selection
        user_pmp <- PMP_tmp %>% dplyr::filter(id== as.numeric(input$ncc_map_shape_click$id))
        
        # Generate histograms
        shinyjs::show(id = "conditional_plots")
        
        property_title_SERVER(id = "property_mod2", data=user_pmp)
        output$Area <- plot_consvar("Area_ha", user_pmp, "ha")
        output$Forest <- plot_consvar("Forest", user_pmp, "ha")
        output$Grassland <- plot_consvar("Grassland", user_pmp, "ha")
        output$Wetland <- plot_consvar("Wetland", user_pmp, "ha")
        output$River <- plot_consvar("River", user_pmp, "km")
        output$Lakes <- plot_consvar("Lakes", user_pmp, "ha")
        
        # Generate Table
        property_title_SERVER(id = "property_mod1", data=user_pmp)
        pmp_table_SERVER(id = "pmp_table_mod1", 
                         data = user_pmp,
                         row_names = species_row_names,
                         con_values = species_con_values)
      # Close map-click
      })
    
  }
  })  
  
  # Update map with conservation value -----------------------------------------
  observeEvent(user_raster(),{
    
    if(user_raster() != F) {
      
      cons_pal <- colorNumeric(palette = "viridis", c(0,100))
      leafletProxy("ncc_map") %>%
        clearGroup(group= "convalue") %>%
        addMapPane("raster_map", zIndex = 400) %>%
        addTiles(urlTemplate = paste0("tiles/", user_raster(), "/{z}/{x}/{y}.png"), 
                 options = pathOptions(pane = "raster_map"), 
                 group = "convalue") %>%
        addLegend(position = "topleft", 
                  pal = cons_pal, 
                  values = c(0,100), 
                  opacity = 1,
                  layerId = "cons_legend", 
                  className = "info legend leaflet-control sidelegend")
      
    } else {
      leafletProxy("ncc_map") %>%
        clearGroup(group= "convalue") %>%
        removeControl("cons_legend")
    }
    
  })
  
#-------------------------------------------------------------------------------
  # Close server
})
