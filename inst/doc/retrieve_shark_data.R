## ----eval=FALSE---------------------------------------------------------------
# install.packages("SHARK4R")

## ----eval=FALSE---------------------------------------------------------------
# library(SHARK4R)

## ----include=FALSE------------------------------------------------------------
suppressPackageStartupMessages({
  library(SHARK4R)
})

## -----------------------------------------------------------------------------
# Retrieve chlorophyll data for April to June from 2019 to 2020
shark_data <- get_shark_data(fromYear = 2019, 
                             toYear = 2020,
                             months = c(4, 5, 6), 
                             dataTypes = "Chlorophyll",
                             verbose = FALSE)

# Print data
print(shark_data)

## -----------------------------------------------------------------------------
# Retrieve available search options
shark_options <- get_shark_options()

# List the names of the available options
names(shark_options)

# View available datatypes
dataTypes <- shark_options$dataTypes
print(dataTypes)

# View available dataset names
datasetNames <- shark_options$datasets
head(datasetNames) # Print first few dataset names

## -----------------------------------------------------------------------------
# Select a dataset name (e.g., the first two in the list)
dataset_name <- datasetNames[1:2]

# Download the dataset as a zip-archive to a temporary directory
shark_data_zip <- get_shark_datasets(dataset_name,
                                     save_dir = tempdir(),
                                     verbose = FALSE) # Quiet output

# Print the paths to the downloaded files
print(shark_data_zip)

## ----echo=FALSE---------------------------------------------------------------
# Print citation
citation("SHARK4R")

## ----echo=FALSE---------------------------------------------------------------
clean_shark4r_cache(0, clear_perm_cache = TRUE, verbose = FALSE)

