# AGENTS.md

このリポジトリは、臨床疫学研究のためのR統計解析環境を提供します。AIエージェントがこのリポジトリを活用する際のガイドラインです。

## リポジトリ概要

臨床疫学研究における統計解析を行うためのR環境セットアップと、再利用可能な解析スクリプト（スキル）を提供します。STROBE statement、BMJ、JAMAの統計原則に基づいています。

## ディレクトリ構造

```
├── scripts/          # 解析スクリプト（スキル）
├── principles/       # 統計原則ドキュメント
├── docs/            # 技術ドキュメント
├── data/            # サンプルデータ
└── setup.sh         # 環境セットアップスクリプト
```

## スキル（再利用可能なスクリプト）

### 基本スキル

| スクリプト | 説明 | 使用パッケージ |
|-----------|------|---------------|
| `scripts/updated_example.R` | 包括的な臨床疫学解析の例。記述統計、可視化、回帰分析、傾向スコア解析を含む | tidyverse, ggplot2, gtsummary, WeightIt |
| `scripts/simple_demo.R` | パッケージの基本使用法のデモ | tidyverse, gtsummary |
| `scripts/verify_packages.R` | パッケージのインストール確認 | - |

### 高度な解析スキル

#### PLOS Analysis（生存分析）
`scripts/plos_analysis/` ディレクトリ

| スクリプト | 説明 |
|-----------|------|
| `cox_model_analysis.R` | Cox比例ハザードモデルによる生存分析 |
| `fixed_cox_analysis.R` | 修正版Cox分析（多変量調整） |
| `data_exploration.R` | データ探索と前処理 |

#### Zenodo Analysis（時系列予測）
`scripts/zenodo_analysis/` ディレクトリ

| スクリプト | 説明 |
|-----------|------|
| `zenodo_data_analysis.R` | ECDCデータを用いた記述統計・可視化 |
| `spain_prediction_model.R` | 時系列予測モデル（ARIMA等） |

## 統計原則ドキュメント

`principles/` ディレクトリには、臨床疫学研究における統計報告の標準が含まれています。

| ファイル | 内容 |
|---------|------|
| `compiled_principles.md` | 全原則の統合版（推奨参照先） |
| `strobe_principles.md` | STROBE statementからの統計原則 |
| `bmj_principles.md` | BMJ統計ガイドライン |
| `jama_principles.md` | JAMA著者向け統計指示 |

## エージェント利用ガイド

### 解析タスクへの対応

1. **新しい臨床疫学解析を行う場合**
   - まず `principles/compiled_principles.md` を参照し、統計原則を確認
   - `scripts/updated_example.R` をテンプレートとして活用
   - 解析内容に応じて適切なスキルを選択

2. **生存分析を行う場合**
   - `scripts/plos_analysis/fixed_cox_analysis.R` を参照
   - Cox比例ハザードモデル、Kaplan-Meier曲線の作成例あり

3. **傾向スコア解析を行う場合**
   - `scripts/updated_example.R` のExample 4を参照
   - WeightItパッケージによるIPTW（逆確率重み付け）の実装例

4. **時系列データ分析を行う場合**
   - `scripts/zenodo_analysis/spain_prediction_model.R` を参照

### 使用可能なRパッケージ

| パッケージ | 用途 |
|-----------|------|
| tidyverse | データ操作の基盤 |
| ggplot2 | データ可視化 |
| dplyr | データ変換・集計 |
| gtsummary | 出版品質の統計表作成 |
| WeightIt | 傾向スコア・逆確率重み付け |
| survival | 生存分析 |

### コード生成時の注意

- 統計手法の選択時は `principles/compiled_principles.md` の原則に従う
- 表の作成には `gtsummary` パッケージを使用（出版品質）
- 傾向スコア解析には `WeightIt` パッケージを使用（iptwパッケージではない）
- 可視化には `ggplot2` を使用し、論文投稿に適した形式で出力

### トラブルシューティング

環境やパッケージの問題については `docs/troubleshooting.md` を参照してください。

## 環境セットアップ

```bash
./setup.sh
```

このスクリプトはUbuntu Linux環境でR環境と必要なパッケージをインストールします。
