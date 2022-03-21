shinyUI(
  navbarPage(
    "NCC Project Evaluation",
    tabPanel(
      "Tool",
      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
      useShinyFeedback(),
      useShinyjs(),

      # Side-panel:-------------------------------------------------------------
      sidebarLayout(
        sidebarPanel(class = "side",
          tabsetPanel(
            tabPanel("Overview",#-----------------------------------------------
            br(),
            wellPanel(random_text(nwords = 150))),
            
          tabPanel("Table",#----------------------------------------------------
            br(),
            property_title_UI(id = "property_mod1"),
            pmp_table_UI(id = "pmp_table_mod1"), width="100%"),

            tabPanel("Plots", #-------------------------------------------------
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
                plotlyOutput("Lakes",height=100,width="100%"),
                plotOutput("SAR",height=100,width="100%"),
                plotOutput("Birds",height=100,width="100%")))))),            
            
            tabPanel("Report",#-------------------------------------------------
              br(),
              wellPanel(random_text(nwords = 75)),
              actionButton("view_report", "View Report", width = "100%")),
          
          tabPanel("Engagement",#------------------------------------------------
                   br(),
                   wellPanel(random_text(nwords = 75))),
          
            
            # Logo always on bottom of side panel
            img(class='logo', src='logos/stacked_logo_rgb_en.png')
          
          # Close tabsetPanel    
          )
        # Close sidebarPanel    
        ),

        # Main-panel: map ------------------------------------------------------
        mainPanel(
          class = "main",

          # Main leaflet map,
          leafletOutput(outputId = "ncc_map", height = "calc(100vh - 100px)", width = "100%"),
          
          # Main leaflet map, sidebars------------------------------------------
          sidebar_tabs(
            id = "map_sidebar",
            list(icon("upload")),
            
            # Upload shapefile
            sidebar_pane(
              title = "New Property Assesment", id = "upload_sp", icon = icon("caret-right"),
              br(),
              wellPanel(random_text(nwords = 75)),
              fluidRow(column(9,
              fileInput(label = NULL, 
                buttonLabel = tags$div("Upload", style = "width: 90px"),        
                inputId = "pmp_upload", "", width = "100%",
                accept = c(".shp", ".dbf", ".sbn", ".sbx", ".shx", ".prj"),
                multiple = TRUE)),
              column(3,
              actionButton(inputId = "clear_project", label = "Clear", width = "100%"))),
              
              hr(),
              extractions_UI(id = "extractions_mod1"),
              br(),br(),
              actionButton(inputId = "download", label = "Download Property", width = "100%"),
              
              )
          ),

          # Raster tiles panel--------------------------------------------------
          tags$div(
            class = "raster-controls",
            h4(class = "raster-title", "Impact Themes"),
            selectInput(
              inputId = "raster_selection", "", width = "100%",
              choices = c("No Selection" = F, "Forest %" = "forest", "Grassland" = "grassland", 
                          "Wetland" = "wetland", "River" = "river", "Lakes" = "Lakes")))          
        # Close mainPanel  
        )
      # Close sidebarLayout
      )
    # Close tabPanel - Tool
    )
  # Close navbarPage
  )
# Close UI
)
