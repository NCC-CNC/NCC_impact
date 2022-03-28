
# Comparison modal window
comparison_UI <- function(id) {
  ns <- NS(id)
  tagList(
    # Ghost trigger for bs modal pop-up
    hidden(numericInput(inputId = ns("ghost_trigger"), value = 0, label = '' )), 
    uiOutput(ns("compare_ui"))
  )
}

comparison_SERVER <- function(id, modal_trigger, compare_tbl, 
                              compare_plt, user_pmp_mean, map_click) {
  moduleServer(id, function(input, output, session) {
    
    ns <- NS(id)
    observeEvent(modal_trigger() , {
      
      # Do not execute until comparison btn is clicked
      if (compare_tbl() !=0 | compare_plt() !=0) {  
        
        user_pmp_sinlge <- user_pmp_mean() %>% 
          dplyr::filter(id == as.numeric(map_click()$id))
        
        user_pmp_remainder <- user_pmp_mean() %>% 
          dplyr::filter(id != as.numeric(map_click()$id))
        
        # Row layout table
        pmp_table_SERVER(id = "pmp_table_mod2", data = user_pmp_sinlge,
                         attributes = pmp_attributes,con_values = pmp_values,
                         pivot_wide = T)
       
        ## Advance ghost trigger to queue modal pop up
        updateNumericInput(session = session, inputId = 'ghost_trigger', 
                           value = input$ghost_trigger + 1 )
        
      
        ## Modal UI
        output$compare_ui <- renderUI({
          
          fluidPage(mainPanel(
            bsModal(id = ns("compare"), "Compare New Properties", 
                    "ghost_trigger", size="large",
            tabsetPanel(
              tabPanel("Table",
                       pmp_table_UI(id = ns("pmp_table_mod2"))),
              
              tabPanel("Plots"))
            
            # Close bsModal
            )
          # Close mainPanel  
          )
        # Close fluidPage  
        )
      # Close renderUI
      })
    # Close if-statement        
    }
      
  toggleModal(session, "compare", toggle = "open")
  
 # Close observeEvent      
 })    
# Close comparison_SERVER module    
})}