# Cox Proportional Hazard Model Analysis for PLOS ONE Article: 
# "Self-rated health status and illiteracy as death predictors in a Brazilian cohort"
# Article URL: https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0200501

# Load required libraries
library(tidyverse)
library(readxl)
library(survival)
library(gtsummary)

# Set working directory and file path
data_path <- "~/r-environment-for-researcher/data/Renamed_660b8.xls"

# Load the data
cat("Loading data from:", data_path, "\n")
cohort_data <- read_excel(data_path)

# Clean and prepare data for analysis
cat("\nCleaning and preparing data for analysis...\n")

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

# Remove rows with missing values in key variables
cohort_data_complete <- cohort_data %>%
  filter(!is.na(all_mortality) & !is.na(illiterate) & !is.na(poor_srh) & 
         !is.na(age) & !is.na(female) & !is.na(hypertension) & 
         !is.na(current_smoker) & !is.na(sedentary))

cat("\nComplete cases for analysis:", nrow(cohort_data_complete), "\n")

# Cox Proportional Hazard Models
cat("\nRunning Cox Proportional Hazard Models...\n")

# 1. All-cause mortality models

# Unadjusted models
cat("\n1. All-cause mortality models\n")
cat("\nUnadjusted models:\n")

# Illiteracy unadjusted
illiterate_unadj <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ illiterate, 
                         data = cohort_data_complete)
cat("\nIlliteracy unadjusted model:\n")
print(summary(illiterate_unadj))

# Poor SRH unadjusted
srh_unadj <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ poor_srh, 
                  data = cohort_data_complete)
cat("\nPoor self-rated health unadjusted model:\n")
print(summary(srh_unadj))

# Adjusted models
cat("\nAdjusted models (demographic factors):\n")

# Illiteracy adjusted for demographics
illiterate_adj_demo <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ 
                            illiterate + age + female, 
                            data = cohort_data_complete)
cat("\nIlliteracy adjusted for demographics model:\n")
print(summary(illiterate_adj_demo))

# Poor SRH adjusted for demographics
srh_adj_demo <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ 
                     poor_srh + age + female, 
                     data = cohort_data_complete)
cat("\nPoor self-rated health adjusted for demographics model:\n")
print(summary(srh_adj_demo))

# Fully adjusted models
cat("\nFully adjusted models (demographics + risk factors):\n")

# Illiteracy fully adjusted
illiterate_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ 
                            illiterate + age + female + hypertension + 
                            current_smoker + sedentary, 
                            data = cohort_data_complete)
cat("\nIlliteracy fully adjusted model:\n")
print(summary(illiterate_adj_full))

# Poor SRH fully adjusted
srh_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ 
                     poor_srh + age + female + hypertension + 
                     current_smoker + sedentary, 
                     data = cohort_data_complete)
cat("\nPoor self-rated health fully adjusted model:\n")
print(summary(srh_adj_full))

# Combined model (both predictors)
combined_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), all_mortality) ~ 
                          illiterate + poor_srh + age + female + hypertension + 
                          current_smoker + sedentary, 
                          data = cohort_data_complete)
cat("\nCombined (illiteracy + poor SRH) fully adjusted model:\n")
print(summary(combined_adj_full))

# 2. Cardiovascular mortality models
cat("\n2. Cardiovascular mortality models\n")

# Unadjusted models
cat("\nUnadjusted models:\n")

# Illiteracy unadjusted
illiterate_cv_unadj <- coxph(Surv(rep(1, nrow(cohort_data_complete)), cv_mortality) ~ illiterate, 
                            data = cohort_data_complete)
cat("\nIlliteracy unadjusted model (CV mortality):\n")
print(summary(illiterate_cv_unadj))

# Poor SRH unadjusted
srh_cv_unadj <- coxph(Surv(rep(1, nrow(cohort_data_complete)), cv_mortality) ~ poor_srh, 
                     data = cohort_data_complete)
cat("\nPoor self-rated health unadjusted model (CV mortality):\n")
print(summary(srh_cv_unadj))

# Fully adjusted models
cat("\nFully adjusted models (demographics + risk factors):\n")

# Illiteracy fully adjusted
illiterate_cv_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), cv_mortality) ~ 
                               illiterate + age + female + hypertension + 
                               current_smoker + sedentary, 
                               data = cohort_data_complete)
cat("\nIlliteracy fully adjusted model (CV mortality):\n")
print(summary(illiterate_cv_adj_full))

# Poor SRH fully adjusted
srh_cv_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), cv_mortality) ~ 
                        poor_srh + age + female + hypertension + 
                        current_smoker + sedentary, 
                        data = cohort_data_complete)
cat("\nPoor self-rated health fully adjusted model (CV mortality):\n")
print(summary(srh_cv_adj_full))

# Combined model (both predictors)
combined_cv_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), cv_mortality) ~ 
                             illiterate + poor_srh + age + female + hypertension + 
                             current_smoker + sedentary, 
                             data = cohort_data_complete)
