# ---------------------------------------------


# Importing libraries
library(caret)

# Loading the preprocessed data
load("./src/preprocessing.rdata")


# ---------------------------------------------


# Tuning the hyperparameters
# Strategy: Cross-Validation, Grid Search
n_folds <- 10
train_control <- trainControl(method = "cv", number = n_folds)
tune_grid <- expand.grid(intercept = c(TRUE, FALSE))

# Training the model
# Strategy: Linear Regression
ols_model <- train(median_house_value ~ .,
                   data = train,
                   method = "lm",
                   trControl = train_control,
                   tuneGrid = tune_grid)
ols_predictions <- predict(ols_model, newdata = test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
mse <- mean((ols_predictions - test$median_house_value)^2)
r2 <- summary(ols_model)$r.squared

print(paste("MSE:", round(mse, 3)))
print(paste(" R2:", round(r2, 3)))


# ---------------------------------------------


# Exporting the metrics
log_file <- "./log/ols.log"
log_msg <- paste("Linear Regression:")
log_msg <- paste(log_msg, "\n    - MSE:", mse)
log_msg <- paste(log_msg, "\n    -  R2:", r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
