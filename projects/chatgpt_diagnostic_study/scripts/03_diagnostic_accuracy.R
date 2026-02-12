# ============================================================================
# ChatGPT Diagnostic Accuracy Study - Diagnostic Accuracy Metrics
# ============================================================================
# Paper: Evaluation of ChatGPT as a diagnostic tool for medical learners
#        and clinicians (PLOS ONE, DOI: 10.1371/journal.pone.0307383)
# ============================================================================

# Source setup
source(here::here("projects", "chatgpt_diagnostic_study", "scripts", "00_setup.R"))

# Load diagnostic accuracy data
diagnostic_data <- read_csv(
  file.path(data_processed, "diagnostic_accuracy_600.csv"),
  show_col_types = FALSE
)

cat("=== Diagnostic Accuracy Analysis ===\n")
cat("Total responses loaded:", nrow(diagnostic_data), "(expected: 600)\n\n")

# ============================================================================
# 1. Count TP/FP/TN/FN
# ============================================================================

confusion_counts <- diagnostic_data |>
  count(diagnostic_result) |>
  mutate(pct = n / sum(n) * 100)

cat("=== Confusion Matrix Counts ===\n")
print(confusion_counts)

TP <- confusion_counts$n[confusion_counts$diagnostic_result == "True Positive"]
FP <- confusion_counts$n[confusion_counts$diagnostic_result == "False Positive"]
TN <- confusion_counts$n[confusion_counts$diagnostic_result == "True Negative"]
FN <- confusion_counts$n[confusion_counts$diagnostic_result == "False Negative"]

total_responses <- TP + FP + TN + FN

# ============================================================================
# 2. Calculate Diagnostic Accuracy Metrics
# ============================================================================

metrics <- tibble(
  Metric = c("Accuracy", "Precision", "Sensitivity", "Specificity"),
  Formula = c(
    "(TP + TN) / Total",
    "TP / (TP + FP)",
    "TP / (TP + FN)",
    "TN / (TN + FP)"
  ),
  Value = c(
    (TP + TN) / total_responses,
    TP / (TP + FP),
    TP / (TP + FN),
    TN / (TN + FP)
  ),
  Percentage = c(
    (TP + TN) / total_responses * 100,
    TP / (TP + FP) * 100,
    TP / (TP + FN) * 100,
    TN / (TN + FP) * 100
  ),
  Paper_Value = c(74.00, 48.67, 48.67, 82.89)
)

cat("\n=== Diagnostic Accuracy Metrics ===\n")
cat(sprintf("Total responses: %d (expected: 600)\n\n", total_responses))
print(metrics)

# ============================================================================
# 3. Figure 2: Confusion Matrix Heatmap
# ============================================================================

confusion_matrix_data <- tibble(
  Predicted = factor(c("Positive", "Positive", "Negative", "Negative"),
                     levels = c("Positive", "Negative")),
  Actual = factor(c("Positive", "Negative", "Positive", "Negative"),
                  levels = c("Positive", "Negative")),
  Count = c(TP, FP, FN, TN),
  Label = c(
    sprintf("TP\n%d (%.0f%%)", TP, TP/total_responses*100),
    sprintf("FP\n%d (%.0f%%)", FP, FP/total_responses*100),
    sprintf("FN\n%d (%.0f%%)", FN, FN/total_responses*100),
    sprintf("TN\n%d (%.0f%%)", TN, TN/total_responses*100)
  )
)

fig2 <- ggplot(confusion_matrix_data, 
               aes(x = Predicted, y = Actual, fill = Count)) +
  geom_tile(color = "white", linewidth = 2) +
  geom_text(aes(label = Label), size = 5, fontface = "bold") +
  scale_fill_gradient(low = "#E3F2FD", high = "#1565C0") +
  scale_x_discrete(position = "top") +
  labs(
    title = "Confusion Matrix: ChatGPT Diagnostic Accuracy",
    subtitle = sprintf("Total responses: %d | Accuracy: %.1f%%", 
                       total_responses, (TP + TN) / total_responses * 100),
    x = "Predicted",
    y = "Actual"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    legend.position = "none",
    panel.grid = element_blank()
  )

# Save Figure 2
ggsave(
  filename = file.path(output_figures, "fig2_confusion_matrix.png"),
  plot = fig2,
  width = 6,
  height = 5,
  dpi = 300
)

ggsave(
  filename = file.path(output_figures, "fig2_confusion_matrix.pdf"),
  plot = fig2,
  width = 6,
  height = 5
)

cat("\n=== Figure 2 saved ===\n")

# ============================================================================
# 4. ROC Curve and AUC (Figure 3)
# ============================================================================

TPR <- TP / (TP + FN)
FPR <- FP / (FP + TN)

roc_data <- tibble(
  FPR = c(0, FPR, 1),
  TPR = c(0, TPR, 1)
)

# Calculate AUC using trapezoidal rule
auc_simple <- 0.5 * (1 + TPR - FPR)

cat("\n=== ROC Analysis ===\n")
cat(sprintf("True Positive Rate (Sensitivity): %.3f\n", TPR))
cat(sprintf("False Positive Rate: %.3f\n", FPR))
cat(sprintf("Estimated AUC: %.2f\n", auc_simple))
cat("Paper reported AUC: 0.66\n")

# Create ROC curve plot
fig3 <- ggplot() +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "gray50") +
  geom_line(data = roc_data, aes(x = FPR, y = TPR), 
            color = "#1976D2", linewidth = 1.5) +
  geom_point(aes(x = FPR, y = TPR), color = "#D32F2F", size = 4) +
  annotate("text", x = 0.75, y = 0.25, 
           label = sprintf("AUC = %.2f", auc_simple),
           size = 5, fontface = "bold") +
  scale_x_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.2)) +
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, 0.2)) +
  labs(
    title = "ROC Curve: ChatGPT Diagnostic Performance",
    x = "False Positive Rate (1 - Specificity)",
    y = "True Positive Rate (Sensitivity)"
  ) +
  coord_equal() +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    panel.grid.minor = element_blank()
  )

# Save Figure 3
ggsave(
  filename = file.path(output_figures, "fig3_roc_curve.png"),
  plot = fig3,
  width = 6,
  height = 6,
  dpi = 300
)

ggsave(
  filename = file.path(output_figures, "fig3_roc_curve.pdf"),
  plot = fig3,
  width = 6,
  height = 6
)

cat("\n=== Figure 3 saved ===\n")

# ============================================================================
# 5. Save metrics summary
# ============================================================================

metrics_summary <- tibble(
  Metric = c("True Positive (TP)", "False Positive (FP)", 
             "True Negative (TN)", "False Negative (FN)",
             "Total Responses", "Accuracy (%)", "Precision (%)",
             "Sensitivity (%)", "Specificity (%)", "AUC"),
  Our_Value = c(TP, FP, TN, FN, total_responses,
                round((TP + TN) / total_responses * 100, 2),
                round(TP / (TP + FP) * 100, 2),
                round(TP / (TP + FN) * 100, 2),
                round(TN / (TN + FP) * 100, 2),
                round(auc_simple, 2)),
  Paper_Value = c(73, 77, 373, 77, 600, 74.00, 48.67, 48.67, 82.89, 0.66)
)

write_csv(metrics_summary, file.path(output_tables, "diagnostic_accuracy_metrics.csv"))

cat("\n=== Metrics summary saved ===\n")
print(metrics_summary)
