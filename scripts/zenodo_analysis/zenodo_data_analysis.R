# Analysis of ECDC Hospital and ICU Data from Zenodo
# Dataset: 1.4.EU.UNIPV.ECDC_Hospital_ICU.1.csv

# Load required libraries
library(tidyverse)
library(ggplot2)
library(gtsummary)
library(lubridate)

# Set working directory and file path
data_path <- "~/zenodo_data/1.4.EU.UNIPV.ECDC_Hospital_ICU.1.csv"

# Load the data
cat("Loading data from:", data_path, "\n")
hospital_data <- read_csv(data_path, show_col_types = FALSE)

# Display basic information about the dataset
cat("\nDataset dimensions:", dim(hospital_data)[1], "rows and", dim(hospital_data)[2], "columns\n")
cat("\nColumn names:\n")
print(colnames(hospital_data))

# Check for missing values
cat("\nMissing values per column:\n")
missing_values <- colSums(is.na(hospital_data))
print(missing_values)

# Basic data exploration
cat("\nUnique countries in the dataset:\n")
unique_countries <- unique(hospital_data$country)
print(unique_countries)
cat("Total number of countries:", length(unique_countries), "\n")

cat("\nTypes of measurements in the dataset:\n")
unique_measurements <- unique(hospital_data$What)
print(unique_measurements)

# Convert date columns to proper date format
hospital_data <- hospital_data %>%
  mutate(time1 = as.Date(time1),
         time2 = as.Date(time2))

# Time range of the data
cat("\nTime range of the dataset:\n")
date_range <- range(hospital_data$time1, na.rm = TRUE)
print(paste("From", date_range[1], "to", date_range[2]))

# Summary statistics by measurement type
cat("\nSummary statistics by measurement type:\n")
summary_by_measurement <- hospital_data %>%
  group_by(What) %>%
  summarise(
    Count = n(),
    Min = min(Value, na.rm = TRUE),
    Q1 = quantile(Value, 0.25, na.rm = TRUE),
    Median = median(Value, na.rm = TRUE),
    Mean = mean(Value, na.rm = TRUE),
    Q3 = quantile(Value, 0.75, na.rm = TRUE),
    Max = max(Value, na.rm = TRUE),
    SD = sd(Value, na.rm = TRUE)
  )
print(summary_by_measurement)

# Summary statistics by country (for Daily hospital occupancy)
cat("\nSummary statistics for Daily hospital occupancy by country:\n")
hospital_occupancy_summary <- hospital_data %>%
  filter(What == "Daily hospital occupancy") %>%
  group_by(country) %>%
  summarise(
    Count = n(),
    Min = min(Value, na.rm = TRUE),
    Q1 = quantile(Value, 0.25, na.rm = TRUE),
    Median = median(Value, na.rm = TRUE),
    Mean = mean(Value, na.rm = TRUE),
    Q3 = quantile(Value, 0.75, na.rm = TRUE),
    Max = max(Value, na.rm = TRUE),
    SD = sd(Value, na.rm = TRUE)
  ) %>%
  arrange(desc(Mean))
print(hospital_occupancy_summary)

# Save the summary statistics to CSV files
write_csv(summary_by_measurement, "~/r-environment-for-researcher/scripts/summary_by_measurement.csv")
write_csv(hospital_occupancy_summary, "~/r-environment-for-researcher/scripts/hospital_occupancy_summary.csv")

# Create a time series plot for selected countries
cat("\nCreating time series plots...\n")

# Select top 5 countries by mean hospital occupancy
top_countries <- hospital_occupancy_summary %>%
  head(5) %>%
  pull(country)

# Create time series plot for hospital occupancy
hospital_ts_data <- hospital_data %>%
  filter(What == "Daily hospital occupancy", country %in% top_countries)

hospital_ts_plot <- ggplot(hospital_ts_data, aes(x = time1, y = Value, color = country)) +
  geom_line() +
  labs(
    title = "Daily Hospital Occupancy for Top 5 Countries",
    x = "Date",
    y = "Number of Patients",
    color = "Country"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the plot
ggsave("~/r-environment-for-researcher/scripts/hospital_occupancy_timeseries.png", 
       hospital_ts_plot, width = 10, height = 6, dpi = 300)

# Create a time series plot for ICU occupancy for the same countries
icu_ts_data <- hospital_data %>%
  filter(What == "Daily ICU occupancy", country %in% top_countries)

icu_ts_plot <- ggplot(icu_ts_data, aes(x = time1, y = Value, color = country)) +
  geom_line() +
  labs(
    title = "Daily ICU Occupancy for Top 5 Countries",
    x = "Date",
    y = "Number of Patients",
    color = "Country"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the plot
ggsave("~/r-environment-for-researcher/scripts/icu_occupancy_timeseries.png", 
       icu_ts_plot, width = 10, height = 6, dpi = 300)

# Create boxplots for hospital occupancy by country
hospital_boxplot <- hospital_data %>%
  filter(What == "Daily hospital occupancy", country %in% top_countries) %>%
  ggplot(aes(x = reorder(country, Value, FUN = median), y = Value, fill = country)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Daily Hospital Occupancy by Country",
    x = "Country",
    y = "Number of Patients"
  ) +
  theme_minimal() +
  theme(legend.position = "none", axis.text.x = element_text(angle = 45, hjust = 1))

# Save the plot
ggsave("~/r-environment-for-researcher/scripts/hospital_occupancy_boxplot.png", 
       hospital_boxplot, width = 10, height = 6, dpi = 300)

# Create a heatmap of weekly hospital admissions per 100k
if("Weekly new hospital admissions per 100k" %in% unique_measurements) {
  weekly_admissions_data <- hospital_data %>%
    filter(What == "Weekly new hospital admissions per 100k") %>%
    filter(country %in% unique(hospital_data$country)[1:15])  # Limit to first 15 countries for readability
  
  # Extract year and week for better visualization
  weekly_admissions_data <- weekly_admissions_data %>%
    mutate(year_week = paste(Year, sprintf("%02d", Week), sep = "-"))
  
  # Select a subset of weeks for readability
  weeks_to_show <- weekly_admissions_data %>%
    arrange(Year, Week) %>%
    distinct(year_week) %>%
    filter(row_number() %% 4 == 0) %>%  # Show every 4th week
    pull(year_week)
  
  weekly_admissions_heatmap <- weekly_admissions_data %>%
    filter(year_week %in% weeks_to_show) %>%
    ggplot(aes(x = year_week, y = country, fill = Value)) +
    geom_tile() +
    scale_fill_viridis_c() +
    labs(
      title = "Weekly New Hospital Admissions per 100k Population",
      x = "Year-Week",
      y = "Country",
      fill = "Admissions per 100k"
    ) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
  
  # Save the plot
  ggsave("~/r-environment-for-researcher/scripts/weekly_admissions_heatmap.png", 
         weekly_admissions_heatmap, width = 12, height = 8, dpi = 300)
}

cat("\nAnalysis complete. Results saved to CSV files and plots saved as PNG files.\n")
