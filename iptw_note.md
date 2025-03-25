# 注意: WeightItパッケージについて

ユーザーの要求に基づき、`iptw`パッケージの代わりに`WeightIt`パッケージをインストールしています。これは以下の理由によるものです：

1. `iptw`という名前の単独のRパッケージは現在CRANリポジトリに存在しません
2. 逆確率重み付け（Inverse Probability of Treatment Weighting）の機能は、`WeightIt`パッケージに含まれています
3. `WeightIt`パッケージは、傾向スコア推定と逆確率重み付けのための現代的で包括的なパッケージです
4. `WeightIt`は活発に維持されており、最新の方法論をサポートしています

## WeightItパッケージの主な機能

- 傾向スコアの推定
- 逆確率重み付け（IPTW）の計算
- バランス評価のためのツール
- 様々な推定方法のサポート（ロジスティック回帰、CBPS、GBM、SuperLearnerなど）
- 二値、多値、連続的な処置変数のサポート

## 使用例

```r
library(WeightIt)

# 傾向スコアの推定と重み付け
w_out <- weightit(treatment ~ age + sex + bmi + comorbidity,
                 data = my_data,
                 method = "ps",
                 estimand = "ATT")

# バランスの評価
summary(w_out)

# 重み付き解析
weighted_model <- glm(outcome ~ treatment,
                     family = binomial(link = "logit"),
                     data = my_data,
                     weights = w_out$weights)
```

詳細については、[WeightItのドキュメント](https://ngreifer.github.io/WeightIt/)を参照してください。
