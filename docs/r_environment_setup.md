# R環境セットアップガイド

このドキュメントでは、臨床疫学研究のための統計解析環境のセットアップ方法について説明します。

## インストール済みパッケージ

以下のパッケージをインストールしています：

1. **tidyverse** - データ操作と可視化のためのパッケージ群
   - dplyr: データ操作
   - ggplot2: データ可視化
   - tidyr: データ整形
   - readr: データ読み込み
   - purrr: 関数型プログラミング
   - tibble: 現代的なデータフレーム
   - stringr: 文字列操作
   - forcats: 因子型データ操作

2. **gtsummary** - 統計的要約表の作成
   - 記述統計量の表作成
   - 回帰モデルの結果表示
   - 層別解析の表示

3. **WeightIt** - 傾向スコア解析と逆確率重み付け
   - 因果推論のための重み付け手法
   - 交絡調整のための方法
   - IPTWの実装（Inverse Probability of Treatment Weighting）

## 使用例

`example_analysis.R`ファイルには、これらのパッケージを使用した解析例が含まれています：

1. データ準備と記述統計
2. データ可視化（ggplot2）
3. 回帰分析
4. 傾向スコア解析
5. 生存時間解析
6. 縦断データ解析

## パッケージの検証

`verify_packages.R`スクリプトを実行して、すべてのパッケージが正しくインストールされているか確認できます：

```r
Rscript scripts/verify_packages.R
```

## 統計解析の原則

統計解析を行う際は、`compiled_principles.md`ファイルに記載されている臨床疫学研究における統計の原則に従うことをお勧めします。これらの原則は、BMJ、JAMA、およびSTROBE statementから抽出されたものです。

## 追加リソース

1. [R for Data Science](https://r4ds.had.co.nz/) - tidyverseの包括的なガイド
2. [ggplot2: Elegant Graphics for Data Analysis](https://ggplot2-book.org/) - ggplot2の詳細ガイド
3. [gtsummary vignettes](http://www.danieldsjoberg.com/gtsummary/articles/) - gtsummaryの使用例
4. [WeightIt documentation](https://ngreifer.github.io/WeightIt/) - 傾向スコア解析のガイド

## トラブルシューティング

パッケージのインストールに問題がある場合：

```r
# 依存関係の確認
packageVersion("依存パッケージ名")

# パッケージの再インストール
install.packages("パッケージ名", dependencies = TRUE)

# 特定のリポジトリからのインストール
install.packages("パッケージ名", repos = "https://cran.rstudio.com/")
```

## 注意事項

- R 4.1.2以上を使用することをお勧めします
- 大規模なデータセットを扱う場合はメモリ使用量に注意してください
- 解析結果の再現性を確保するために、set.seed()を使用してください