cat("\nCombined (illiteracy + poor SRH) fully adjusted model (CV mortality):\n")
print(summary(combined_cv_adj_full))

# 3. Non-cardiovascular mortality models
cat("\n3. Non-cardiovascular mortality models\n")

# Unadjusted models
cat("\nUnadjusted models:\n")

# Illiteracy unadjusted
illiterate_noncv_unadj <- coxph(Surv(rep(1, nrow(cohort_data_complete)), noncv_mortality) ~ illiterate, 
                               data = cohort_data_complete)
cat("\nIlliteracy unadjusted model (non-CV mortality):\n")
print(summary(illiterate_noncv_unadj))

# Poor SRH unadjusted
srh_noncv_unadj <- coxph(Surv(rep(1, nrow(cohort_data_complete)), noncv_mortality) ~ poor_srh, 
                        data = cohort_data_complete)
cat("\nPoor self-rated health unadjusted model (non-CV mortality):\n")
print(summary(srh_noncv_unadj))

# Fully adjusted models
cat("\nFully adjusted models (demographics + risk factors):\n")

# Illiteracy fully adjusted
illiterate_noncv_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), noncv_mortality) ~ 
                                  illiterate + age + female + hypertension + 
                                  current_smoker + sedentary, 
                                  data = cohort_data_complete)
cat("\nIlliteracy fully adjusted model (non-CV mortality):\n")
print(summary(illiterate_noncv_adj_full))

# Poor SRH fully adjusted
srh_noncv_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), noncv_mortality) ~ 
                           poor_srh + age + female + hypertension + 
                           current_smoker + sedentary, 
                           data = cohort_data_complete)
cat("\nPoor self-rated health fully adjusted model (non-CV mortality):\n")
print(summary(srh_noncv_adj_full))

# Combined model (both predictors)
combined_noncv_adj_full <- coxph(Surv(rep(1, nrow(cohort_data_complete)), noncv_mortality) ~ 
                                illiterate + poor_srh + age + female + hypertension + 
                                current_smoker + sedentary, 
                                data = cohort_data_complete)
cat("\nCombined (illiteracy + poor SRH) fully adjusted model (non-CV mortality):\n")
print(summary(combined_noncv_adj_full))

# Create summary tables for hazard ratios
cat("\nCreating summary tables for hazard ratios...\n")

# Function to extract hazard ratios and confidence intervals
extract_hr <- function(model, var_name) {
  coef <- coef(model)[var_name]
  hr <- exp(coef)
  ci <- exp(confint(model)[var_name, ])
  return(c(hr = hr, lower_ci = ci[1], upper_ci = ci[2], p_value = summary(model)$coefficients[var_name, 5]))
}

# All-cause mortality hazard ratios
all_cause_illiterate <- data.frame(
  Outcome = "All-cause mortality",
  Predictor = "Illiteracy",
  Model = c("Unadjusted", "Adjusted for demographics", "Fully adjusted"),
  rbind(
    extract_hr(illiterate_unadj, "illiterate"),
    extract_hr(illiterate_adj_demo, "illiterate"),
    extract_hr(illiterate_adj_full, "illiterate")
  )
)

all_cause_srh <- data.frame(
  Outcome = "All-cause mortality",
  Predictor = "Poor self-rated health",
  Model = c("Unadjusted", "Adjusted for demographics", "Fully adjusted"),
  rbind(
    extract_hr(srh_unadj, "poor_srh"),
    extract_hr(srh_adj_demo, "poor_srh"),
    extract_hr(srh_adj_full, "poor_srh")
  )
)

# Cardiovascular mortality hazard ratios
cv_illiterate <- data.frame(
  Outcome = "Cardiovascular mortality",
  Predictor = "Illiteracy",
  Model = c("Unadjusted", "Fully adjusted"),
  rbind(
    extract_hr(illiterate_cv_unadj, "illiterate"),
    extract_hr(illiterate_cv_adj_full, "illiterate")
  )
)

cv_srh <- data.frame(
  Outcome = "Cardiovascular mortality",
  Predictor = "Poor self-rated health",
  Model = c("Unadjusted", "Fully adjusted"),
  rbind(
    extract_hr(srh_cv_unadj, "poor_srh"),
    extract_hr(srh_cv_adj_full, "poor_srh")
  )
)

# Non-cardiovascular mortality hazard ratios
noncv_illiterate <- data.frame(
  Outcome = "Non-cardiovascular mortality",
  Predictor = "Illiteracy",
  Model = c("Unadjusted", "Fully adjusted"),
  rbind(
    extract_hr(illiterate_noncv_unadj, "illiterate"),
    extract_hr(illiterate_noncv_adj_full, "illiterate")
  )
)

