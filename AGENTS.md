# AIアシスタント向けガイド（臨床疫学R環境）

このリポジトリは、臨床疫学研究でよく使う統計解析をRで再現可能に実行するための環境と例を提供します。
このファイルは概要とスキルへの導線のみを記載します。詳細な手順・ガードレールは `.agent/skills/` を参照してください。

> [!IMPORTANT]
>
> AIは統計的に重要な判断を勝手に確定しないこと。選択肢とメリット・デメリットを示し、ユーザーの意図を確認して進める。

## リポジトリ構造（よく触る場所）

- `principles/`
- `docs/`
- `scripts/`
- `data/`

## まず参照するドキュメント（優先順）

1. `principles/compiled_principles.md`
2. `docs/r_usage_examples.md`
3. `docs/iptw_note.md`
4. `docs/troubleshooting.md`
5. `docs/summary.md`
6. `docs/r_environment_setup.md`
7. `docs/r_update_summary.md`

> [!NOTE]
>
> コマンド例はリポジトリ直下からの相対パスで記載しているため、必要に応じてカレントディレクトリをリポジトリのルートに合わせる。

## Skills (Antigravity)

- `.agent/skills/analysis-intake/SKILL.md` - Collects study goals, design, variables, missingness, and reporting needs before starting clinical epidemiology analysis.
- `.agent/skills/analysis-hitl-plan/SKILL.md` - Defines the human-in-the-loop analysis plan with data dictionary mapping, variable definitions, model specs, and output agreements.
- `.agent/skills/analysis-guardrails/SKILL.md` - Applies statistical guardrails, required checks, and non-negotiable prohibitions for clinical epidemiology analyses.
- `.agent/skills/analysis-templates/SKILL.md` - Selects and reuses existing scripts and docs as templates for common analysis types (descriptive, survival, IPTW, time series).
- `.agent/skills/output-and-naming-standards/SKILL.md` - Enforces output formats, file naming, workflow sequencing, coding style, and reproducibility conventions.
- `.agent/skills/causal-iptw-weightit/SKILL.md` - Guides IPTW with WeightIt, balance diagnostics, and stability checks for causal inference in observational data.
- `.agent/skills/r-troubleshooting/SKILL.md` - Triages R errors using reproducible steps, environment checks, and function disambiguation.
- `.agent/skills/data-privacy-handling/SKILL.md` - Handles sensitive data placement, git hygiene, and synthetic-data-first verification.
