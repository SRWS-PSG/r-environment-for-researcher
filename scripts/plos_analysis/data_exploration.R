# Data Exploration for PLOS ONE Article: 
# "Self-rated health status and illiteracy as death predictors in a Brazilian cohort"
# Article URL: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0200501

# Load required libraries
library(tidyverse)
library(readxl)
library(gtsummary)
library(survival)
# Note: survminer package installation failed, using base plotting instead

# Set working directory and file path
data_path <- "~/r-environment-for-researcher/data/Renamed_660b8.xls"

# Load the data
cat("Loading data from:", data_path, "\n")
cohort_data <- read_excel(data_path)

# Display basic information about the dataset
cat("\nDataset dimensions:", dim(cohort_data)[1], "rows and", dim(cohort_data)[2], "columns\n")
cat("\nColumn names:\n")
print(colnames(cohort_data))

# Check for missing values
cat("\nMissing values per column:\n")
missing_values <- colSums(is.na(cohort_data))
print(missing_values)

# Examine key variables
cat("\nKey variables for analysis:\n")

# 1. Mortality (outcome variable)
cat("\nMortality (0=Alive, 1=Non-CV death, 2=CV death):\n")
print(table(cohort_data$mortality, useNA = "always"))

# 2. Self-rated health (predictor)
cat("\nSelf-rated health (1=Excellent to 5=Poor):\n")
print(table(cohort_data$srh, useNA = "always"))

# 3. Literacy status (predictor)
cat("\nLiteracy (1=Literate, 2=Illiterate):\n")
print(table(cohort_data$read, useNA = "always"))

# 4. Age and sex (adjustment variables)
cat("\nAge distribution:\n")
print(summary(cohort_data$age))
cat("\nSex (1=Male, 2=Female):\n")
print(table(cohort_data$sex, useNA = "always"))

# 5. Cardiovascular risk factors (adjustment variables)
cat("\nHypertension (1=Yes, 2=No):\n")
print(table(cohort_data$`high BP`, useNA = "always"))

cat("\nSmoking (1=Yes, 2=No, 3=Former):\n")
print(table(cohort_data$smoke, useNA = "always"))

cat("\nPhysical activity (leisure) (1=Yes, 2=No):\n")
print(table(cohort_data$`leisure PA`, useNA = "always"))

# Clean data for analysis
cat("\nCleaning data for analysis...\n")

# Fix the 999 value in read variable (likely a coding error)
cohort_data <- cohort_data %>%
  mutate(read = ifelse(read == 999, NA, read))

# Create binary variables for analysis as per the article
cohort_data <- cohort_data %>%
  mutate(
    # Create binary mortality variables
    cv_mortality = ifelse(mortality == 2, 1, 0),
    noncv_mortality = ifelse(mortality == 1, 1, 0),
    all_mortality = ifelse(mortality > 0, 1, 0),
    
    # Create binary literacy variable (0=Literate, 1=Illiterate)
    illiterate = ifelse(read == 2, 1, 0),
    
    # Create binary SRH variable (0=Good/Excellent, 1=Poor/Regular)
    poor_srh = ifelse(srh >= 3, 1, 0),
    
    # Create binary risk factor variables
    hypertension = ifelse(`high BP` == 1, 1, 0),
    current_smoker = ifelse(smoke == 1, 1, 0),
    sedentary = ifelse(`leisure PA` == 2, 1, 0),
    
    # Create sex variable (0=Male, 1=Female)
    female = ifelse(sex == 2, 1, 0)
  )

# Summarize the prepared variables
cat("\nPrepared variables for Cox models:\n")

cat("\nAll-cause mortality:\n")
print(table(cohort_data$all_mortality, useNA = "always"))

cat("\nCardiovascular mortality:\n")
print(table(cohort_data$cv_mortality, useNA = "always"))

cat("\nNon-cardiovascular mortality:\n")
print(table(cohort_data$noncv_mortality, useNA = "always"))

cat("\nIlliteracy (1=Illiterate):\n")
print(table(cohort_data$illiterate, useNA = "always"))

cat("\nPoor self-rated health (1=Poor/Regular):\n")
print(table(cohort_data$poor_srh, useNA = "always"))

# Create descriptive statistics table
cat("\nCreating descriptive statistics table...\n")

# Table 1: Baseline characteristics by mortality status
table1 <- cohort_data %>%
  select(
    all_mortality, age, female, illiterate, poor_srh,
    hypertension, current_smoker, sedentary
  ) %>%
  tbl_summary(
    by = all_mortality,
    missing = "no",
    label = list(
      age ~ "Age (years)",
      female ~ "Female",
      illiterate ~ "Illiterate",
      poor_srh ~ "Poor self-rated health",
      hypertension ~ "Hypertension",
      current_smoker ~ "Current smoker",
      sedentary ~ "Sedentary lifestyle"
    ),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"
    )
  ) %>%
  add_p() %>%
  modify_header(label = "**Characteristic**", 
                all_stat_cols() ~ "**{level}**<br>N = {n} ({style_percent(p)}%)") %>%
  modify_footnote(all_stat_cols() ~ "Mean (SD) or Frequency (%)")

# Print the table to console
print(table1)

# Save the table to a file
table1 %>%
  as_gt() %>%
  gt::gtsave(filename = "~/r-environment-for-researcher/scripts/plos_analysis/table1_mortality.html")

cat("\nExploration complete. Results saved to scripts/plos_analysis directory.\n")
