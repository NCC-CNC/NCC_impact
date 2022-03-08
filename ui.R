shinyUI(
  navbarPage("NCC Project Evaluation",

  tabPanel("Tool",
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),          
  
  # Side-panel: histograms -----------------------------------------------------                
  sidebarLayout(
    sidebarPanel(class='side',
    tabsetPanel(
    tabPanel("Histograms"),
    tabPanel("Table"),
    tabPanel("Report"))),
  
   # Main-panel: map ----------------------------------------------------------- 
   mainPanel(class='main',
   # Main leaflet map
   sidebar_tabs(id = "map_sidebar",
                list(icon("map"), icon("upload")),
                
   sidebar_pane(title = "Select Map", id = "select_map_sp",icon = icon("caret-right")),
   sidebar_pane(title = "Upload Project", id = "upload_sp",icon = icon("caret-right"))
   
   ),
   
   tags$div(class='main-map',
   leafletOutput("ncc_map", height='calc(100vh - 100px)', width='100%')))
  
  # Close sidebarLayout
   )
  # Close tabPanel - Tool
  )
 # Close navbarPage
 )
# Close UI
)