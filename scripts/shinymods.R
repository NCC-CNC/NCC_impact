
# Title of PMP
property_title_UI <- function(id) {
  ns <- NS(id)
  tagList(
    
    tags$div(class = "property-title",
    textOutput(outputId = ns("property")))
  )
} 

property_title_SERVER <- function(id, data) {
  moduleServer(id, function(input,output,session){
    
    output$property <- renderText({as.character(data$PROPERTY_N)})
    
  })
}