noncv_srh <- data.frame(
  Outcome = "Non-cardiovascular mortality",
  Predictor = "Poor self-rated health",
  Model = c("Unadjusted", "Fully adjusted"),
  rbind(
    extract_hr(srh_noncv_unadj, "poor_srh"),
    extract_hr(srh_noncv_adj_full, "poor_srh")
  )
)

# Combine all hazard ratio tables
all_hr_tables <- rbind(
  all_cause_illiterate,
  all_cause_srh,
  cv_illiterate,
  cv_srh,
  noncv_illiterate,
  noncv_srh
)

# Format the hazard ratios and confidence intervals
all_hr_tables$HR_CI <- sprintf("%.2f (%.2f-%.2f)", 
                              all_hr_tables$hr, 
                              all_hr_tables$lower_ci, 
                              all_hr_tables$upper_ci)
all_hr_tables$p_value_formatted <- ifelse(all_hr_tables$p_value < 0.001, 
                                         "<0.001", 
                                         sprintf("%.3f", all_hr_tables$p_value))

# Create a clean summary table
hr_summary <- all_hr_tables %>%
  select(Outcome, Predictor, Model, HR_CI, p_value_formatted) %>%
  rename(`Hazard Ratio (95% CI)` = HR_CI, `P-value` = p_value_formatted)

# Save the hazard ratio summary table to CSV
write.csv(hr_summary, "~/r-environment-for-researcher/scripts/plos_analysis/hazard_ratio_summary.csv", 
          row.names = FALSE)

# Create Kaplan-Meier survival curves
cat("\nCreating Kaplan-Meier survival curves...\n")

# Create survival objects
surv_all <- Surv(rep(1, nrow(cohort_data_complete)), cohort_data_complete$all_mortality)
surv_cv <- Surv(rep(1, nrow(cohort_data_complete)), cohort_data_complete$cv_mortality)
surv_noncv <- Surv(rep(1, nrow(cohort_data_complete)), cohort_data_complete$noncv_mortality)

# Kaplan-Meier curves by literacy status
km_illiterate_all <- survfit(surv_all ~ illiterate, data = cohort_data_complete)
km_illiterate_cv <- survfit(surv_cv ~ illiterate, data = cohort_data_complete)
km_illiterate_noncv <- survfit(surv_noncv ~ illiterate, data = cohort_data_complete)

# Kaplan-Meier curves by self-rated health status
km_srh_all <- survfit(surv_all ~ poor_srh, data = cohort_data_complete)
km_srh_cv <- survfit(surv_cv ~ poor_srh, data = cohort_data_complete)
km_srh_noncv <- survfit(surv_noncv ~ poor_srh, data = cohort_data_complete)

# Log-rank tests
cat("\nLog-rank tests:\n")

# Literacy status
cat("\nLog-rank test for literacy status (all-cause mortality):\n")
print(survdiff(surv_all ~ illiterate, data = cohort_data_complete))

cat("\nLog-rank test for literacy status (CV mortality):\n")
print(survdiff(surv_cv ~ illiterate, data = cohort_data_complete))

cat("\nLog-rank test for literacy status (non-CV mortality):\n")
print(survdiff(surv_noncv ~ illiterate, data = cohort_data_complete))

# Self-rated health status
cat("\nLog-rank test for self-rated health status (all-cause mortality):\n")
print(survdiff(surv_all ~ poor_srh, data = cohort_data_complete))

cat("\nLog-rank test for self-rated health status (CV mortality):\n")
print(survdiff(surv_cv ~ poor_srh, data = cohort_data_complete))

cat("\nLog-rank test for self-rated health status (non-CV mortality):\n")
print(survdiff(surv_noncv ~ poor_srh, data = cohort_data_complete))

# Save basic Kaplan-Meier plots
png("~/r-environment-for-researcher/scripts/plos_analysis/km_illiterate_all.png", 
    width = 800, height = 600)
plot(km_illiterate_all, 
     main = "Kaplan-Meier Survival Curves by Literacy Status (All-cause Mortality)",
     xlab = "Time", ylab = "Survival Probability",
     lty = c(1, 2), col = c("blue", "red"),
     mark.time = FALSE)
legend("bottomleft", legend = c("Literate", "Illiterate"), 
       lty = c(1, 2), col = c("blue", "red"))
dev.off()

png("~/r-environment-for-researcher/scripts/plos_analysis/km_srh_all.png", 
    width = 800, height = 600)
plot(km_srh_all, 
     main = "Kaplan-Meier Survival Curves by Self-rated Health Status (All-cause Mortality)",
     xlab = "Time", ylab = "Survival Probability",
     lty = c(1, 2), col = c("blue", "red"),
     mark.time = FALSE)
legend("bottomleft", legend = c("Good/Excellent SRH", "Poor/Regular SRH"), 
       lty = c(1, 2), col = c("blue", "red"))
dev.off()

cat("\nAnalysis complete. Results saved to scripts/plos_analysis directory.\n")
