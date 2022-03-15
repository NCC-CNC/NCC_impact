library(shiny)
library(shinydashboard)
library(leaflet)
library(leaflet.extras)
library(leaflet.extras2)
library(shinyWidgets)
library(shinyFeedback)
library(htmltools)
library(htmlwidgets)
library(shinycssloaders)
library(readr)
library(shinyjs)
library(tidyverse)
library(sf)
library(plotly)
library(shinipsum)
library(kableExtra)
library(piggyback)

# Read-in basedata -------------------------------------------------------------
load(file.path('data','03_clean','basedata.RData'))

# Read-in regional goals -------------------------------------------------------
reg_goals <- read_csv(file.path('data','sheets','Regional_goals.csv'))

# source shiny mods
source(file.path("scripts", "shinymods.R"))

# Source functions
source(file.path("scripts", "fct_popup.R"))
source(file.path("scripts", "fct_plots.R"))

# source(file.path("scripts", "leaflet_loader.R"))

