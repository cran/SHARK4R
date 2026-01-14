## ----eval=FALSE---------------------------------------------------------------
# install.packages("SHARK4R")

## -----------------------------------------------------------------------------
library(SHARK4R)

## -----------------------------------------------------------------------------
# Retrieve complete HAB list
hab_list <- get_hab_list()

# Print result
print(hab_list)

## -----------------------------------------------------------------------------
# Retrieve complete Harmful non-toxic list
hab_non_toxic_list <- get_hab_list(harmful_non_toxic_only = TRUE,
                                   verbose = FALSE)

# Print result
print(hab_non_toxic_list)

## -----------------------------------------------------------------------------
# Retrieve complete toxin list
toxin_list <- get_toxin_list()

# Print result
print(toxin_list)

## ----echo=FALSE---------------------------------------------------------------
# Print citation
citation("SHARK4R")

## ----echo=FALSE---------------------------------------------------------------
clean_shark4r_cache(0, clear_perm_cache = TRUE, verbose = FALSE)

