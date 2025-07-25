## Basic examples of using the ces package for analysis

library(ces)

# 1. Get a list of all available datasets (now includes survey variants)
all_datasets <- list_ces_datasets()
print(all_datasets)

# 2. Download the 2019 CES web survey data (default) with full progress information
ces_2019_web <- get_ces("2019", verbose = TRUE)

# 2b. Also get the 2019 phone survey for comparison
ces_2019_phone <- get_ces("2019", variant = "phone", verbose = TRUE)

# 3. Look at the structure of the data
str(ces_2019_web, max.level = 1)
cat("Web survey sample size:", nrow(ces_2019_web), "\n")
cat("Phone survey sample size:", nrow(ces_2019_phone), "\n")

# 4. Get a subset of the data with only vote choice and demographic variables
vote_demo_vars <- c("vote_choice", "age", "gender", "province", "education", "income")
ces_subset <- get_ces_subset("2019", variables = vote_demo_vars)

# 4b. Get the same variables from the phone survey
ces_subset_phone <- get_ces_subset("2019", variant = "phone", variables = vote_demo_vars)

# 5. Simple vote choice analysis
if (requireNamespace("dplyr", quietly = TRUE) && 
    requireNamespace("ggplot2", quietly = TRUE)) {
  
  library(dplyr)
  library(ggplot2)
  
  # Vote choice by age group
  vote_by_age <- ces_subset %>%
    mutate(age_group = cut(age, breaks = c(0, 30, 45, 60, Inf),
                          labels = c("18-30", "31-45", "46-60", "61+"))) %>%
    group_by(age_group, vote_choice) %>%
    summarize(count = n(), .groups = "drop") %>%
    group_by(age_group) %>%
    mutate(proportion = count / sum(count))
  
  # Plot the results
  ggplot(vote_by_age, aes(x = age_group, y = proportion, fill = vote_choice)) +
    geom_col(position = "dodge") +
    labs(title = "Vote Choice by Age Group in 2019 Canadian Election",
         x = "Age Group", y = "Proportion") +
    theme_minimal()
  
  # Vote choice by province
  vote_by_province <- ces_subset %>%
    group_by(province, vote_choice) %>%
    summarize(count = n(), .groups = "drop") %>%
    group_by(province) %>%
    mutate(proportion = count / sum(count))
  
  # Plot the results
  ggplot(vote_by_province, aes(x = province, y = proportion, fill = vote_choice)) +
    geom_col() +
    labs(title = "Vote Choice by Province in 2019 Canadian Election",
         x = "Province", y = "Proportion") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
}