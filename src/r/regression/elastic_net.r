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

elastic_net_model <- train(
  median_house_value ~ .,
  data = train_scaled, method = "glmnet",
  trControl = train_control,
  tuneGrid = expand.grid(alpha = seq(0, 1, by = 0.1), lambda = 10^seq(3, -3, by = -0.1))
)
elastic_net_preds <- predict(elastic_net_model, newdata = test_scaled)

# ------------------
# ----- Saving -----
# ------------------

# Saving Results
sink("../../data/logs/elastic_net_results.log")

# ----------------------
# ----- Evaluation -----
# ----------------------

# MSE
elastic_net_preds_mse <- mean((y_test - elastic_net_preds)^2)
cat("Elastic Net MSE:", elastic_net_preds_mse, "\n")

# MAE
elastic_net_predse_mae <- mean(abs(y_test - elastic_net_preds))
cat("Elastic Net MAE:", elastic_net_predse_mae, "\n")

# R-squared
elastic_net_preds_r2 <- summary(lm(y_test ~ elastic_net_preds))$r.squared
cat("Elastic Net R-squared:", elastic_net_preds_r2, "\n")

# Saving Results
sink()
