# Methodology Notes: Self-rated health status and illiteracy as death predictors

## Study Overview
- **Title**: Self-rated health status and illiteracy as death predictors in a Brazilian cohort
- **Journal**: PLOS ONE (July 12, 2018)
- **Authors**: Sayuri Inuzuka, Paulo Cesar Veiga Jardim, et al.
- **Study Design**: Prospective cohort study
- **Follow-up Period**: 13 years (2002-2015)
- **Sample Size**: 1,069 participants from Firminópolis, Brazil

## Key Variables

### Outcome Variables
- **All-cause mortality**: Binary (0=Alive, 1=Dead)
- **Cardiovascular mortality**: Binary (0=Alive/Non-CV death, 1=CV death)
- **Non-cardiovascular mortality**: Binary (0=Alive/CV death, 1=Non-CV death)

### Primary Predictors
- **Self-rated health status**: 5-point scale (1=Excellent to 5=Poor)
  - Dichotomized as Good/Excellent (1-2) vs. Poor/Regular (3-5)
- **Literacy status**: Binary (1=Literate, 2=Illiterate)

### Adjustment Variables
- **Demographic factors**:
  - Age (continuous)
  - Sex (1=Male, 2=Female)
- **Cardiovascular risk factors**:
  - Hypertension (1=Yes, 2=No)
  - Smoking (1=Yes, 2=No, 3=Former)
  - Sedentary lifestyle (based on leisure physical activity)
  - Other factors in the dataset: obesity, previous cardiovascular events

## Statistical Methods

### Cox Proportional Hazard Models
- Used to assess the association between predictors and mortality outcomes
- Separate models for all-cause, cardiovascular, and non-cardiovascular mortality
- Hazard ratios (HR) with 95% confidence intervals reported

### Model Building Strategy
1. **Unadjusted models**: Individual associations of self-rated health and illiteracy with mortality
2. **Adjusted models**: Controlling for age, sex, and cardiovascular risk factors
3. **Fully adjusted models**: Including both primary predictors and all adjustment variables

### Survival Analysis
- Kaplan-Meier curves to visualize survival differences by self-rated health and literacy status
- Log-rank tests to assess statistical significance of survival differences

## Reproduction Strategy

To reproduce the analysis from the article, we will:

1. **Data Preparation**:
   - Clean and prepare variables as described in the article
   - Create binary variables for outcomes and predictors
   - Handle missing data appropriately

2. **Descriptive Statistics**:
   - Generate baseline characteristics table by mortality status
   - Compare with Table 1 in the original article

3. **Survival Analysis**:
   - Create Kaplan-Meier curves for self-rated health and literacy status
   - Perform log-rank tests to assess group differences

4. **Cox Proportional Hazard Models**:
   - Implement unadjusted models for each predictor and outcome
   - Implement adjusted models with demographic factors
   - Implement fully adjusted models with all covariates
   - Calculate hazard ratios and 95% confidence intervals

5. **Results Validation**:
   - Compare our results with Tables 2-4 in the original article
   - Assess consistency of findings and potential discrepancies

## R Packages Required
- `survival`: For Cox proportional hazard models and Kaplan-Meier curves
- `survminer`: For visualizing survival curves
- `tidyverse`: For data manipulation and visualization
- `gtsummary`: For creating publication-ready tables
- `readxl`: For importing Excel data
