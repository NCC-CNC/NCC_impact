shinyUI(
  navbarPage("NCC Project Evaluation",

  tabPanel("Tool",
  tags$head(tags$link(rel='stylesheet', type='text/css', href='styles.css')),          
  useShinyFeedback(),
  
  # Side-panel: histograms -----------------------------------------------------                
  sidebarLayout(
    sidebarPanel(class='side',
    tabsetPanel(
    tabPanel("Histograms"),
    tabPanel("Table"),
    tabPanel("Report"))),
  
   # Main-panel: map ----------------------------------------------------------- 
   mainPanel(class='main',
   # Main leaflet map, sidebars
   sidebar_tabs(id = "map_sidebar",
                list(icon("map"), icon("upload")),
                
   sidebar_pane(title = "Select Map", id = "select_map_sp",icon = icon("caret-right"),
                
                selectInput(inputId = "map_selection", "", width = '100%',
                             choices = c("Themes", "Project Management Plan")),
                wellPanel()),

   sidebar_pane(title = "Upload Project", id = "upload_sp",icon = icon("caret-right"),
                br(),
                wellPanel(),
                fileInput(inputId = "project_upload", "", width = '100%', 
                          accept = c(".shp",".dbf",".sbn",".sbx",".shx",".prj"), 
                          multiple=TRUE),
                actionButton(inputId = 'clear_project', label = "Clear Upload", width = '100%')
   )
   
   ),
   
   # Main leaflet map,
   leafletOutput(outputId = "ncc_map", height='calc(100vh - 100px)', width='100%'))
  
  # Close sidebarLayout
   )
  # Close tabPanel - Tool
  )
 # Close navbarPage
 )
# Close UI
)
