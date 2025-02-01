# ---------------------------------------------


# Importing the libraries
library(caret)
library(glmnet)

# Loading the preprocessed data
load("./src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: LASSO Regression, Cross-Validation, Regularization
lasso_n_folds       <- 10
lasso_train_control <- trainControl(method = "cv", number = lasso_n_folds)
lasso_grid          <- expand.grid(alpha = 1,
                                   lambda = seq(0.001, 0.1, by = 0.001))

lasso_model         <- train(median_house_value ~ .,
                             data = train,
                             method = "glmnet",
                             trControl = lasso_train_control,
                             tuneGrid = lasso_grid)
lasso_predictions   <- predict(lasso_model, newdata = test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
lasso_mse <- mean((lasso_predictions - test$median_house_value)^2)
lasso_r2  <- cor(lasso_predictions, test$median_house_value)^2

print(paste("MSE:", round(lasso_mse, 3)))
print(paste(" R2:", round(lasso_r2, 3)))


# ---------------------------------------------


# Exporting the metrics
log_file <- "./log/lasso.log"
log_msg  <- paste("LASSO Regression:")
log_msg  <- paste(log_msg, "\n    - MSE:", lasso_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", lasso_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
