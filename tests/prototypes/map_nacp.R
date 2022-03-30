library(sf)
library(leaflet)
library(leafgl)
library(htmltools)
library(raster)

NACP <- read_sf(file.path("data", "01_raw", "NCC", "NCC_NACPs.shp")) %>%
  st_transform(crs = st_crs(4326)) %>%
  st_make_valid() 

PMP <- read_sf(file.path("data", "01_raw", "NCC", "Parcels_20210531_Achievements_prjEA_RRupdate.shp")) %>%
  st_transform(crs = st_crs(4326)) %>%
  st_make_valid() 

forest <- raster(file.path("data", "03_clean", "themes", "Forest.tif"))

mymap <- leaflet() %>%
  addTiles() %>%
  addPolygons(data = parcels,
              group = "PMP",
              fillColor = "#33862B",
              color = "black",
              weight = 1,
              fillOpacity = 0.7,
              label = ~htmlEscape(NAME),
              highlightOptions = highlightOptions(weight = 3, color = '#00ffd9'))


qpal <- colorNumeric(palette = "viridis", c(0,100))
mymap <- leaflet() %>%
  addTiles() %>%
  addLegend(pal=qpal, values = c(0,100))

mymap

