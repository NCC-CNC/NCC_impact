library(shiny)
mod_ui_btn <-  function(id, label = "ui1UI") {
  ns <- NS(id)
  shinyUI(fluidPage(
    actionButton(ns("confirm"), "Submit", class='btn-primary'),
    actionButton(ns("confirm2"), "Submit2", class='btn-primary')
  ))
}

mod_server_btn <- function(id) {
  moduleServer(id, function(input, output, session) {
    return(
      list(
        cond = reactive(input$confirm),
        cond2 = reactive(input$confirm2)
      )
    )  
    
  })
}

ui =fluidPage(
  mod_ui_btn("test"),
  verbatimTextOutput("example"),
  verbatimTextOutput("example2")
)

server=shinyServer(function(input, output, session) {   
  # value <- callModule(mod_server_btn,"test")  
  value <- mod_server_btn("test")
  # output$example <- renderPrint(value$cond())
  # output$example2 <- renderPrint(value$cond2())
  
  observe({
    print(value$cond())  #this is how I usually catch reactives - by their name
    print(value$cond2())
  })
})

shinyApp(ui=ui,server=server)