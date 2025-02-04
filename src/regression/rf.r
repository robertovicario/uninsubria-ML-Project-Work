# ---------------------------------------------


# Importing the libraries
library(caret)
library(randomForest)

# Loading the preprocessed data
load("./src/regression/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Random Forest Regressor, Cross-Validation, Hyperparameter Tuning

rf_n_folds       <- 10
rf_train_control <- trainControl(method = "cv",
                                 number = rf_n_folds,
                                 verboseIter = TRUE)
rf_grid          <- expand.grid(mtry = c(2, 3, 4, 5))

rf_model         <- train(MED.VALUE ~ .,
                          data = train,
                          method = "rf",
                          trControl = rf_train_control,
                          tuneGrid = rf_grid)
rf_predictions   <- predict(rf_model, newdata = test)

print(rf_model$bestTune)
print(rf_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2

rf_mse <- mean((rf_predictions - test$MED.VALUE)^2)
rf_r2  <- cor(rf_predictions, test$MED.VALUE)^2

print(paste("MSE:", round(rf_mse, 3)))
print(paste(" R2:", round(rf_r2, 3)))


# ---------------------------------------------


# Exporting the model
save(rf_predictions, file = "./models/regression/rf.rdata")

# Exporting the metrics
log_file <- "./log/regression/rf.log"
log_msg  <- paste("Random Forest Regressor:")
log_msg  <- paste(log_msg, "\n    - MSE:", rf_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", rf_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
