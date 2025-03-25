#!/bin/bash

# R Clinical Epidemiology Environment Setup Script
# This script sets up R and required packages for clinical epidemiology research

# Exit on error
set -e

echo "Setting up R environment for clinical epidemiology research..."

# Update system packages
echo "Updating system packages..."
sudo apt-get update

# Add R repository
echo "Adding R repository..."
sudo apt-get install -y --no-install-recommends software-properties-common dirmngr
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"

# Install R
echo "Installing R..."
sudo apt-get update
sudo apt-get install -y --no-install-recommends r-base r-base-dev

# Install system dependencies for R packages
echo "Installing system dependencies for R packages..."
sudo apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev \
  libssl-dev \
  libxml2-dev \
  libfontconfig1-dev \
  libharfbuzz-dev \
  libfribidi-dev \
  libfreetype6-dev \
  libpng-dev \
  libtiff5-dev \
  libjpeg-dev

# Install R packages
echo "Installing R packages..."
sudo Rscript -e 'install.packages(c("tidyverse", "ggplot2", "dplyr", "gtsummary", "WeightIt"), repos="https://cloud.r-project.org/")'

# Verify installation
echo "Verifying installation..."
Rscript -e 'cat("R version:", R.version.string, "\n"); installed <- installed.packages(); pkgs <- c("tidyverse", "ggplot2", "dplyr", "gtsummary", "WeightIt"); for(pkg in pkgs) { if(pkg %in% rownames(installed)) { cat("✓", pkg, "version", packageVersion(pkg), "\n") } else { cat("✗", pkg, "not installed\n") } }'

echo "Setup complete!"
