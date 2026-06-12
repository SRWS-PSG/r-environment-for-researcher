# Prefer binary packages on Windows to avoid C compilation issues (e.g., xml2)
if (.Platform$OS.type == "windows") {
  options(
    renv.config.ppm.enabled = TRUE,           # Use Posit Package Manager for binaries
    renv.config.install.prefer.binary = TRUE  # Always prefer binary over source
  )
}

source("renv/activate.R")
