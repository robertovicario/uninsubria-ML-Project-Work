# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/regression/preprocessing.rdata")


# ---------------------------------------------
# Training
# ---------------------------------------------


# Training the model
# Strategy: Linear Regression, Cross-Validation
ols_n_folds       <- 10
ols_train_control <- trainControl(method = "cv", number = ols_n_folds)

ols_model         <- train(MED.VALUE ~ .,
                           data = train,
                           method = "lm",
                           trControl = ols_train_control)
ols_predictions   <- predict(ols_model, newdata = test)

print(ols_model$bestTune)
print(ols_model$finalModel)


# ---------------------------------------------
# Evaluation
# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
ols_mse <- mean((ols_predictions - test$MED.VALUE)^2)
ols_r2  <- cor(ols_predictions, test$MED.VALUE)^2

print(paste("MSE:", round(ols_mse, 3)))
print(paste(" R2:", round(ols_r2, 3)))


# ---------------------------------------------


# Exporting the model
save(ols_predictions, file = "./models/regression/ols.rdata")

# Exporting the metrics
log_file <- "./log/regression/ols.log"
log_msg  <- paste("Linear Regression:")
log_msg  <- paste(log_msg, "\n    - MSE:", ols_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", ols_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
