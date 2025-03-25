# R環境のアップデート完了報告

## アップデート内容

### R本体
- 旧バージョン: R 4.1.2
- 新バージョン: R 4.4.3 (2025-02-28) "Trophy Case"
- アップデート方法: システムパッケージマネージャー経由

### インストール済みパッケージ
以下のパッケージが正常にインストールされ、使用可能になりました：

| パッケージ名 | バージョン | 説明 |
|------------|----------|------|
| tidyverse  | 2.0.0    | データ操作と可視化のためのパッケージ群 |
| ggplot2    | 3.5.1    | 高度なデータ可視化 |
| dplyr      | 1.1.4    | データ操作 |
| gtsummary  | 2.1.0    | 統計表の作成（R 4.2以上が必要） |
| WeightIt   | 1.4.0    | 傾向スコア解析とIPTW（iptwの代替） |

### 注意点
- `iptw`という名前の単独パッケージはCRANに存在しないため、同等の機能を持つ`WeightIt`パッケージをインストールしました
- `WeightIt`は`iptw`よりも柔軟で包括的な逆確率重み付け機能を提供します

## 作成・更新したファイル

### 解析スクリプト
- `~/statistical_principles/updated_example.R` - すべてのパッケージを使用した包括的な解析例

### ドキュメント
- `~/statistical_principles/r_update_summary.md` - このアップデート報告書
- `~/statistical_principles/troubleshooting.md` - トラブルシューティングガイド

## 使用方法

### 例示スクリプトの実行
```bash
Rscript ~/statistical_principles/updated_example.R
```

### スクリプトの内容
- 記述統計（gtsummaryを使用）
- データ可視化（ggplot2を使用）
- 回帰分析（gtsummaryを使用）
- 傾向スコア解析（WeightItを使用）
- 縦断データ解析（tidyverseとgtsummaryを使用）

## まとめ
Rのバージョンを4.4.3にアップデートし、要求されたすべてのパッケージ（tidyverse、ggplot2、dplyr、gtsummary、WeightIt）のインストールに成功しました。これにより、臨床疫学研究のための統計解析環境が整いました。
