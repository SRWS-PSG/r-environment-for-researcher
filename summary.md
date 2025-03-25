# 臨床疫学研究のための統計原則と解析環境：概要

## 完了した作業

1. **統計原則の抽出と整理**
   - BMJ、JAMA、STROBE statementから臨床疫学研究における統計の原則を抽出
   - 原則を体系的に整理し、日本語と英語で文書化
   - 研究計画、実施、分析、報告の各段階における重要な統計的考慮事項を網羅

2. **R環境のセットアップ**
   - R 4.1.2のインストールと設定
   - 必要なパッケージのインストール：
     - tidyverse（データ操作と可視化）
     - ggplot2（高度なデータ可視化）
     - dplyr（データ操作）
     - gtsummary（統計的要約表）
     - WeightIt（傾向スコア解析とIPTW）

3. **解析例とドキュメントの作成**
   - 基本的なデータ操作と可視化の例
   - 記述統計、回帰分析、生存時間解析の例
   - 傾向スコア解析と逆確率重み付けの例
   - 縦断データ解析の例

## 作成したファイル

### 統計原則
- `bmj_principles.md` - BMJから抽出した統計原則
- `jama_principles.md` - JAMAから抽出した統計原則
- `strobe_principles.md` - STROBE statementから抽出した統計原則
- `compiled_principles.md` - 統合された統計原則

### R環境と解析
- `example_analysis.R` - 包括的な解析例
- `simple_demo.R` - シンプルな解析デモ
- `verify_packages.R` - パッケージ検証スクリプト
- `check_installed_packages.R` - インストール済みパッケージ確認

### ドキュメント
- `README.md` - プロジェクト概要
- `r_environment_setup.md` - R環境セットアップガイド
- `r_usage_examples.md` - R統計解析の実践例
- `iptw_note.md` - WeightItパッケージについての注記
- `troubleshooting.md` - トラブルシューティングガイド

## 使用方法

1. **統計原則の参照**
   ```
   less ~/statistical_principles/compiled_principles.md
   ```

2. **パッケージの検証**
   ```
   Rscript ~/statistical_principles/verify_packages.R
   ```

3. **サンプル解析の実行**
   ```
   Rscript ~/statistical_principles/simple_demo.R
   ```

4. **詳細な解析例の確認**
   ```
   less ~/statistical_principles/example_analysis.R
   ```

## 注意事項

- WeightItパッケージは、要求されたiptwパッケージの代替として使用しています
- 大規模なデータセットを扱う場合は、メモリ使用量に注意してください
- 解析結果の再現性を確保するために、set.seed()を使用してください
