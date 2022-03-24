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
library(exactextractr)
library(terra)
library(dplyr)
library(tidyr)
library(purrr)
library(shinyBS)

# Read-in basedata -------------------------------------------------------------
load(file.path("data", "03_clean", "basedata.RData"))

# Read-in regional goals -------------------------------------------------------
reg_goals <- read_csv(file.path("data", "sheets", "Regional_goals.csv"))

# source shiny mods ------------------------------------------------------------
source(file.path("scripts", "mod_tables.R"))
source(file.path("scripts", "mod_extractions.R"))
source(file.path("scripts", "mod_report.R"))
source(file.path("scripts", "mod_comparison.R"))

# Source functions -------------------------------------------------------------
source(file.path("scripts", "fct_popup.R"))
source(file.path("scripts", "fct_plots.R"))
source(file.path("scripts", "fct_shpupload.R"))

# Source conservation themes ---------------------------------------------------
source(file.path("scripts", "server_load_themes.R"))

# Species table inputs ---------------------------------------------------------
species_row_names <- c("Region", "Area", "Species at Risk (ECCC)", 
                       "Amphibians (IUCN)", "Birds (IUCN)", "Mammals (IUCN)", 
                       "Reptiles (IUCN)","Species at Risk (NSC)", "Endemics (NSC)")

species_con_values <- c("REGION","Area_ha","Species_at_Risk_ECCC",
                        "Amphibians_IUCN","Birds_IUCN","Mammals_IUCN",
                        "Reptiles_IUCN","Species_at_Risk_NSC",
                        "Endemics_NSC")
