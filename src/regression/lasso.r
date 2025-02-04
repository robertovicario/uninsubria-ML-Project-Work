# ---------------------------------------------


# Importing the libraries
library(caret)
library(glmnet)

# Loading the preprocessed data
load("./src/regression/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: LASSO Regression, Cross-Validation, Regularization
lasso_n_folds       <- 10
lasso_train_control <- trainControl(method = "cv", number = lasso_n_folds)
lasso_grid          <- expand.grid(fraction = seq(0, 1, by = 0.1))

lasso_model         <- train(MED.VALUE ~ .,
                             data = train,
                             method = "lasso",
                             trControl = lasso_train_control,
                             tuneGrid = lasso_grid)
lasso_predictions   <- predict(lasso_model, newdata = test)

print(lasso_model$bestTune)
print(lasso_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
lasso_mse <- mean((lasso_predictions - test$MED.VALUE)^2)
lasso_r2  <- cor(lasso_predictions, test$MED.VALUE)^2

print(paste("MSE:", round(lasso_mse, 3)))
print(paste(" R2:", round(lasso_r2, 3)))


# ---------------------------------------------


# Exporting the model
save(lasso_predictions, file = "./models/regression/lasso.rdata")

# Exporting the metrics
log_file <- "./log/regression/lasso.log"
log_msg  <- paste("LASSO Regression:")
log_msg  <- paste(log_msg, "\n    - MSE:", lasso_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", lasso_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
