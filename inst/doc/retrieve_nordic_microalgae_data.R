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
# Get taxa information
taxa <- get_nua_taxa(unparsed = FALSE)

# Print data
tibble(taxa)

## -----------------------------------------------------------------------------
# Randomly select 10 taxa from shark_taxon$scientific_name
slugs <- sample(taxa$slug, size = 10)

# Get external links
external_links <- get_nua_external_links(slugs, 
                                         verbose = FALSE, 
                                         unparsed = FALSE)

# Print list
tibble(external_links)

## -----------------------------------------------------------------------------
# Get external links
harmfulness <- get_nua_harmfulness(c("dinophysis-acuta", 
                                     "alexandrium-ostenfeldii"), 
                                   verbose = FALSE)

# Print list
tibble(harmfulness)

## -----------------------------------------------------------------------------
# Get all media links
media <- get_nua_media_links(unparsed = FALSE)

# Print list
tibble(media)

## -----------------------------------------------------------------------------
# Get EG Phyto Biovolume list
peg_list <- get_peg_list()

# Print list
tibble(peg_list)

# Get NOMP Biovolume list
nomp_list <- get_nomp_list()

# Print list
tibble(nomp_list)

## ----echo=FALSE---------------------------------------------------------------
# Print citation
citation("SHARK4R")

## ----echo=FALSE---------------------------------------------------------------
clean_shark4r_cache(0, clear_perm_cache = TRUE, verbose = FALSE)

