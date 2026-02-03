# ============================================================================
# ChatGPT Diagnostic Accuracy Study - Primary Outcome Analysis
# ============================================================================
# Paper: Evaluation of ChatGPT as a diagnostic tool for medical learners
#        and clinicians (PLOS ONE, DOI: 10.1371/journal.pone.0307383)
# ============================================================================

# Source setup and run data import if needed
source(here::here("projects", "chatgpt_diagnostic_study", "scripts", "00_setup.R"))

# Load processed data
cases <- read_csv(
  file.path(data_processed, "chatgpt_cases_cleaned.csv"),
  show_col_types = FALSE
)

cat("=== Primary Outcome Analysis ===\n")
cat("Total cases loaded:", nrow(cases), "\n\n")

# ============================================================================
# 1. Primary Outcome: Case Accuracy (% correct answers)
# ============================================================================

primary_outcome <- cases |>
  filter(!is.na(answer_correct_bool)) |>
  summarise(
    n_total = n(),
    n_correct = sum(answer_correct_bool),
    n_incorrect = sum(!answer_correct_bool),
    pct_correct = n_correct / n_total * 100
  )

cat("=== PRIMARY OUTCOME ===\n")
cat(sprintf("Total cases: %d\n", primary_outcome$n_total))
cat(sprintf("Correct answers: %d (%.1f%%)\n", 
            primary_outcome$n_correct, primary_outcome$pct_correct))
cat(sprintf("Incorrect answers: %d (%.1f%%)\n", 
            primary_outcome$n_incorrect, 100 - primary_outcome$pct_correct))

cat("\n--- Paper Comparison ---\n")
cat("Paper reported: 74/150 (49.33%)\n")
cat(sprintf("Our result: %d/%d (%.2f%%)\n", 
            primary_outcome$n_correct, 
            primary_outcome$n_total,
            primary_outcome$pct_correct))

# ============================================================================
# 2. Figure 1: Percentage of Correct Answers Bar Chart
# ============================================================================

# Create data for Figure 1 style plot
fig1_data <- tibble(
  category = c("Correct Answer", "Incorrect Answer"),
  n = c(primary_outcome$n_correct, primary_outcome$n_incorrect),
  pct = c(primary_outcome$pct_correct, 100 - primary_outcome$pct_correct)
)

fig1 <- ggplot(fig1_data, aes(x = category, y = pct, fill = category)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = sprintf("%.1f%%\n(n=%d)", pct, n)), 
            vjust = -0.3, size = 4) +
  scale_fill_manual(values = c("Correct Answer" = "#4CAF50", 
                               "Incorrect Answer" = "#F44336")) +
  scale_y_continuous(limits = c(0, 100), 
                     breaks = seq(0, 100, 20),
                     expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "ChatGPT Performance on Medscape Clinical Case Challenges",
    subtitle = sprintf("N = %d cases", primary_outcome$n_total),
    x = NULL,
    y = "Percentage (%)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid.major.x = element_blank()
  )

# Save figure
ggsave(
  filename = file.path(output_figures, "fig1_percent_correct.png"),
  plot = fig1,
  width = 6,
  height = 5,
  dpi = 300
)

# Also save as PDF
ggsave(
  filename = file.path(output_figures, "fig1_percent_correct.pdf"),
  plot = fig1,
  width = 6,
  height = 5
)

cat("\n=== Figure 1 saved ===\n")
cat("PNG:", file.path(output_figures, "fig1_percent_correct.png"), "\n")
cat("PDF:", file.path(output_figures, "fig1_percent_correct.pdf"), "\n")

# ============================================================================
# 3. Summary Table (Table 1 style - case list)
# ============================================================================

table1 <- cases |>
  filter(!is.na(answer_correct_bool)) |>
  mutate(
    case_number = row_number(),
    answer_status = ifelse(answer_correct_bool, "yes", "no")
  ) |>
  select(
    Case = case_number,
    `Case Name` = case_name,
    `Answer Correct?` = answer_status
  )

# Save as CSV
write_csv(table1, file.path(output_tables, "table1_case_summary.csv"))

cat("\n=== Table 1 saved ===\n")
cat("File:", file.path(output_tables, "table1_case_summary.csv"), "\n")

# Display first few rows
cat("\nFirst 10 cases:\n")
print(head(table1, 10))
