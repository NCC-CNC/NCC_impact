
PMP_popup <- function(data){
  paste0("<strong>Property name: </strong>", data[["PROPERTY_N"]],
         "<br> <strong>Name: </strong>", data[["NAME"]],
         "<br><strong>Region: </strong>", data[["REGION"]],
         "<br><strong>Area: </strong>", format(round(data[["Area_ha"]], 1), nsmall=1, big.mark=","), " ha")
} 

# Generate table
PMP_table <- function(data, row_names, con_values) {
  con_values_pulled <- purrr::map_chr(.x= con_values, .f = ~ {dplyr::pull(.data = data, var=.x)})
  pmp_df <- data.frame(row_names, con_values_pulled) 
  names(pmp_df) <- NULL
  pmp_dt <- pmp_df %>% knitr::kable("html") %>% kable_styling("striped", full_width = T) %>%
    footnote(general = " Table 1: Species", general_title = "", title_format = "bold")
  
}

pmp_selection <- PMP_tmp %>% dplyr::filter(id==1)

test <- PMP_table(data = pmp_selection, 
                  row_names = c("Region", "Area", "Species at Risk (ECC)"),
                  con_values = c("REGION", "Area_ha", "Species_at_Risk_ECCC"))
test

