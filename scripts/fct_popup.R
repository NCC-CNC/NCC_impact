
PMP_popup <- function(data){
  paste0("<strong>Property name: </strong>", data[["PROPERTY_N"]],
         "<br> <strong>Name: </strong>", data[["NAME"]],
         "<br><strong>Region: </strong>", data[["REGION"]],
         "<br><strong>Area: </strong>", format(round(data[["Area_ha"]], 1), nsmall=1, big.mark=","), " ha")
} 

PMP_table <- function(data) {
  row_names <- c("Region", 
                 "Area",
                 "Species at Risk (ECCC)",
                 "Amphibians (IUCN)",
                 "Birds (IUCN)",
                 "Mammals (IUCN)",
                 "Reptiles (IUCN)",
                 "Species at Risk (NSC)",
                 "Endemics (NSC)",
                 "Biodiversity (NSC)"
                 )
  
  con_values <- c(data[["REGION"]],
                  data[["Area_ha"]],
                  data[["Species_at_Risk_ECCC"]],
                  data[["Amphibians_IUCN"]],
                  data[["Birds_IUCN"]],
                  data[["Mammals_IUCN"]],
                  data[["Reptiles_IUCN"]],
                  data[["Species_at_Risk_NSC"]],
                  data[["Endemics_NSC"]],
                  data[["Biodiversity_NSC"]])
  
  pmp_df <- data.frame(row_names, con_values) 
  names(pmp_df) <- NULL
  pmp_dt <- pmp_df %>% knitr::kable("html") %>% kable_styling("striped", full_width = T)
  
}

pmp_selection <- PMP_tmp %>% dplyr::filter(id==1)

test <- PMP_table(pmp_selection)
test
