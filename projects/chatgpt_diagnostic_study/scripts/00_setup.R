# ============================================================================
# ChatGPT Diagnostic Accuracy Study - Environment Setup
# ============================================================================
# Paper: Evaluation of ChatGPT as a diagnostic tool for medical learners
#        and clinicians (PLOS ONE, DOI: 10.1371/journal.pone.0307383)
# ============================================================================

# Set seed for reproducibility
set.seed(123)

# Required packages
packages <- c(
  "tidyverse",   # Data manipulation and visualization
  "readxl",      # Excel file import
  "pROC",        # ROC curve analysis
  "irr",         # Inter-rater reliability (Cohen's Kappa)
  "gt",          # Table formatting
  "here"         # Path management
)

# Install missing packages
installed <- packages %in% rownames(installed.packages())
if (any(!installed)) {
  install.packages(packages[!installed])
}

# Load packages
suppressPackageStartupMessages({
  library(tidyverse)
  library(readxl)
  library(pROC)
  library(irr)
  library(gt)
  library(here)
})

# Session info
cat("=== Environment Setup Complete ===\n")
cat("R version:", R.version.string, "\n")
cat("Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")

cat("Package versions:\n")
for (pkg in packages) {
  ver <- packageVersion(pkg)
  cat(sprintf("  %s: %s\n", pkg, ver))
}

# Project paths
project_root <- here::here("projects", "chatgpt_diagnostic_study")
data_raw <- file.path(project_root, "data", "raw")
data_processed <- file.path(project_root, "data", "processed")
output_dir <- file.path(project_root, "output")
output_figures <- file.path(output_dir, "figures")
output_tables <- file.path(output_dir, "tables")

# Create directories if they don't exist
dirs_to_create <- c(data_processed, output_figures, output_tables)
for (d in dirs_to_create) {
  if (!dir.exists(d)) {
    dir.create(d, recursive = TRUE)
    cat("Created directory:", d, "\n")
  }
}

cat("\n=== Project Paths ===\n")
cat("Project root:", project_root, "\n")
cat("Raw data:", data_raw, "\n")
cat("Processed data:", data_processed, "\n")
cat("Output figures:", output_figures, "\n")
cat("Output tables:", output_tables, "\n")
