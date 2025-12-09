## ----eval=FALSE---------------------------------------------------------------
# install.packages("SHARK4R")

## ----include=FALSE------------------------------------------------------------
suppressPackageStartupMessages({
  library(SHARK4R)
  library(dplyr)
})

## ----eval=FALSE---------------------------------------------------------------
# library(SHARK4R)
# library(dplyr)

## -----------------------------------------------------------------------------
shark_options <- get_shark_options()

## -----------------------------------------------------------------------------
# Filter names using grepl
chlorophyll_datasets <- shark_options$datasets[grepl("Chlorophyll", 
                                                     shark_options$datasets)]

# Select the first dataset for demonstration
selected_dataset <- chlorophyll_datasets[1]

# Print the name of the selected dataset
print(selected_dataset)

## -----------------------------------------------------------------------------
chlorophyll_data <- get_shark_datasets(selected_dataset,
                                       save_dir = tempdir(),
                                       return_df = TRUE,
                                       verbose = FALSE)

tibble(chlorophyll_data)

## -----------------------------------------------------------------------------
check_fields(data = chlorophyll_data, datatype = "Chlorophyll")

## -----------------------------------------------------------------------------
# Validate project codes
check_codes(chlorophyll_data)

# Validate ship/platform codes
check_codes(data = chlorophyll_data, 
            field = "platform_code", 
            code_type = "SHIPC", 
            match_column = "Code")

## -----------------------------------------------------------------------------
plot_map_leaflet(chlorophyll_data)

## -----------------------------------------------------------------------------
n_rows_on_land <- check_onland(chlorophyll_data)
nrow(n_rows_on_land)

## -----------------------------------------------------------------------------
check_depth(data = chlorophyll_data) # default columns: min/max depth
check_depth(data = chlorophyll_data, "water_depth_m")

## -----------------------------------------------------------------------------
shark_statistics <- get_shark_statistics(datatype = "Chlorophyll",
                                         fromYear = 2020,
                                         toYear = 2024,
                                         verbose = FALSE)

tibble(shark_statistics)

## -----------------------------------------------------------------------------
check_outliers(data = chlorophyll_data,
               parameter = "Chlorophyll-a",
               datatype = "Chlorophyll",
               threshold_col = "P99",
               thresholds = shark_statistics)

## -----------------------------------------------------------------------------
# Scatterplot with horizontal line at 99th percentile
scatterplot(chlorophyll_data,
            hline = shark_statistics$P99)

## -----------------------------------------------------------------------------
check_parameter_rules(data = chlorophyll_data)

## -----------------------------------------------------------------------------
station_match <- match_station(chlorophyll_data$station_name)
head(station_match)

## -----------------------------------------------------------------------------
check_station_distance(data = chlorophyll_data,
                       plot_leaflet = TRUE)

## -----------------------------------------------------------------------------
check_nominal_station(data = chlorophyll_data)

## ----eval=FALSE---------------------------------------------------------------
# # Run the app
# run_qc_app()
# 
# # Alternative, download support files and knit documents locally
# check_setup(path = tempdir()) # using a temp folder in this example

## ----echo=FALSE---------------------------------------------------------------
citation("SHARK4R")

