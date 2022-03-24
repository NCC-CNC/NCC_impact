
# Comparison modal window
comparison_UI <- function(id) {
  ns <- NS(id)
  tagList(
    # Ghost trigger for bs modal pop-up
    hidden(numericInput(inputId = ns("ghost_trigger"), value = 0, label = '' )), 
    uiOutput(ns("compare_ui"))
  )
}

comparison_SERVER <- function(id, modal_trigger, compare_tbl, compare_plt) {
  moduleServer(id, function(input, output, session) {
    
    ns <- NS(id)
    
    observeEvent(modal_trigger() , {
      
      # Do not execute until comparison btn is clicked
      if (compare_tbl() !=0 | compare_plt() !=0) {  
        
        print(" compare button is working!")
        updateNumericInput(session = session, inputId = 'ghost_trigger', value = input$ghost_trigger + 1 )
        
        print(input$ghost_trigger)
        
        output$compare_ui <- renderUI({
          
          fluidPage(mainPanel(
            bsModal(id = ns("compare"), "Compare New Properties", "ghost_trigger", size="large",
                    tabsetPanel(
                      tabPanel("Table"),
                      tabPanel("Plots")))))
          
        })
        
      }
      
      toggleModal(session, "compare", toggle = "open")
      
    })    
    
    
  })
}