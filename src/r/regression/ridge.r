# ------------------------
# ----- Dependencies -----
# ------------------------

library(glmnet)
library(caret)
library(ggplot2)

# ---------------------
# ----- Importing -----
# ---------------------

load("../../data/models/preprocessing.rdata")

# --------------------
# ----- Training -----
# --------------------

ridge_model <- train(
  median_house_value ~ .,
  data = train_scaled, method = "glmnet",
  trControl = train_control,
  tuneGrid = expand.grid(alpha = 0, lambda = 10^seq(3, -3, by = -0.1))
)
ridge_preds <- predict(ridge_model, newdata = test_scaled)

# ------------------
# ----- Saving -----
# ------------------

# Saving Results
sink("../../data/logs/ridge_results.log")

# ----------------------
# ----- Evaluation -----
# ----------------------

# MSE
ridge_preds_mse <- mean((y_test - ridge_preds)^2)
cat("Elastic Net MSE:", ridge_preds_mse, "\n")

# MAE
ridge_predse_mae <- mean(abs(y_test - ridge_preds))
cat("Elastic Net MAE:", ridge_predse_mae, "\n")

# R-squared
ridge_preds_r2 <- summary(lm(y_test ~ ridge_preds))$r.squared
cat("Elastic Net R-squared:", ridge_preds_r2, "\n")

# Saving Results
sink()
