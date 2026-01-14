---
name: output-and-naming-standards
description: Enforces output formats, file naming, workflow sequencing, coding style, and reproducibility conventions.
---

# Output and Naming Standards

- Save figures in both PNG (300 dpi) and PDF formats; call `ggsave()` twice with identical size and theme.
- Store outputs under the analysis folder; keep filenames descriptive and consistent.

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
