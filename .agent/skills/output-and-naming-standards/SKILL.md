---
name: output-and-naming-standards
description: Enforces output formats, file naming, workflow sequencing, coding style, and reproducibility conventions.
---

# Output and Naming Standards

- Save figures in both PNG (300 dpi) and PDF formats; call `ggsave()` twice with identical size and theme.
- Store outputs under the analysis folder; keep filenames descriptive and consistent.

## Figure saving best practices

- For standard ggplot2 objects: use `ggsave()` twice (PNG and PDF).
- **IMPORTANT**: For `survminer::ggsurvplot()` objects, `ggsave()` does NOT work correctly because ggsurvplot returns a list, not a ggplot object. Use this pattern instead:

```r
# Correct way to save ggsurvplot output
p <- ggsurvplot(fit, data = df, ...)

# Save as PNG
png("output.png", width = 10, height = 8, units = "in", res = 300)
print(p)
dev.off()

# Save as PDF
pdf("output.pdf", width = 10, height = 8)
print(p)
dev.off()
```

- Do NOT use: `ggsave("file.png", print(p))` — this creates empty or corrupted files.

## Windows encoding issues

- Avoid Japanese text in R script output when running on Windows with PowerShell, as the `>` redirect uses CP932/Shift-JIS encoding which corrupts UTF-8 Japanese text.
- Use English for all `cat()` and `print()` messages in scripts.
- HTML output files (gt, gtsummary) handle UTF-8 correctly and can contain Japanese.

## Session information documentation

At the start of each analysis, record and save environment information to the **analysis folder**:

```r
# Record session info to analysis folder
output_dir <- "scripts/<analysis_name>/output"
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE)

sink(file.path(output_dir, "session_info.txt"))
cat("Analysis Date:", format(Sys.time(), "%Y-%m-%d %H:%M:%S"), "\n\n")
cat("R Version:", R.version.string, "\n")
cat("Platform:", R.version$platform, "\n\n")

# RStudio version (with existence check)
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
  cat("RStudio Version:", as.character(rstudioapi::versionInfo()$version), "\n\n")
}

cat("Loaded Packages:\n")
pkgs <- sort(loadedNamespaces())
for (pkg in pkgs) {
  cat(sprintf("  %s %s\n", pkg, as.character(packageVersion(pkg))))
}
sink()
```

- Include session info in the final report or as a separate file.
- Output path should be within the analysis folder (e.g., `scripts/<analysis_name>/output/session_info.txt`).

## File naming patterns

- Data processing: `[NN]_<verb>_data.R` (e.g., `01_import_data.R`).
- Analysis: `[NN]_<analysis>_analysis.R` (e.g., `03_descriptive_analysis.R`).
- Visualization: `[NN]_create_<target>.R` (e.g., `05_create_figures.R`).
- Report: `[NN]_generate_report.R` (e.g., `06_generate_report.R`).
- Utilities: `utils_<function>.R` (e.g., `utils_helper_functions.R`).
- Figure outputs: `<target>_<type>.png` and `<target>_<type>.pdf`.

## Code style and reproducibility

- Follow tidyverse style (snake_case).
- Use a single pipe style consistently (`|>` or `%>%`).
- Write short Japanese comments for non-obvious logic.
- Set a fixed seed (`set.seed(123)`) when randomness is used.
- Capture `sessionInfo()` when needed for reproducibility.

## Cleanup

- Remove temporary or versioned scratch files (e.g., `_v2`, `_simple`) before finishing.
- Leave only the final, working scripts in clear execution order.
