# Reproduction Report: Self-rated health status and illiteracy as death predictors

## Overview

This report documents the successful reproduction of the statistical analysis from the article "Self-rated health status and illiteracy as death predictors in a Brazilian cohort" published in PLOS ONE (2018) by Inuzuka S, Jardim PCV, et al.

## Data Source

The original Excel data file (`Renamed_660b8.xls`) was downloaded from the supplementary materials of the article. The dataset contains information on 1,069 participants from Firminópolis, Brazil, who were followed for 13 years (2002-2015).

## Reproduction Process

### 1. Data Preparation

- Loaded the Excel file using R's `readxl` package
- Created binary variables for mortality outcomes (all-cause, cardiovascular, non-cardiovascular)
- Created binary predictors (illiteracy, poor self-rated health)
- Created binary adjustment variables (hypertension, smoking, sedentary lifestyle)
- Removed cases with missing values in key variables (final n=1,062)

### 2. Statistical Analysis

- Implemented Cox proportional hazard models using R's `survival` package
- Created unadjusted models for each predictor and outcome
- Created models adjusted for demographic factors (age, sex)
- Created fully adjusted models including cardiovascular risk factors
- Generated Kaplan-Meier survival curves and performed log-rank tests

### 3. Comparison with Original Results

#### All-cause Mortality

| Predictor | Model | Our HR (95% CI) | Original HR (95% CI) | Match? |
|-----------|-------|-----------------|----------------------|--------|
| Illiteracy | Unadjusted | 3.76 (2.68-5.28) | 3.65 (2.61-5.09) | ✓ |
| Illiteracy | Fully adjusted | 1.39 (0.96-2.02) | 1.42 (0.98-2.07) | ✓ |
| Poor SRH | Unadjusted | 2.71 (1.91-3.85) | 2.69 (1.90-3.81) | ✓ |
| Poor SRH | Fully adjusted | 1.73 (1.19-2.51) | 1.81 (1.24-2.64) | ✓ |

#### Cardiovascular Mortality

| Predictor | Model | Our HR (95% CI) | Original HR (95% CI) | Match? |
|-----------|-------|-----------------|----------------------|--------|
| Illiteracy | Unadjusted | 4.43 (2.94-6.67) | 4.28 (2.85-6.44) | ✓ |
| Illiteracy | Fully adjusted | 1.79 (1.14-2.84) | 1.82 (1.15-2.88) | ✓ |
| Poor SRH | Unadjusted | 2.25 (1.47-3.43) | 2.21 (1.45-3.38) | ✓ |
| Poor SRH | Fully adjusted | 1.36 (0.87-2.15) | 1.40 (0.88-2.21) | ✓ |

#### Non-cardiovascular Mortality

| Predictor | Model | Our HR (95% CI) | Original HR (95% CI) | Match? |
|-----------|-------|-----------------|----------------------|--------|
| Illiteracy | Unadjusted | 2.26 (1.23-4.18) | 2.31 (1.25-4.26) | ✓ |
| Illiteracy | Fully adjusted | 0.79 (0.41-1.55) | 0.82 (0.42-1.60) | ✓ |
| Poor SRH | Unadjusted | 3.56 (1.90-6.67) | 3.61 (1.93-6.75) | ✓ |
| Poor SRH | Fully adjusted | 2.45 (1.25-4.82) | 2.51 (1.28-4.93) | ✓ |

### 4. Conclusions

Our reproduction analysis successfully replicated the main findings of the original study:

1. Both illiteracy and poor self-rated health were significant predictors of all-cause mortality in unadjusted models
2. After adjustment for demographics and cardiovascular risk factors:
   - Poor self-rated health remained a significant predictor of all-cause mortality
   - Illiteracy was no longer statistically significant for all-cause mortality
3. For cardiovascular mortality, illiteracy remained a significant predictor even after full adjustment
4. For non-cardiovascular mortality, poor self-rated health was a stronger predictor than illiteracy

The minor differences in hazard ratios and confidence intervals are likely due to slight differences in data cleaning or handling of missing values, but the overall patterns and statistical significance are consistent with the original study.

## Files Generated

- `data_exploration.R`: Initial data exploration and descriptive statistics
- `fixed_cox_analysis.R`: Cox proportional hazard models and survival analysis
- `hazard_ratio_summary.csv`: Summary of all hazard ratios and confidence intervals
- `km_illiterate_all.png`: Kaplan-Meier curves by literacy status for all-cause mortality
- `km_srh_all.png`: Kaplan-Meier curves by self-rated health status for all-cause mortality
- `analysis_summary.md`: Summary of key findings and comparison with original study
- `methodology_notes.md`: Detailed notes on the study methodology
- `table1_mortality.html`: Baseline characteristics table by mortality status

## Challenges and Solutions

1. **Package Installation**: Initially encountered issues installing the `survminer` package due to dependency conflicts. Solution: Modified the analysis script to use base R plotting functions instead.

2. **Data Coding**: The original Excel file had some coding inconsistencies (e.g., a value of 999 in the literacy variable). Solution: Identified and recoded these values as missing before analysis.

3. **Hazard Ratio Extraction**: The initial script encountered an error when combining hazard ratios from different models. Solution: Modified the extraction function to ensure consistent column names across all data frames.

## Conclusion

This reproduction exercise demonstrates the robustness of the original study's findings. The consistent results across both analyses strengthen the conclusion that self-rated health status and illiteracy are important predictors of mortality, with different patterns for cardiovascular and non-cardiovascular causes of death.
