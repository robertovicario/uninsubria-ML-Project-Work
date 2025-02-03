# ---------------------------------------------


# Importing the libraries
library(caret)
library(glmnet)

# Loading the preprocessed data
load("./src/regression/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Ridge Regression, Cross-Validation, Regularization
ridge_n_folds       <- 10
ridge_train_control <- trainControl(method = "cv", number = ridge_n_folds)
ridge_grid          <- expand.grid(alpha = 0,
                                   lambda = seq(0.001, 0.1, by = 0.001))

ridge_model         <- train(MED.VALUE ~ .,
                             data = train,
                             method = "glmnet",
                             trControl = ridge_train_control,
                             tuneGrid = ridge_grid)
ridge_predictions   <- predict(ridge_model, newdata = test)

print(ridge_model$bestTune)
print(ridge_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
ridge_mse <- mean((ridge_predictions - test$MED.VALUE)^2)
ridge_r2  <- cor(ridge_predictions, test$MED.VALUE)^2

print(paste("MSE:", round(ridge_mse, 3)))
print(paste(" R2:", round(ridge_r2, 3)))


# ---------------------------------------------


# Exporting the model
save(ridge_model, file = "./models/regression/ridge.h5")

# Exporting the metrics
log_file <- "./log/regression/ridge.log"
log_msg  <- paste("Ridge Regression:")
log_msg  <- paste(log_msg, "\n    - MSE:", ridge_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", ridge_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
