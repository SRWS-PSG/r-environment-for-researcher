---
name: causal-iptw-weightit
description: Guides IPTW with WeightIt, balance diagnostics, and stability checks for causal inference in observational data.
---

# IPTW with WeightIt

- Use `WeightIt` instead of `iptw`; see `docs/iptw_note.md`.
- Confirm estimand (ATE vs ATT) and trimming rules with the user before modeling.
- Inspect extreme propensity scores (near 0 or 1) and extreme weights; report instability risks.
- Perform balance diagnostics (e.g., `WeightIt::summary()`; `cobalt::bal.tab()` and `cobalt::love.plot()` if available).
- Report balance metrics (e.g., SMD) alongside model results.
- Avoid causal language; state assumptions and limitations explicitly.
