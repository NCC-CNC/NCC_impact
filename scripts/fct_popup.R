
PMP_popup <- function(data){
  paste0("<strong>Property: </strong>", data[["PROPERTY_N"]],
         "<br> <strong>Name: </strong>", data[["NAME"]],
         "<br><strong>Region: </strong>", data[["REGION"]],
         "<br><strong>Area: </strong>", format(round(data[["Area_ha"]], 1), nsmall=1, big.mark=","), " ha")
} 

# Generate table
PMP_table <- function(data, attributes, con_values, pivot_wide = F) {
  
  # Build data frame of attributes and values
  con_values <- purrr::map_chr(.x= con_values, .f = ~ {dplyr::pull(.data = data, var=.x)})
  pmp_df <- data.frame(attributes, con_values)
  
  if (pivot_wide == T) {
    
    # Row layout (1 property per row) 
    pmp_df <- pmp_df %>% 
      pivot_wider(names_from = attributes, values_from = con_values)   
    
  } else {
    
  # Columns layout (1 property per column)     
  names(pmp_df) <- NULL
  
  }
  
  pmp_dt <- pmp_df %>% 
    knitr::kable("html") %>% 
    kable_styling("striped", full_width = T)
}

# TEST FUNCTION ----------------------------------------------------------------
pmp_selection <- PMP_tmp %>% dplyr::filter(id==1)

test <- PMP_table(data = pmp_selection, 
                  attributes = c("Region", "Area", "Species at Risk (ECC)"),
                  con_values = c("REGION", "Area_ha", "Species_at_Risk_ECCC"),
                  pivot_wide = F)
test

