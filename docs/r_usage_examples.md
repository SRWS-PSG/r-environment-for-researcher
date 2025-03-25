# R統計解析の実践例

このドキュメントでは、臨床疫学研究で一般的に使用される統計解析手法の実践例を紹介します。

## 1. 記述統計（Descriptive Statistics）

```r
library(tidyverse)
library(gtsummary)

# データの要約
my_data %>%
  tbl_summary(
    by = treatment_group,
    include = c(age, sex, bmi, comorbidity),
    statistic = list(
      all_continuous() ~ "{mean} ({sd})",
      all_categorical() ~ "{n} ({p}%)"
    )
  ) %>%
  add_p() %>%
  add_overall()
```

## 2. 生存時間解析（Survival Analysis）

```r
library(survival)
library(survminer)

# Kaplan-Meier曲線
km_fit <- survfit(Surv(time, event) ~ group, data = my_data)
ggsurvplot(
  km_fit,
  data = my_data,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = TRUE,
  xlab = "時間（月）",
  ylab = "生存率",
  legend.title = "治療群",
  palette = "jco"
)

# Cox比例ハザードモデル
cox_model <- coxph(Surv(time, event) ~ treatment + age + sex + stage, data = my_data)
tbl_regression(cox_model, exponentiate = TRUE)
```

## 3. 傾向スコア解析（Propensity Score Analysis）

```r
library(WeightIt)
library(cobalt)

# 傾向スコアの推定と重み付け
w_out <- weightit(treatment ~ age + sex + bmi + comorbidity + smoking,
                 data = my_data,
                 method = "ps",
                 estimand = "ATT")

# バランスの評価
bal.tab(w_out)
love.plot(w_out, threshold = 0.1)

# 重み付き解析
weighted_model <- glm(outcome ~ treatment,
                     family = binomial(link = "logit"),
                     data = my_data,
                     weights = w_out$weights)
tbl_regression(weighted_model, exponentiate = TRUE)
```

## 4. 縦断データ解析（Longitudinal Data Analysis）

```r
library(lme4)
library(lmerTest)

# 線形混合効果モデル
mixed_model <- lmer(outcome ~ time * treatment + age + sex + (1 | subject_id),
                   data = longitudinal_data)
summary(mixed_model)

# 結果の可視化
longitudinal_data %>%
  ggplot(aes(x = time, y = outcome, color = treatment)) +
  stat_summary(fun = mean, geom = "point", size = 3) +
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.2) +
  labs(title = "時間経過による結果の変化",
       x = "時間（週）",
       y = "結果測定値",
       color = "治療群") +
  theme_minimal()
```

## 5. 多重代入法（Multiple Imputation）

```r
library(mice)

# 欠損値の可視化
md.pattern(my_data)

# 多重代入
imp <- mice(my_data, m = 5, method = "pmm", seed = 123)
completed_data <- complete(imp, action = "long")

# 代入後の解析
imp_models <- with(imp, glm(outcome ~ treatment + age + sex + comorbidity,
                          family = binomial(link = "logit")))
pooled_results <- pool(imp_models)
summary(pooled_results, conf.int = TRUE, exponentiate = TRUE)
```

## 6. マッチング（Matching）

```r
library(MatchIt)

# 傾向スコアマッチング
m_out <- matchit(treatment ~ age + sex + bmi + comorbidity,
                data = my_data,
                method = "nearest",
                ratio = 1)

# マッチング後のデータ
matched_data <- match.data(m_out)

# バランスの評価
summary(m_out)

# マッチング後の解析
matched_model <- glm(outcome ~ treatment,
                    family = binomial(link = "logit"),
                    data = matched_data)
tbl_regression(matched_model, exponentiate = TRUE)
```

## 7. メタ解析（Meta-Analysis）

```r
library(meta)

# メタ解析の実行
meta_result <- metabin(event.e = events_treatment,
                      n.e = total_treatment,
                      event.c = events_control,
                      n.c = total_control,
                      studlab = study,
                      data = meta_data,
                      sm = "RR",
                      method = "MH",
                      random = TRUE)

# 結果の表示
summary(meta_result)
forest(meta_result)
funnel(meta_result)
```

## 8. 交互作用の検討（Interaction Analysis）

```r
# 交互作用項を含むモデル
interaction_model <- glm(outcome ~ treatment * subgroup + age + sex,
                        family = binomial(link = "logit"),
                        data = my_data)
tbl_regression(interaction_model, exponentiate = TRUE)

# 層別解析
my_data %>%
  group_by(subgroup) %>%
  group_map(~ tbl_regression(
    glm(outcome ~ treatment + age + sex,
        family = binomial(link = "logit"),
        data = .x),
    exponentiate = TRUE
  ))
```

## 9. 非線形関係の検討（Non-linear Relationships）

```r
library(mgcv)

# 一般化加法モデル
gam_model <- gam(outcome ~ s(age) + sex + treatment,
                family = binomial(link = "logit"),
                data = my_data)
summary(gam_model)

# 非線形関係の可視化
plot(gam_model, select = 1, shade = TRUE, ylab = "f(age)")
```

## 10. 感度分析（Sensitivity Analysis）

```r
# 主解析
main_model <- glm(outcome ~ treatment + age + sex + comorbidity,
                 family = binomial(link = "logit"),
                 data = my_data)

# 追加の共変量を含むモデル
sensitivity_model1 <- glm(outcome ~ treatment + age + sex + comorbidity + additional_var,
                         family = binomial(link = "logit"),
                         data = my_data)

# 異なる解析対象集団
sensitivity_model2 <- glm(outcome ~ treatment + age + sex + comorbidity,
                         family = binomial(link = "logit"),
                         data = subset(my_data, criteria == TRUE))

# 結果の比較
models_list <- list(
  "主解析" = main_model,
  "追加共変量" = sensitivity_model1,
  "サブグループ" = sensitivity_model2
)

tbl_merge(
  lapply(models_list, function(x) tbl_regression(x, exponentiate = TRUE)),
  tab_spanner = names(models_list)
)
```

これらの例は、実際のデータセットに合わせて調整する必要があります。各分析手法の詳細については、それぞれのパッケージのドキュメントを参照してください。
