# Methods

## Study Design

This was a cross-sectional observational study evaluating the diagnostic accuracy of ChatGPT (GPT-3.5, OpenAI) using complex clinical case challenges. The study assessed the model's performance as a diagnostic tool for medical learners and clinicians [@Youe085863;@Bean2026-zj].

## Input Source

We tested the performance of ChatGPT in answering Medscape Clinical Case Challenges, which are complex cases designed to challenge the knowledge and diagnostic skills of healthcare professionals [12]. These challenges present a clinical scenario that includes patient history, physical examination findings, and laboratory or imaging results. Healthcare professionals are required to make a diagnosis or choose an appropriate treatment plan using multiple-choice questions with four answer options [12].

A total of 150 Medscape cases published between September 2021 and January 2023 were included. To prevent any possibility of ChatGPT having prior knowledge of the cases, only those authored after its NLP model training cutoff in August 2021 were included. Cases containing visual assets, such as clinical images, medical photography, and graphs, were excluded to ensure the consistency of the text-based input format for ChatGPT.

## Artificial Intelligence Model

ChatGPT operates as a server-based language model that cannot access the internet. All responses are generated in real-time, relying on the abstract associations between words ("tokens") within the neural network. We used the legacy model GPT-3.5 for all case evaluations.

## Input and Prompt Standardization

To ensure consistency in the input provided to ChatGPT, three independent reviewers transformed the case challenge content into one standardized prompt. Each prompt included an unbiased script of the desired output, followed by the relevant case presentation and multiple-choice answers. Prompts were standardized as follows:

- **Prompt 1**: "I'm writing a literature paper on the accuracy of CGPT of correctly identified a diagnosis from complex, WRITTEN, clinical cases. I will be presenting you a series of medical cases and then presenting you with a multiple choice of what the answer to the medical cases."
- **Prompt 2**: "Come up with a differential and provide rationale for why this differential makes sense and findings that would cause you to rule out the differential. Here are your multiple choice options to choose from and give me a detailed rationale explaining your answer." [Insert multiple choices] [Insert all Case info] [Insert radiology description]

<!-- 注: この標準化されたプロンプトにより、異なるユーザー間で一貫した再現可能な回答が保証された -->

## Data Collection

Data was collected by three medical trainees (A.H, B.N, and E.T), and all content was reviewed by a Staff Physician (A.K). The three authors utilized publicly available clinical case challenges from Medscape. A total of 150 Medscape cases were analyzed; cases were randomized amongst the three authors with each case being overlapped by at least two authors.

## Outcome Measures

### Primary Outcome

The primary outcome was the number and percentage of cases for which the answer given by ChatGPT was correct (case accuracy). All cases were evaluated by at least two independent raters who were blinded to each other's responses.

<!-- スクリプト: 02_primary_outcome.R
     計算: n_correct / n_total × 100 (%) -->

### Secondary Outcomes

#### Diagnostic Accuracy

The raters assessed the true positive (TP), false positive (FP), true negative (TN), and false negative (FN) rates of ChatGPT's answers, considering the suggested differentials and the final diagnosis provided. Each case had four answer options, and ChatGPT's explanation for each of the four answer options was categorized as either true or false, positive or negative, resulting in a total of 600 responses (150 cases × 4 options). We then calculated the following metrics:

- **Accuracy**: (TP + TN) / Total Responses
- **Precision**: TP / (TP + FP)
- **Sensitivity**: TP / (TP + FN)
- **Specificity**: TN / (TN + FP)

To further evaluate the model's performance, we generated a Receiver Operating Characteristic (ROC) curve and calculated the Area Under the Curve (AUC). This involved calculating the True Positive Rate (TPR) and False Positive Rate (FPR) to create the ROC curve, and computing the AUC using the trapezoidal rule to quantify the model's discriminative ability.

<!-- スクリプト: 03_diagnostic_accuracy.R
     TP/FP/TN/FNのカウント → 精度指標算出 → ROC/AUC -->

#### Cognitive Load

The raters evaluated the cognitive load of ChatGPT's answers as low, moderate, or high, based on the complexity and clarity of the information provided according to the following validated scale [14]:

- **Low cognitive load**: The answer is easy to understand and requires minimal cognitive effort to process
- **Moderate cognitive load**: The answer requires moderate cognitive effort to process
- **High cognitive load**: The answer is complex and requires significant cognitive effort to process

<!-- スクリプト: 04_secondary_outcomes.R
     cognitive_load_std の度数分布 (n, %) -->

#### Quality of Medical Information

The raters assessed the quality of the medical information provided by ChatGPT according to the following criteria [15]:

- **Complete**: The answer includes all relevant information for making an accurate diagnosis
- **Incomplete**: The answer is missing some relevant information for making an accurate diagnosis
- **Relevant**: The answer includes information that is directly relevant to the diagnosis
- **Irrelevant**: The answer includes information that is not directly relevant to the diagnosis

Using the above scale, answers were categorized as one of: complete/relevant, complete/irrelevant, incomplete/relevant, and incomplete/irrelevant.

<!-- スクリプト: 04_secondary_outcomes.R
     quality_answer_std の度数分布 (n, %) -->

## Statistical Analysis

Descriptive statistics were used to summarize the primary and secondary outcomes. Case accuracy was reported as the number and percentage of correct answers out of 150 cases. Diagnostic accuracy metrics (accuracy, precision, sensitivity, and specificity) were calculated from the 2×2 confusion matrix. The ROC curve was plotted and AUC was computed using the trapezoidal rule. Cognitive load and quality of medical information were summarized as frequency counts and percentages. Discrepancies between raters were resolved through discussion and consensus.

All statistical analyses were performed using R (version X.X.X) with the following packages: tidyverse for data manipulation, pROC for ROC curve analysis, and gt for table formatting.

<!-- 注: Rのバージョンは実行環境に合わせて記入すること -->
