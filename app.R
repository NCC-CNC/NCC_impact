# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

# set ports if needed
if (!is.null(Sys.getenv("R_SHINY_PORT"))) {
  options(shiny.port = as.numeric(Sys.getenv("R_SHINY_PORT")))
}
if (!is.null(Sys.getenv("R_SHINY_HOST"))) {
  options(shiny.host = Sys.getenv("R_SHINY_HOST"))
}

# launch application
shiny::runApp(display.mode="normal")
