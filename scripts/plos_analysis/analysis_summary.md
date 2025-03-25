# Reproduction Analysis of "Self-rated health status and illiteracy as death predictors"

## Study Overview
- **Original Article**: Self-rated health status and illiteracy as death predictors in a Brazilian cohort (PLOS ONE, 2018)
- **Authors**: Inuzuka S, Jardim PCV, et al.
- **Sample Size**: 1,062 complete cases (from original 1,069)
- **Follow-up Period**: 13 years (2002-2015)

## Key Findings

### All-cause Mortality
- **Illiteracy**:
  - Unadjusted HR:  3.76 (2.68-5.28) 
  - Fully adjusted HR:  1.39 (0.96-2.02) 

- **Poor Self-rated Health**:
  - Unadjusted HR:  2.71 (1.91-3.85) 
  - Fully adjusted HR:  1.73 (1.19-2.51) 

### Cardiovascular Mortality
- **Illiteracy**:
  - Unadjusted HR:  4.43 (2.94-6.67) 
  - Fully adjusted HR:  1.79 (1.14-2.84) 

- **Poor Self-rated Health**:
  - Unadjusted HR:  2.25 (1.47-3.43) 
  - Fully adjusted HR:  1.36 (0.87-2.15) 

### Non-cardiovascular Mortality
- **Illiteracy**:
  - Unadjusted HR:  2.26 (1.23-4.18) 
  - Fully adjusted HR:  0.79 (0.41-1.55) 

- **Poor Self-rated Health**:
  - Unadjusted HR:  3.56 (1.90-6.67) 
  - Fully adjusted HR:  2.45 (1.25-4.82) 

## Comparison with Original Study

Our reproduction analysis successfully replicated the main findings of the original study:

1. Both illiteracy and poor self-rated health were significant predictors of all-cause mortality in unadjusted models
2. After adjustment for demographics and cardiovascular risk factors:
   - Poor self-rated health remained a significant predictor of all-cause mortality
   - Illiteracy was no longer statistically significant for all-cause mortality
3. For cardiovascular mortality, illiteracy remained a significant predictor even after full adjustment
4. For non-cardiovascular mortality, poor self-rated health was a stronger predictor than illiteracy

## Methodology Notes

- Cox proportional hazard models were used to assess the association between predictors and mortality
- Models were adjusted for age, sex, hypertension, smoking status, and sedentary lifestyle
- Kaplan-Meier curves and log-rank tests were used to visualize and test survival differences
- All analyses were performed using R with the survival package

## Files Generated

- `hazard_ratio_summary.csv`: Summary of all hazard ratios and confidence intervals
- `km_illiterate_all.png`: Kaplan-Meier curves by literacy status for all-cause mortality
- `km_srh_all.png`: Kaplan-Meier curves by self-rated health status for all-cause mortality
