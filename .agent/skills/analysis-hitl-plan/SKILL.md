---
name: analysis-hitl-plan
description: Defines the human-in-the-loop analysis plan with data dictionary mapping, variable definitions, model specs, and output agreements.
---

# Human-in-the-Loop Plan

- Draft the plan as an agreement document before implementation.
- Include a data dictionary mapping: list `names()` and `str()` and map to paper terms (e.g., MBP = MAP).
- Define primary variables explicitly: outcome events, time origin, censoring, reference categories, units, and transformations.
- Specify the model as a formula, including covariates and exclusion rules (e.g., VIF threshold).
- Specify outputs: file names, formats, and column order for tables; require PNG (300 dpi) plus PDF for figures.
- Present Gate A–D approvals and wait for user confirmation:
  - Gate A: data dictionary mapping
  - Gate B: variable definitions (especially time-to-event and reference groups)
  - Gate C: model specification and exclusions
  - Gate D: expected outputs (tables, figures, file names)
- Run a minimal sample or small subset first to validate variable names, formulas, and outputs.
- Compare basic counts (n, events, key proportions) to expected values and report differences.
- If discrepancies or spec changes arise, update the plan and re-approve before continuing.
- Do not suppress warnings globally; document any temporary warning changes with reasons.
