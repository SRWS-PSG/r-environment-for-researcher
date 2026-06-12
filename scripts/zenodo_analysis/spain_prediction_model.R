# Time Series Prediction Model for Spain's Hospital Occupancy
# Using data up to 2021 to predict 2022 values

# Load required libraries
library(tidyverse)
library(forecast)
library(lubridate)
library(ggplot2)
library(here)

# Set seed for reproducibility
set.seed(123)

# Set working directory and file path
data_path <- "~/zenodo_data/1.4.EU.UNIPV.ECDC_Hospital_ICU.1.csv"

# Load the data
cat("Loading data from:", data_path, "\n")
hospital_data <- read_csv(data_path, show_col_types = FALSE)

# Filter data for Spain and Daily hospital occupancy
spain_data <- hospital_data %>%
  filter(country == "Spain", What == "Daily hospital occupancy") %>%
  arrange(time1)

# Check the date range
cat("\nDate range for Spain's hospital occupancy data:\n")
date_range <- range(spain_data$time1, na.rm = TRUE)
print(paste("From", date_range[1], "to", date_range[2]))

# Split data into training (up to 2021) and test (2022) sets
spain_train <- spain_data %>%
  filter(time1 < as.Date("2022-01-01"))

spain_test <- spain_data %>%
  filter(time1 >= as.Date("2022-01-01"))

cat("\nTraining data (up to 2021):", nrow(spain_train), "observations\n")
cat("Test data (2022):", nrow(spain_test), "observations\n")

# Create time series object for training data
spain_ts <- ts(spain_train$Value, 
               frequency = 7,  # Weekly seasonality
               start = c(year(min(spain_train$time1)), yday(min(spain_train$time1))))

# Plot the time series
cat("\nPlotting the time series...\n")
png("~/r-environment-for-researcher/scripts/zenodo_analysis/spain_hospital_ts.png", 
    width = 10, height = 6, units = "in", res = 300)
plot(spain_ts, main = "Spain's Daily Hospital Occupancy (Training Data)",
     xlab = "Time", ylab = "Number of Patients")
dev.off()

# Decompose the time series to observe trend, seasonality, and remainder
spain_decomp <- stl(spain_ts, s.window = "periodic")
png("~/r-environment-for-researcher/scripts/zenodo_analysis/spain_decomposition.png", 
    width = 10, height = 8, units = "in", res = 300)
plot(spain_decomp, main = "Decomposition of Spain's Hospital Occupancy Time Series")
dev.off()

# Fit different time series models

# 1. ARIMA model
cat("\nFitting ARIMA model...\n")
arima_model <- auto.arima(spain_ts)
cat("ARIMA model summary:\n")
print(summary(arima_model))

# 2. Exponential Smoothing (ETS) model
cat("\nFitting ETS model...\n")
ets_model <- ets(spain_ts)
cat("ETS model summary:\n")
print(summary(ets_model))

# 3. TBATS model (handles multiple seasonalities)
cat("\nFitting TBATS model...\n")
tbats_model <- tbats(spain_ts)
cat("TBATS model summary:\n")
print(summary(tbats_model))

# Calculate the number of days to forecast (days in 2022 in the test set)
forecast_horizon <- nrow(spain_test)
cat("\nForecasting horizon:", forecast_horizon, "days\n")

# Generate forecasts
arima_forecast <- forecast(arima_model, h = forecast_horizon)
ets_forecast <- forecast(ets_model, h = forecast_horizon)
tbats_forecast <- forecast(tbats_model, h = forecast_horizon)

# Create a data frame with actual test data and forecasts
forecast_dates <- spain_test$time1
forecast_df <- data.frame(
  Date = forecast_dates,
  Actual = spain_test$Value,
  ARIMA = as.numeric(arima_forecast$mean),
  ETS = as.numeric(ets_forecast$mean),
  TBATS = as.numeric(tbats_forecast$mean)
)

# Calculate accuracy metrics
cat("\nAccuracy metrics for forecasts:\n")
cat("\nARIMA model:\n")
arima_accuracy <- accuracy(arima_forecast$mean, spain_test$Value)
print(arima_accuracy)

cat("\nETS model:\n")
ets_accuracy <- accuracy(ets_forecast$mean, spain_test$Value)
print(ets_accuracy)

cat("\nTBATS model:\n")
tbats_accuracy <- accuracy(tbats_forecast$mean, spain_test$Value)
print(tbats_accuracy)

# Determine the best model based on RMSE
models <- c("ARIMA", "ETS", "TBATS")
rmse_values <- c(arima_accuracy[1, "RMSE"], ets_accuracy[1, "RMSE"], tbats_accuracy[1, "RMSE"])
best_model_index <- which.min(rmse_values)
best_model <- models[best_model_index]

cat("\nBest model based on RMSE:", best_model, "with RMSE =", min(rmse_values), "\n")

# Save accuracy metrics to a data frame
accuracy_df <- data.frame(
  Model = models,
  RMSE = rmse_values,
  ME = c(arima_accuracy[1, "ME"], ets_accuracy[1, "ME"], tbats_accuracy[1, "ME"]),
  MAE = c(arima_accuracy[1, "MAE"], ets_accuracy[1, "MAE"], tbats_accuracy[1, "MAE"]),
  MAPE = c(arima_accuracy[1, "MAPE"], ets_accuracy[1, "MAPE"], tbats_accuracy[1, "MAPE"])
)

