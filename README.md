# 臨床疫学研究のためのR環境

このリポジトリは、臨床疫学研究のための統計解析環境をセットアップするためのスクリプトとガイドラインを提供します。STROBE statement、BMJ、JAMAなどから抽出した統計の原則に基づいています。

## ディレクトリ構造

```
r-environment-for-researcher/
├── .agent/skills/       # AIアシスタント用スキル（10個）
├── data/                # サンプルデータ
├── docs/                # ドキュメント
├── principles/          # 統計原則ガイドライン（STROBE, BMJ, JAMA）
├── scripts/             # 解析スクリプト
│   ├── plos_analysis/   # PLOS論文再現解析（生存分析）
│   └── zenodo_analysis/ # ECDC時系列解析・予測モデル
├── renv.lock            # パッケージ依存関係（renv）
├── AGENTS.md            # AIアシスタント向けガイド
└── setup.sh             # 環境セットアップ（Ubuntu用）
```

## 環境セットアップ

### 必要条件

| OS | Rインストール方法 |
|----|-------------------|
| Ubuntu/Debian | `./setup.sh` またはCRANから |
| macOS | `brew install r` または [CRAN](https://cran.r-project.org/) |
| Windows | [CRAN](https://cran.r-project.org/) |

R 4.5.2以上を前提にしています（`renv.lock`のRバージョンに合わせています）。

### インストール方法

```bash
git clone https://github.com/SRWS-PSG/r-environment-for-researcher.git
cd r-environment-for-researcher

# renvでパッケージをインストール（全OS共通）
Rscript -e 'install.packages("renv"); renv::restore()'
```

> **Note**: `renv::restore()` により、`renv.lock` に記録されたパッケージとバージョンが自動的にインストールされます。

## 含まれるパッケージ

パッケージは `renv.lock` で管理されています。

| パッケージ | 用途 |
|------------|------|
| tidyverse | データ操作と可視化 |
| ggplot2 | 高度なデータ可視化 |
| dplyr | データ操作 |
| gtsummary | 統計表の作成（Table 1など） |
| WeightIt | IPTW（傾向スコア解析） |
| mice | 多重代入法（欠測データ処理） |
| survival | 生存分析（Kaplan-Meier、Cox回帰） |
| epiR | 疫学統計（リスク比、オッズ比） |

## 統計原則

`principles/compiled_principles.md`ファイルには、臨床疫学研究における統計の原則がまとめられています。これらの原則は以下のソースから抽出されました：

- STROBE statement (`principles/strobe_principles.md`)
- BMJ統計ガイドライン (`principles/bmj_principles.md`)
- JAMA著者向け指示 (`principles/jama_principles.md`)

## 使用例

### 基本的な解析例
`scripts/updated_example.R`スクリプトは、インストールされたパッケージを使用した包括的な解析例を提供します：

```bash
Rscript scripts/updated_example.R
```

### PLOS論文再現解析
`scripts/plos_analysis/`は、PLOS ONE論文の生存分析を再現する例を提供します：

- Kaplan-Meier曲線の作成
- Cox比例ハザードモデル
- Table 1（gtsummary）

```bash
Rscript scripts/plos_analysis/fixed_cox_analysis.R
```

### Zenodo時系列解析
`scripts/zenodo_analysis/`は、ECDCの病院・ICUデータを分析する実例を提供します：

```bash
Rscript scripts/zenodo_analysis/zenodo_data_analysis.R
```

このスクリプトには以下の例が含まれています：

1. データ準備と記述統計（gtsummaryを使用）
2. データ可視化（ggplot2を使用）
3. 回帰分析（gtsummaryを使用）
4. 傾向スコア解析（WeightItを使用）
5. 時系列予測モデル（spain_prediction_model.R）

## AIアシスタント機能

このリポジトリはAIアシスタント（Gemini CLI / Antigravity）と連携して使用できます。

### スキル一覧

| スキル | 説明 |
|--------|------|
| analysis-intake | 研究目的・変数・欠測状況の収集 |
| data-wrangling | データ読込・型変換・欠測診断 |
| analysis-hitl-plan | Human-in-the-loop解析計画 |
| analysis-guardrails | 統計的ガードレールと禁止事項 |
| analysis-templates | 既存スクリプトのテンプレート活用 |
| causal-iptw-weightit | WeightItによるIPTW解析 |
| output-and-naming-standards | 出力形式・命名規則 |
| r-troubleshooting | Rエラーのトラブルシューティング |
| data-privacy-handling | 機密データの取扱い |

詳細は [AGENTS.md](./AGENTS.md) を参照してください。

## トラブルシューティング

一般的な問題と解決策については、`docs/troubleshooting.md`ファイルを参照してください。

## ライセンス

MIT
