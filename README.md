# 臨床疫学研究のためのR環境

このリポジトリは、臨床疫学研究のための統計解析環境をセットアップするためのスクリプトとガイドラインを提供します。STROBE statement、BMJ、JAMAなどから抽出した統計の原則に基づいています。

## 環境セットアップ

### 必要条件
- Ubuntu Linux (または互換性のあるディストリビューション)
- sudo権限

### インストール方法

```bash
git clone https://github.com/SRWS-PSG/r-environment-for-researcher.git
cd r-environment-for-researcher
./setup.sh
```

## 含まれるパッケージ

- **tidyverse**: データ操作と可視化のためのパッケージ群
- **ggplot2**: 高度なデータ可視化
- **dplyr**: データ操作
- **gtsummary**: 統計表の作成
- **WeightIt**: 傾向スコア解析と逆確率重み付け (IPTWの代替)

## 統計原則

`principles/compiled_principles.md`ファイルには、臨床疫学研究における統計の原則がまとめられています。これらの原則は以下のソースから抽出されました：

- STROBE statement (`principles/strobe_principles.md`)
- BMJ統計ガイドライン (`principles/bmj_principles.md`)
- JAMA著者向け指示 (`principles/jama_principles.md`)

## 使用例

`scripts/updated_example.R`スクリプトは、インストールされたパッケージを使用した包括的な解析例を提供します：

```bash
Rscript scripts/updated_example.R
```

このスクリプトには以下の例が含まれています：

1. データ準備と記述統計（gtsummaryを使用）
2. データ可視化（ggplot2を使用）
3. 回帰分析（gtsummaryを使用）
4. 傾向スコア解析（WeightItを使用）
5. 縦断データ解析（tidyverseとgtsummaryを使用）

## トラブルシューティング

一般的な問題と解決策については、`docs/troubleshooting.md`ファイルを参照してください。

## ライセンス

MIT
