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
load(file.path("data", "03_clean", "basedata.RData"))

# Read-in regional goals -------------------------------------------------------
reg_goals <- read_csv(file.path("data", "sheets", "Regional_goals.csv"))

# source shiny mods ------------------------------------------------------------
source(file.path("scripts", "shinymods.R"))

# Source functions -------------------------------------------------------------
source(file.path("scripts", "fct_popup.R"))
source(file.path("scripts", "fct_plots.R"))

# Create vectors ---------------------------------------------------------------
# Species table inputs
species_row_names <- c("Region", "Area", "Species at Risk (ECCC)", 
                       "Amphibians (IUCN)", "Birds (IUCN)", "Mammals (IUCN)", 
                       "Reptiles (IUCN)","Species at Risk (NSC)", "Endemics (NSC)")

species_con_values <- c("REGION","Area_ha","Species_at_Risk_ECCC",
                        "Amphibians_IUCN","Birds_IUCN","Mammals_IUCN",
                        "Reptiles_IUCN","Species_at_Risk_NSC",
                        "Endemics_NSC")

