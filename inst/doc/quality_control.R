## ----eval=FALSE---------------------------------------------------------------
# install.packages("SHARK4R")

## -----------------------------------------------------------------------------
library(SHARK4R)

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

print(chlorophyll_data)

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

## ----eval=Sys.getenv("NOT_CRAN", unset = "FALSE") == "TRUE"-------------------
# plot_map_leaflet(chlorophyll_data)

## ----echo=FALSE, eval=!Sys.getenv("NOT_CRAN", unset = "FALSE") == "TRUE"------
message("The interactive map is omitted here but appears in the online tutorial.")

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

print(shark_statistics)

## -----------------------------------------------------------------------------
check_outliers(data = chlorophyll_data,
               parameter = "Chlorophyll-a",
               datatype = "Chlorophyll",
               threshold_col = "P99",
               thresholds = shark_statistics)

## ----eval=Sys.getenv("NOT_CRAN", unset = "FALSE") == "TRUE"-------------------
# # Scatterplot with horizontal line at 99th percentile
# scatterplot(chlorophyll_data,
#             hline = shark_statistics$P99)

## ----echo=FALSE, eval=!Sys.getenv("NOT_CRAN", unset = "FALSE") == "TRUE"------
message("The interactive plot is omitted here but appears in the online tutorial.")

## -----------------------------------------------------------------------------
check_parameter_rules(data = chlorophyll_data)

## -----------------------------------------------------------------------------
station_match <- match_station(chlorophyll_data$station_name)
head(station_match)

## ----eval=Sys.getenv("NOT_CRAN", unset = "FALSE") == "TRUE"-------------------
# check_station_distance(data = chlorophyll_data,
#                        plot_leaflet = TRUE)

## ----echo=FALSE, eval=!Sys.getenv("NOT_CRAN", unset = "FALSE") == "TRUE"------
message("The interactive map is omitted here but appears in the online tutorial.")

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

## ----echo=FALSE---------------------------------------------------------------
clean_shark4r_cache(0, clear_perm_cache = TRUE, verbose = FALSE)

