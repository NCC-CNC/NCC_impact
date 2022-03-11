
PMP_popup <- function(data){
  paste0("<strong>Property name: </strong>", data[["PROPERTY_N"]],
         "<br> <strong>Name: </strong>", data[["NAME"]],
         "<br><strong>Region: </strong>", data[["REGION"]],
         "<br><strong>Area: </strong>", format(round(data[["Area_ha"]], 1), nsmall=1, big.mark=","), " ha")
} 