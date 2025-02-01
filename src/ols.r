# ---------------------------------------------


# Loading the preprocessed data
load("./src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Linear Regression, Cross-Validation
n_folds         <- 10
train_control   <- trainControl(method = "cv", number = n_folds)

ols_model       <- train(median_house_value ~ .,
                         data = train,
                         method = "lm",
                         trControl = train_control)
ols_predictions <- predict(ols_model, newdata = test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
mse <- mean((ols_predictions - test$median_house_value)^2)
r2  <- summary(ols_model)$r.squared

print(paste("MSE:", round(mse, 3)))
print(paste(" R2:", round(r2, 3)))


# ---------------------------------------------


# Exporting the metrics
log_file <- "./log/ols.log"
log_msg  <- paste("Linear Regression:")
log_msg  <- paste(log_msg, "\n    - MSE:", mse)
log_msg  <- paste(log_msg, "\n    -  R2:", r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------


# - **OLS does not require a `tuneGrid` because it has no tunable hyperparameters.**
# - If you want to improve OLS performance, consider **feature selection** or **regularization.**
# - If you need hyperparameter tuning, switch to **Ridge/Lasso regression** instead.