# Save accuracy metrics to CSV
write_csv(accuracy_df, "~/r-environment-for-researcher/scripts/zenodo_analysis/model_accuracy_metrics.csv")

# Create a long format data frame for plotting
forecast_long <- forecast_df %>%
  pivot_longer(cols = c(Actual, ARIMA, ETS, TBATS),
               names_to = "Model",
               values_to = "Value")

# Plot actual vs forecasted values
forecast_plot <- ggplot(forecast_long, aes(x = Date, y = Value, color = Model)) +
  geom_line() +
  labs(
    title = "Spain's Hospital Occupancy: Actual vs Forecasted (2022)",
    x = "Date",
    y = "Number of Patients",
    color = "Data Source"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the plot
ggsave("~/r-environment-for-researcher/scripts/zenodo_analysis/spain_forecast_comparison.png", 
       forecast_plot, width = 10, height = 6, dpi = 300)

# Create a plot with prediction intervals for the best model
if (best_model == "ARIMA") {
  best_forecast <- arima_forecast
} else if (best_model == "ETS") {
  best_forecast <- ets_forecast
} else {
  best_forecast <- tbats_forecast
}

# Convert forecast object to data frame with prediction intervals
best_forecast_df <- data.frame(
  Date = forecast_dates,
  Actual = spain_test$Value,
  Forecast = as.numeric(best_forecast$mean),
  Lower80 = as.numeric(best_forecast$lower[, 1]),
  Upper80 = as.numeric(best_forecast$upper[, 1]),
  Lower95 = as.numeric(best_forecast$lower[, 2]),
  Upper95 = as.numeric(best_forecast$upper[, 2])
)

# Plot the best model forecast with prediction intervals
best_model_plot <- ggplot(best_forecast_df, aes(x = Date)) +
  geom_ribbon(aes(ymin = Lower95, ymax = Upper95), fill = "lightblue", alpha = 0.3) +
  geom_ribbon(aes(ymin = Lower80, ymax = Upper80), fill = "lightblue", alpha = 0.5) +
  geom_line(aes(y = Forecast, color = "Forecast"), size = 1) +
  geom_line(aes(y = Actual, color = "Actual"), size = 1) +
  labs(
    title = paste("Spain's Hospital Occupancy: Best Model (", best_model, ") Forecast for 2022", sep = ""),
    subtitle = paste("RMSE =", round(rmse_values[best_model_index], 2)),
    x = "Date",
    y = "Number of Patients",
    color = "Data Source"
  ) +
  scale_color_manual(values = c("Actual" = "black", "Forecast" = "blue")) +
  theme_minimal() +
  theme(legend.position = "bottom")

# Save the plot
ggsave("~/r-environment-for-researcher/scripts/zenodo_analysis/spain_best_model_forecast.png", 
       best_model_plot, width = 10, height = 6, dpi = 300)

# Save the forecast results to CSV
write_csv(forecast_df, "~/r-environment-for-researcher/scripts/zenodo_analysis/spain_forecast_results.csv")

# Create a summary of the analysis
cat("\nSaving analysis summary...\n")
sink("~/r-environment-for-researcher/scripts/zenodo_analysis/spain_prediction_summary.txt")
cat("Time Series Prediction Model for Spain's Hospital Occupancy\n")
cat("=========================================================\n\n")
cat("Data Information:\n")
cat("- Country: Spain\n")
cat("- Measure: Daily hospital occupancy\n")
cat("- Training period:", format(min(spain_train$time1), "%Y-%m-%d"), "to", format(max(spain_train$time1), "%Y-%m-%d"), "\n")
cat("- Test period:", format(min(spain_test$time1), "%Y-%m-%d"), "to", format(max(spain_test$time1), "%Y-%m-%d"), "\n")
cat("- Training observations:", nrow(spain_train), "\n")
cat("- Test observations:", nrow(spain_test), "\n\n")

cat("Models Evaluated:\n")
cat("1. ARIMA:", capture.output(arima_model)[1], "\n")
cat("2. ETS:", capture.output(ets_model)[1], "\n")
cat("3. TBATS\n\n")

cat("Accuracy Metrics:\n")
cat("- ARIMA RMSE:", arima_accuracy[1, "RMSE"], "\n")
cat("- ETS RMSE:", ets_accuracy[1, "RMSE"], "\n")
cat("- TBATS RMSE:", tbats_accuracy[1, "RMSE"], "\n\n")

cat("Best Model:", best_model, "with RMSE =", min(rmse_values), "\n\n")

cat("Files Generated:\n")
cat("- spain_hospital_ts.png: Time series plot of training data\n")
cat("- spain_decomposition.png: Decomposition of the time series\n")
cat("- spain_forecast_comparison.png: Comparison of all model forecasts\n")
cat("- spain_best_model_forecast.png: Best model forecast with prediction intervals\n")
cat("- spain_forecast_results.csv: CSV file with all forecast results\n")
sink()

cat("\nAnalysis complete. Results saved to files in the scripts/zenodo_analysis directory.\n")
