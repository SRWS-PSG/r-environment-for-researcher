# ============================================================================
# ChatGPT Diagnostic Accuracy Study - Secondary Outcomes
# ============================================================================
# Paper: Evaluation of ChatGPT as a diagnostic tool for medical learners
#        and clinicians (PLOS ONE, DOI: 10.1371/journal.pone.0307383)
# ============================================================================

# Source setup
source(here::here("projects", "chatgpt_diagnostic_study", "scripts", "00_setup.R"))

# Load processed data
cases <- read_csv(
  file.path(data_processed, "chatgpt_cases_cleaned.csv"),
  show_col_types = FALSE
)

cat("=== Secondary Outcomes Analysis ===\n")
cat("Total cases:", nrow(cases), "\n\n")

# ============================================================================
# 1. Cognitive Load Distribution (Figure 4)
# ============================================================================

cognitive_load_dist <- cases |>
  filter(!is.na(cognitive_load_std)) |>
  count(cognitive_load_std) |>
  mutate(
    pct = n / sum(n) * 100,
    cognitive_load_std = factor(cognitive_load_std, 
                                levels = c("Low", "Moderate", "High"))
  ) |>
  arrange(cognitive_load_std)

cat("=== Cognitive Load Distribution ===\n")
print(cognitive_load_dist)

cat("\n--- Paper Comparison ---\n")
cat("Paper: Low 51% (77/150), Moderate 41% (61/150), High 7% (11/150)\n")

# Create Figure 4
fig4 <- ggplot(cognitive_load_dist, 
               aes(x = cognitive_load_std, y = pct, fill = cognitive_load_std)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = sprintf("%.1f%%\n(n=%d)", pct, n)), 
            vjust = -0.3, size = 4) +
  scale_fill_manual(values = c(
    "Low" = "#4CAF50",
    "Moderate" = "#FFC107", 
    "High" = "#F44336"
  )) +
  scale_y_continuous(limits = c(0, 100), 
                     breaks = seq(0, 100, 20),
                     expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Cognitive Load of ChatGPT Answers",
    subtitle = sprintf("N = %d cases", sum(cognitive_load_dist$n)),
    x = "Cognitive Load Level",
    y = "Percentage (%)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid.major.x = element_blank()
  )

# Save Figure 4
ggsave(
  filename = file.path(output_figures, "fig4_cognitive_load.png"),
  plot = fig4,
  width = 6,
  height = 5,
  dpi = 300
)

ggsave(
  filename = file.path(output_figures, "fig4_cognitive_load.pdf"),
  plot = fig4,
  width = 6,
  height = 5
)

cat("\n=== Figure 4 saved ===\n")

# ============================================================================
# 2. Quality of Medical Information Distribution (Figure 5)
# ============================================================================

quality_dist <- cases |>
  filter(!is.na(quality_answer_std)) |>
  count(quality_answer_std) |>
  mutate(
    pct = n / sum(n) * 100,
    quality_answer_std = factor(quality_answer_std, levels = c(
      "Complete Relevant",
      "Complete Irrelevant",
      "Incomplete Relevant",
      "Incomplete Irrelevant"
    ))
  ) |>
  arrange(quality_answer_std)

cat("\n=== Quality of Medical Information Distribution ===\n")
print(quality_dist)

cat("\n--- Paper Comparison ---\n")
cat("Paper: Complete/Relevant 52% (78/150)\n")
cat("       Complete/Irrelevant 0% (0/150)\n")
cat("       Incomplete/Relevant 43% (64/150)\n")
cat("       Incomplete/Irrelevant 5% (8/150)\n")

# Create Figure 5
fig5 <- ggplot(quality_dist, 
               aes(x = quality_answer_std, y = pct, fill = quality_answer_std)) +
  geom_col(width = 0.7) +
  geom_text(aes(label = sprintf("%.1f%%\n(n=%d)", pct, n)), 
            vjust = -0.3, size = 3.5) +
  scale_fill_manual(values = c(
    "Complete Relevant" = "#4CAF50",
    "Complete Irrelevant" = "#FFC107",
    "Incomplete Relevant" = "#2196F3",
    "Incomplete Irrelevant" = "#F44336"
  )) +
  scale_y_continuous(limits = c(0, 100), 
                     breaks = seq(0, 100, 20),
                     expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "Quality of Medical Information in ChatGPT Answers",
    subtitle = sprintf("N = %d cases", sum(quality_dist$n)),
    x = "Quality Category",
    y = "Percentage (%)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "none",
    plot.title = element_text(face = "bold", hjust = 0.5),
    plot.subtitle = element_text(hjust = 0.5),
    panel.grid.major.x = element_blank(),
    axis.text.x = element_text(angle = 15, hjust = 1, size = 9)
  )

# Save Figure 5
ggsave(
  filename = file.path(output_figures, "fig5_quality_answers.png"),
  plot = fig5,
  width = 8,
  height = 5,
  dpi = 300
)

ggsave(
  filename = file.path(output_figures, "fig5_quality_answers.pdf"),
  plot = fig5,
  width = 8,
  height = 5
)

cat("\n=== Figure 5 saved ===\n")

# ============================================================================
# 3. Inter-Rater Reliability (Cohen's Kappa)
# ============================================================================

cat("\n=== Inter-Rater Reliability Analysis ===\n")
cat("Note: Using synthetic data with simulated 2 reviewers\n")
cat("Paper reported: Diagnostic accuracy kappa = 0.78 (substantial)\n")
cat("               Cognitive load kappa = 0.64 (substantial)\n")
cat("               Quality of medical info kappa = 1.0 (perfect)\n")

# ============================================================================
# 4. Save secondary outcomes summary
# ============================================================================

# Get values for each category
get_n <- function(df, val) {
  row <- df[df[[1]] == val, ]
  if (nrow(row) > 0) row$n[1] else 0
}

secondary_outcomes <- tibble(
  Outcome = c(
    "Cognitive Load - Low",
    "Cognitive Load - Moderate", 
    "Cognitive Load - High",
    "Quality - Complete/Relevant",
    "Quality - Complete/Irrelevant",
    "Quality - Incomplete/Relevant",
    "Quality - Incomplete/Irrelevant"
  ),
  Our_N = c(
    get_n(cognitive_load_dist, "Low"),
    get_n(cognitive_load_dist, "Moderate"),
    get_n(cognitive_load_dist, "High"),
    get_n(quality_dist, "Complete Relevant"),
    get_n(quality_dist, "Complete Irrelevant"),
    get_n(quality_dist, "Incomplete Relevant"),
    get_n(quality_dist, "Incomplete Irrelevant")
  ),
  Paper_N = c(77, 61, 11, 78, 0, 64, 8)
)

write_csv(secondary_outcomes, file.path(output_tables, "secondary_outcomes.csv"))

cat("\n=== Secondary outcomes summary saved ===\n")
print(secondary_outcomes)
