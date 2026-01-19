---
name: data-wrangling
description: Guides data import, type conversion, missing data diagnosis, and cleaning for Gate 0B implementation.
---

# Data Wrangling (Gate 0B Implementation)

## 1. Data import

- Confirm file types (CSV, Excel, RDS, etc.).
- Handle encoding (UTF-8, Shift-JIS/CP932).
- Confirm with the user before installing new packages.

Package availability check:

Before using packages, confirm availability:

```r
# First run scripts/verify_packages.R to check package availability.

# Then use requireNamespace guards:
if (requireNamespace("readr", quietly = TRUE)) {
  df <- readr::read_csv("path/to/file.csv")
} else {
  df <- read.csv("path/to/file.csv", stringsAsFactors = FALSE)
}

if (requireNamespace("readxl", quietly = TRUE)) {
  df <- readxl::read_excel("path/to/file.xlsx")
} else {
  message("readxl not available; use an alternative import method or confirm installation")
}

# For Shift-JIS/CP932 CSVs, use readr locale when available:
# df <- readr::read_csv("path/to/file.csv", locale = readr::locale(encoding = "CP932"))
```

## 2. Type verification and conversion

- Use `str()` and `summary()` to review types.
- Convert as needed:
  - character -> factor: `as.factor()` or `forcats::as_factor()` (if available)
  - date parsing: `as.Date()` or `lubridate::ymd()` (if available)
  - numeric conversion: `as.numeric()` after checking non-numeric strings
- Guard optional packages with `requireNamespace()`.

## 3. Sentinel value handling (user confirmation required)

> [!CAUTION]
> Converting sentinel values (e.g., 999, -1, "NA" strings) is a statistical decision.
> Confirm with the data dictionary/codebook and the user before making changes.

```r
# Example after confirmation and documentation:
# - 999 in age -> NA (confirmed as missing indicator)
# - -1 in score -> NA (confirmed as not applicable)
df$age[df$age == 999] <- NA
df$score[df$score == -1] <- NA
```

## 4. Missing data diagnosis

- Missingness rate: `colMeans(is.na(df))`

Optional visualization (only if available):

```r
if (requireNamespace("naniar", quietly = TRUE)) {
  naniar::vis_miss(df)
} else {
  # Base R alternative
  missing_pct <- colMeans(is.na(df)) * 100
  barplot(missing_pct, las = 2, main = "Missing Data by Variable")
}

if (requireNamespace("visdat", quietly = TRUE)) {
  visdat::vis_dat(df)
}
```

## 5. Data cleaning

- Outlier detection: boxplot, z-scores, IQR.
- Range checks: logically impossible values (e.g., age < 0, BMI > 100).
- Duplicate rows: `duplicated()`.
- Confirm thresholds and rules with the user before applying changes.

## 6. Variable mapping documentation

- Map `names()` to paper/codebook terms and document the mapping.
- Confirm units (kg vs lb, cm vs m) and record conversions.

## 7. Outputs and logging

> [!IMPORTANT]
> To protect privacy, store cleaned data in a gitignored directory.

- Validate on synthetic/sample data before running on private data.
- Cleaned data: save to `data/private/` (gitignored).
- Logs/diagnostics: save under `scripts/<analysis_name>/output` with English text only.

```r
private_dir <- "data/private"
if (!dir.exists(private_dir)) dir.create(private_dir, recursive = TRUE)
saveRDS(df_clean, file.path(private_dir, "cleaned_data.rds"))

output_dir <- "scripts/<analysis_name>/output"
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)
writeLines(
  c("Cleaning log", "Document rules, counts, and exclusions here."),
  file.path(output_dir, "cleaning_log.txt")
)
```
