---
name: data-privacy-handling
description: Handles sensitive data placement, git hygiene, and synthetic-data-first verification.
---

# Data Privacy and Handling

- Do not commit sensitive or personal data.
- Store private datasets under `data/private/` and add to `.gitignore`.
- Validate code on synthetic or sample data before running on real data.
- Avoid including raw private data in outputs or logs.
