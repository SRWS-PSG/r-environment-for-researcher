# Statistical Principles from BMJ Article "On the 12th Day of Christmas, a Statistician Sent to Me..."

## 1. Clarify Research Question and Objectives
- Clearly define whether research is descriptive, causal, prognostic factor identification, prediction model development, exploratory, or confirmatory
- For causal research, express the underlying premise (causal pathway or model)
- For systematic reviews, use the PICO structure (Population, Intervention, Comparison, Outcome)
- Clearly define the estimand (study's target measure for estimation)

## 2. Focus on Estimates, Confidence Intervals, and Clinical Relevance
- Consider estimates (e.g., mean differences, risk ratios) and their corresponding confidence intervals
- Avoid focusing solely on P values and "statistical significance"
- Statistical significance does not equate to clinical significance
- Consider clinical relevance of findings, even when statistical significance is not achieved
- Consider using Bayesian approaches when appropriate

## 3. Carefully Account for Missing Data
- Acknowledge completeness of data and report the amount of missing data
- Explain how missing data were handled in analyses
- Complete case analysis (excluding participants with missing data) is rarely recommended
- Use appropriate imputation methods based on context
- For observational studies, multiple imputation is often preferred over mean imputation
- Describe methods used for multiple imputation, including variables used in the imputation process

## 4. Do Not Dichotomize Continuous Variables
- Avoid splitting continuous variables (like age, blood pressure) into two groups
- Dichotomization wastes information and reduces statistical power
- Dichotomization reduces predictive performance of prognostic models
- Dichotomization leads to data dredging and selection of "optimal" cut points
- Dichotomization hinders meta-analysis due to different studies adopting different cut points
- Analyze continuous variables on their continuous scale

## 5. Consider Non-linear Relationships
- Do not assume linear relationships between continuous covariates and outcomes
- Non-linear associations allow the impact of a unit increase to vary across the spectrum of predictor values
- Use appropriate methods for non-linear modeling (cubic splines, fractional polynomials)
- Examine and report non-linear relationships when they exist

## 6. Quantify Differences in Subgroup Results
- When examining subgroups, quantify the difference between subgroups
- Do not conclude subgroup effects based solely on whether confidence intervals overlap
- Test for interactions between treatment effects and covariates
- Consider the scale used to measure effects (risk ratio, odds ratio)
- Allow for potentially non-linear relationships when examining subgroups

## 7. Consider Accounting for Clustering
- Account for clustering in data from multiple clusters (hospitals, practices, studies)
- Ignoring clustering can lead to biased results or misleading confidence intervals
- Use appropriate methods like multilevel or mixed effects models
- Consider cluster-specific baseline risks and between-cluster heterogeneity

## 8. Interpret I² and Meta-regression Appropriately
- I² describes the percentage of variability in effect estimates due to between-study heterogeneity
- I² is a relative measure and depends on the size of within-study variances
- Present the estimate of between-study variance directly
- Use caution when interpreting meta-regression results:
  - Number of trials is often small
  - Confounding across trials is likely
  - Aggregation bias may occur when using trial-level covariates

## 9. Assess Calibration of Model Predictions
- For prediction models, evaluate both discrimination and calibration
- Do not focus only on discrimination (C statistic or area under the curve)
- Use calibration plots to assess agreement between observed and predicted risks
- Consider clinical utility of the model, especially around decision thresholds
- Consider using penalization or shrinkage methods to improve calibration

## 10. Carefully Consider the Variable Selection Approach
- Avoid selecting covariates based solely on statistical significance of their effects
- Consider using background knowledge and previous evidence
- For prediction modeling, consider all plausible predictors regardless of significance
- Use appropriate methods for high-dimensional data (LASSO, elastic net)
- Consider the risk of overfitting, especially with small datasets

## 11. Avoid One-Size-Fits-All Sample Size Calculations
- Do not use arbitrary thresholds for sample size (e.g., 10 events per variable)
- Consider the specific research question and analysis plan
- For prediction models, consider the anticipated model performance
- For treatment effect estimation, consider the expected effect size and its precision
- Use simulation-based approaches for complex designs

## 12. Prespecify the Analysis Plan
- Prespecify primary and secondary outcomes
- Prespecify the statistical analysis plan before data collection
- Avoid data-driven analysis choices
- Report all prespecified analyses, even if results are not as expected
- Clearly distinguish between prespecified and post-hoc analyses
