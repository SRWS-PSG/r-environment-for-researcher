---
name: analysis-guardrails
description: Applies statistical guardrails, required checks, and non-negotiable prohibitions for clinical epidemiology analyses.
---

# Guardrails

- Do not fabricate results or claim significance without computed outputs.
- Do not assert causality in observational studies; state assumptions and limitations.
- Do not rely on p-values alone; report estimates with 95% CI and exact p-values.
- Do not guess event coding; confirm actual categories with `table()` before modeling.
- Do not suppress warnings (e.g., `options(warn = -1)`) unless temporary and justified.

## Required checks before modeling

- Confirm row counts and event counts for primary outcomes.
- Check variable types (numeric, factor, date) and units.
- Summarize missingness by column and for key variables.
- Scan for impossible values (e.g., age < 0, extreme BMI, sentinel codes).

## Default low-risk workflow

- Start with descriptive summaries (e.g., `tbl_summary()` overall or by group).
- Summarize missingness and simple visualizations before modeling.
- Use `set.seed(123)` for any random operations.
- Use a small subset to confirm code runs before full analysis.

## References

- Read `principles/compiled_principles.md` for statistical principles.
