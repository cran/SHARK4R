## ----eval=FALSE---------------------------------------------------------------
# install.packages("SHARK4R")

## ----eval=FALSE---------------------------------------------------------------
# library(SHARK4R)
# library(dplyr)
# library(ggplot2)

## ----include=FALSE------------------------------------------------------------
suppressPackageStartupMessages({
  library(SHARK4R)
  library(dplyr)
  library(ggplot2)
})

## -----------------------------------------------------------------------------
# Retrieve all phytoplankton data from April 2015
shark_data <- get_shark_data(fromYear = 2015, 
                             toYear = 2015,
                             months = 4, 
                             dataTypes = "Phytoplankton",
                             verbose = FALSE)

## -----------------------------------------------------------------------------
# Find taxa without Aphia ID
no_aphia_id <- shark_data %>%
  filter(is.na(aphia_id))

# Randomly select taxa with missing aphia_id
taxa_names <- sample(unique(no_aphia_id$scientific_name), 
                     size = 10,
                     replace = TRUE)

# Match taxa names with WoRMS
worms_records <- match_worms_taxa(unique(taxa_names),
                                  fuzzy = TRUE,
                                  best_match_only = TRUE,
                                  marine_only = TRUE,
                                  verbose = FALSE)

# Print result as tibble
tibble(worms_records)

## -----------------------------------------------------------------------------
# Randomly select ten Aphia IDs
aphia_ids <- sample(unique(shark_data$aphia_id), 
                    size = 10)

# Remove NAs
aphia_ids <- aphia_ids[!is.na(aphia_ids)]

# Retrieve records
worms_records <- get_worms_records(aphia_ids,
                                   verbose = FALSE)

# Print result as tibble
tibble(worms_records)

## -----------------------------------------------------------------------------
# Retrieve taxonomic table
worms_taxonomy <- add_worms_taxonomy(aphia_ids,
                                     verbose = FALSE)

# Print result as tibble
tibble(worms_taxonomy)

# Enrich data with data from WoRMS
shark_data_with_worms <- shark_data %>%
  left_join(worms_taxonomy, by = "aphia_id")

## -----------------------------------------------------------------------------
# Retrieve taxonomic tree
worms_tree <- get_worms_taxonomy_tree(
  aphia_ids[1],                # use first id only in this example
  add_descendants = FALSE,     # only retrieve hierarchy for given AphiaIDs
  add_synonyms = FALSE,        # do not retrieve synonyms
  verbose = FALSE              # suppress progress messages
)

# Print as tibble for easier viewing
tibble(worms_tree)

## -----------------------------------------------------------------------------
# Subset data from one national monitoring station
nat_stations <- shark_data %>%
  filter(station_name %in% c("BY5 BORNHOLMSDJ"))

# Randomly select one sample from the nat_stations
sample <- sample(unique(nat_stations$shark_sample_id_md5), 1)

# Subset the random sample
shark_data_subset <- shark_data %>%
  filter(shark_sample_id_md5 == sample)

# Assign groups by providing both scientific name and Aphia ID
plankton_groups <- assign_phytoplankton_group(
  scientific_names = shark_data_subset$scientific_name,
  aphia_ids = shark_data_subset$aphia_id,
  verbose = FALSE)

# Print result
tibble(distinct(plankton_groups))

# Add plankton groups to data and summarize abundance results
plankton_group_sum <- shark_data_subset %>%
  mutate(plankton_group = plankton_groups$plankton_group) %>%
  filter(parameter == "Abundance") %>%
  group_by(plankton_group) %>%
  summarise(sum_plankton_groups = sum(value, na.rm = TRUE))

# Plot a pie chart
ggplot(plankton_group_sum, 
       aes(x = "", y = sum_plankton_groups, fill = plankton_group)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Phytoplankton Groups",
    subtitle = paste(unique(shark_data_subset$station_name),
                     unique(shark_data_subset$sample_date)),
    fill = "Plankton Group"
  ) +
  theme_void() +
  theme(plot.background = element_rect(fill = "white", color = NA))

## -----------------------------------------------------------------------------
# Define custom plankton groups using a named list
custom_groups <- list(
  "Cryptophytes" = list(class = "Cryptophyceae"),
  "Green Algae" = list(class = c("Trebouxiophyceae", 
                                 "Chlorophyceae", 
                                 "Pyramimonadophyceae"),
                       phylum = "Chlorophyta"),
  "Ciliates" = list(phylum = "Ciliophora"),
  "Mesodinium rubrum" = list(scientific_name = "Mesodinium rubrum"),
  "Dinophysis" = list(genus = "Dinophysis")
)

# Assign groups by providing scientific name only, and adding custom groups
plankton_groups <- assign_phytoplankton_group(
  scientific_names = shark_data_subset$scientific_name,
  custom_groups = custom_groups,
  verbose = FALSE)

# Add new plankton groups to data and summarize abundance results
plankton_custom_group_sum <- shark_data_subset %>%
  mutate(plankton_group = plankton_groups$plankton_group) %>%
  filter(parameter == "Abundance") %>%
  group_by(plankton_group) %>%
  summarise(sum_plankton_groups = sum(value, na.rm = TRUE))

# Plot a new pie chart, including the custom groups
ggplot(plankton_custom_group_sum, 
       aes(x = "", y = sum_plankton_groups, fill = plankton_group)) +
  geom_col(width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Phytoplankton Custom Groups",
    subtitle = paste(unique(shark_data_subset$station_name),
                     unique(shark_data_subset$sample_date)),
    fill = "Plankton Group"
  ) +
  theme_void() +
  theme(plot.background = element_rect(fill = "white", color = NA))

## ----echo=FALSE---------------------------------------------------------------
# Print citation
citation("SHARK4R")

