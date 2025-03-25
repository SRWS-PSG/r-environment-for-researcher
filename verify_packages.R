# Script to verify R package installation

# Function to check if a package is installed and can be loaded
check_package <- function(package_name) {
  if (package_name %in% rownames(installed.packages())) {
    tryCatch({
      library(package_name, character.only = TRUE)
      cat(paste0("✓ Package '", package_name, "' is installed and loaded successfully.\n"))
      return(TRUE)
    }, error = function(e) {
      cat(paste0("✗ Package '", package_name, "' is installed but could not be loaded: ", e$message, "\n"))
      return(FALSE)
    })
  } else {
    cat(paste0("✗ Package '", package_name, "' is not installed.\n"))
    return(FALSE)
  }
}

# List of packages to check
packages <- c("tidyverse", "ggplot2", "dplyr", "gtsummary", "WeightIt")

# Check each package
cat("Verifying R package installation:\n")
cat("--------------------------------\n")
results <- sapply(packages, check_package)

# Summary
cat("\nSummary:\n")
cat("--------\n")
cat(paste0("Total packages checked: ", length(packages), "\n"))
cat(paste0("Successfully loaded: ", sum(results), "\n"))
cat(paste0("Failed: ", length(packages) - sum(results), "\n"))

# Check if WeightIt was used instead of iptw
if ("WeightIt" %in% packages && !("iptw" %in% packages)) {
  cat("\nNote: 'WeightIt' package was installed instead of 'iptw' as it provides\n")
  cat("similar functionality for inverse probability of treatment weighting (IPTW)\n")
  cat("and is more actively maintained.\n")
}

# Print R version information
cat("\nR version information:\n")
cat("---------------------\n")
cat(paste0("R version: ", R.version.string, "\n"))
cat(paste0("R home: ", R.home(), "\n"))
cat(paste0("R library paths:\n"))
cat(paste0(" - ", .libPaths(), collapse = "\n"))
