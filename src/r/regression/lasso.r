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

lasso_model <- train(
  median_house_value ~ .,
  data = train_scaled, method = "glmnet",
  trControl = train_control,
  tuneGrid = expand.grid(alpha = 1, lambda = 10^seq(3, -3, by = -0.1))
)
lasso_preds <- predict(lasso_model, newdata = test_scaled)

# ------------------
# ----- Saving -----
# ------------------

# Saving Results
sink("../../data/logs/lasso_results.log")

# ----------------------
# ----- Evaluation -----
# ----------------------

# MSE
lasso_preds_mse <- mean((y_test - lasso_preds)^2)
cat("Elastic Net MSE:", lasso_preds_mse, "\n")

# MAE
lasso_predse_mae <- mean(abs(y_test - lasso_preds))
cat("Elastic Net MAE:", lasso_predse_mae, "\n")

# R-squared
lasso_preds_r2 <- summary(lm(y_test ~ lasso_preds))$r.squared
cat("Elastic Net R-squared:", lasso_preds_r2, "\n")

# Saving Results
sink()
