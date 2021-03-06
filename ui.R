shinyUI(
  navbarPage(
    "NCC Conservation Technology",
    tabPanel( class="pmp_tool",
      "Project Evaluation",
      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
      useShinyFeedback(),
      useShinyjs(),

      # Side-panel:-------------------------------------------------------------
      sidebarLayout(
        sidebarPanel(class = "side",
          ## Overview ----          
          tabsetPanel(
            tabPanel("Overview",
            br(),
            wellPanel(random_text(nwords = 150)),
            
            # Logo 
            img(class='logo', src='logos/stacked_logo_rgb_en.png')),
          
          ## Table ----     
          tabPanel("Table",
                   
           tags$div(class = "btn-compare",
                    actionButton(style = "float: right;", inputId = "compare_tbl", 
                                 label = "Compare", icon = icon("sliders-h"))),                   

            property_title_UI(id = "property_mod1"),
            pmp_table_UI(id = "pmp_table_mod1"), width="100%"),
          

          ## Plots ----  
          tabPanel("Plots", 
          br(),        
         tags$div(class= "btn-compare",
                  actionButton(style = "float: right;", inputId = "compare_plt", 
                               label = "Compare", icon = icon("sliders-h"))),                    
             
             br(),
             hidden(div(id = "conditional_plots", 
                        withSpinner(color = "#33862B", size = 1,
              tagList(
                property_title_UI(id = "property_mod2"),
                plotlyOutput("Area",height=100,width="100%"),
                plotlyOutput("Forest",height=100,width="100%"),
                plotlyOutput("Grassland",height=100,width="100%"),
                plotlyOutput("Wetland",height=100,width="100%"),
                plotlyOutput("River",height=100,width="100%"),
                plotlyOutput("Lakes",height=100,width="100%")))))),
          
          
          
          ## Engagement ----   
          tabPanel("Engagement",
                   br(),
                   wellPanel(random_text(nwords = 75)))
          
          # Close tabsetPanel    
          )
        # Close sidebarPanel    
        ),

        # Main-panel: ----------------------------------------------------------
        mainPanel(
          class = "main",

          ## NCC map ----
          leafletOutput(outputId = "ncc_map", height = "calc(100vh - 100px)", width = "100%"),
          
          ## Map sidebars-------------------------------------------------------
          sidebar_tabs(
            id = "map_sidebar",
            list(icon("upload")),
            
            ### Upload shapefile ----
            sidebar_pane(
              title = "New Property Assessment", id = "upload_sp", icon = icon("caret-right"),
              br(),
              wellPanel(random_text(nwords = 75)),
              fluidRow(column(9,
              fileInput(label = NULL, 
                buttonLabel = tags$div("Upload", icon("upload"), style = "width: 90px"),        
                inputId = "upload_pmp", "", width = "100%",
                accept = c(".shp", ".dbf", ".sbn", ".sbx", ".shx", ".prj"),
                multiple = TRUE)),
              column(3,
              actionButton(inputId = "clear_pmp", label = "Clear", width = "100%"))),
              
              hr(),
              extractions_UI(id = "extractions_mod1"),
              br(),
              report_UI(id = "report_mod1"))
             
          # Close map-upload sidebar
          ),

          # Conservation themes -------------------------------------------------
          tags$div(
            class = "raster-controls",
            h4(class = "raster-title", "Impact Themes"),
            selectInput(
              inputId = "raster_selection", "", width = "100%",
              choices = c("No Selection" = F, "Forest %" = "forest", "Grassland" = "grassland", 
                          "Wetland" = "wetland", "River" = "river", "Lakes" = "Lakes"))),
          
          # Comparison modal ---------------------------------------------------
          comparison_UI(id = "compare_mod1")
          
        # Close mainPanel  
        )
      # Close sidebarLayout
      )
    # Close tabPanel - Tool
    )
  # Close navbarPage
  )
# Close UI ----
)
