shinyUI(
  navbarPage(
    "NCC Project Evaluation",
    tabPanel(
      "Tool",
      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
      useShinyFeedback(),
      useShinyjs(),

      # Side-panel: histograms -----------------------------------------------------
      sidebarLayout(
        sidebarPanel(class = "side",
          tabsetPanel(
            tabPanel("Overview",#-----------------------------------------------
            br(),
            wellPanel(random_text(nwords = 75))),
            
            tabPanel("Histograms", #--------------------------------------------
              br(),
              hidden(div(id = "conditional_plots",        
              withSpinner(color = "#33862B", size = 1,
              tagList(
              textOutput("property"),
              plotlyOutput("Area",height=100,width="100%"),
              plotlyOutput("Forest",height=100,width="100%"),
              plotlyOutput("Grassland",height=100,width="100%"),
              plotlyOutput("Wetland",height=100,width="100%"),
              plotlyOutput("River",height=100,width="100%"),
              plotlyOutput("Lakes",height=100,width="100%"),
              plotOutput("SAR",height=100,width="100%"),
              plotOutput("Birds",height=100,width="100%")))))),
            
            tabPanel("Table",#--------------------------------------------------
              br(),
              textOutput("property2"),
              tableOutput("pmp_table"), width="100%"),
            
            tabPanel("Report",#-------------------------------------------------
              br(),
              wellPanel(random_text(nwords = 75)),
              actionButton("view_report", "View Report", width = "100%")),
            
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
            list(icon("map"), icon("upload")),
            sidebar_pane(
              title = "Select Map", id = "select_map_sp", icon = icon("caret-right"),
              selectInput(
                inputId = "map_selection", "", width = "100%",
                choices = c("Project Management Plan","Themes")
              ),
              wellPanel(random_text(nwords = 75))
            ),
            sidebar_pane(
              title = "Upload Project", id = "upload_sp", icon = icon("caret-right"),
              br(),
              wellPanel(random_text(nwords = 75)),
              fileInput(
                inputId = "project_upload", "", width = "100%",
                accept = c(".shp", ".dbf", ".sbn", ".sbx", ".shx", ".prj"),
                multiple = TRUE),
              actionButton(inputId = "clear_project", label = "Clear Upload", width = "100%"))
          ),

          # Raster tiles panel--------------------------------------------------
          tags$div(
            class = "raster-controls",
            h4(class = "raster-title", "Cons. Values"),
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
