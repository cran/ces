## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(ces)

## -----------------------------------------------------------------------------
# List all available datasets
list_ces_datasets()

# Get detailed information about available datasets
list_ces_datasets(details = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # Get the 2019 CES data
# ces_2019 <- get_ces("2019")
# 
# # View the first few rows
# head(ces_2019)
# 
# # Get information about the dataset
# dim(ces_2019)

## ----eval=FALSE---------------------------------------------------------------
# # Get raw (uncleaned) data
# ces_raw <- get_ces("2019", clean = FALSE)
# 
# # Get data as a data.frame instead of a tibble
# ces_df <- get_ces("2019", format = "data.frame")
# 
# # Bypass cache and download fresh data
# ces_fresh <- get_ces("2019", use_cache = FALSE)
# 
# # Disable metadata preservation if needed (not recommended)
# ces_without_metadata <- get_ces("2019", preserve_metadata = FALSE)
# 
# # Silent mode - no progress messages
# ces_silent <- get_ces("2019", verbose = FALSE)

## ----eval=FALSE---------------------------------------------------------------
# # All metadata is preserved by default
# ces_data <- get_ces("2019")
# 
# # Access variable label (question text)
# attr(ces_data$vote_choice, "label")
# 
# # Access value labels
# attr(ces_data$vote_choice, "labels")
# 
# # See all attributes of a variable
# attributes(ces_data$vote_choice)

## ----eval=FALSE---------------------------------------------------------------
# # Get an overview of all variables with metadata
# metadata_summary <- examine_metadata(ces_data)
# 
# # Show the first few entries
# head(metadata_summary)
# 
# # Find variables with value labels about voting
# voting_metadata <- examine_metadata(ces_data,
#                                   show_labels = TRUE,
#                                   variable_pattern = "vote")

## ----eval=FALSE---------------------------------------------------------------
# # Get a subset of variables by name
# variables <- c("vote_choice", "age", "gender", "province", "education")
# ces_subset <- get_ces_subset("2019", variables)
# 
# # Get all variables containing "vote" in their name (using regex)
# vote_vars <- get_ces_subset("2019", "vote", regex = TRUE)

## ----eval=FALSE---------------------------------------------------------------
# # Get 2019 data
# ces_2019 <- get_ces("2019")
# 
# # Create a codebook
# codebook <- create_codebook(ces_2019)
# 
# # View the first few entries
# head(codebook)
# 
# # Find variables about a specific topic
# library(dplyr)
# voting_vars <- codebook %>%
#   filter(grepl("vote|voted", question, ignore.case = TRUE)) %>%
#   pull(variable)
# 
# # Use these variables in your analysis
# voting_data <- get_ces_subset("2019", variables = voting_vars)

## ----eval=FALSE---------------------------------------------------------------
# # Export to CSV
# export_codebook(codebook, "ces_2019_codebook.csv")
# 
# # Export to Excel (requires openxlsx package)
# export_codebook(codebook, "ces_2019_codebook.xlsx")

## ----eval=FALSE---------------------------------------------------------------
# # Download the official CES codebook PDF
# download_pdf_codebook("2019")
# 
# # Download to a specific folder
# download_pdf_codebook("2015", path = "~/Documents/CES_codebooks")

## ----eval=FALSE---------------------------------------------------------------
# # Download a single CES dataset
# download_ces_dataset("2019", path = "~/Documents/CES_datasets")
# 
# # Download all available CES datasets to a folder
# download_all_ces_datasets(path = "~/Documents/CES_datasets")
# 
# # Download only specific years
# download_all_ces_datasets(years = c("2015", "2019", "2021"))

## ----eval=FALSE---------------------------------------------------------------
# # Get 2019 data
# ces_2019 <- get_ces("2019")
# 
# # Table of vote choice by province
# if (requireNamespace("dplyr", quietly = TRUE)) {
#   library(dplyr)
# 
#   # Create a table of vote choice by province
#   vote_by_province <- ces_2019 %>%
#     group_by(province, vote_choice) %>%
#     summarize(count = n(), .groups = "drop") %>%
#     pivot_wider(names_from = vote_choice, values_from = count, values_fill = 0)
# 
#   print(vote_by_province)
# }

