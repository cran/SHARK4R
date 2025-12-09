## ----eval=FALSE---------------------------------------------------------------
# install.packages("SHARK4R")

## ----eval=FALSE---------------------------------------------------------------
# library(SHARK4R)
# library(dplyr)

## ----include=FALSE------------------------------------------------------------
suppressPackageStartupMessages({
  library(SHARK4R)
  library(dplyr)
})

## -----------------------------------------------------------------------------
# Retrieve complete HAB list
hab_list <- get_hab_list()

# Print result as tibble
tibble(hab_list)

## -----------------------------------------------------------------------------
# Retrieve complete toxin list
toxin_list <- get_toxin_list()

# Print result as tibble
tibble(toxin_list)

## ----echo=FALSE---------------------------------------------------------------
# Print citation
citation("SHARK4R")

