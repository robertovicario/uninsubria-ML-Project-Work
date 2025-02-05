# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/regression/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Elastic Net Regression, Cross-Validation, Regularization
enet_n_folds       <- 10
enet_train_control <- trainControl(method = "cv", number = enet_n_folds)
enet_grid          <- expand.grid(fraction = seq(0, 1, by = 0.1),
                                  lambda = seq(0, 1, by = 0.1))

enet_model         <- train(MED.VALUE ~ .,
                            data = train,
                            method = "enet",
                            trControl = enet_train_control,
                            tuneGrid = enet_grid)
enet_predictions   <- predict(enet_model, newdata = test)

print(enet_model$bestTune)
print(enet_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
enet_mse <- mean((enet_predictions - test$MED.VALUE)^2)
enet_r2  <- cor(enet_predictions, test$MED.VALUE)^2

print(paste("MSE:", round(enet_mse, 3)))
print(paste(" R2:", round(enet_r2, 3)))


# ---------------------------------------------


# Exporting the model
save(enet_predictions, file = "./models/regression/enet.rdata")

# Exporting the metrics
log_file <- "./log/regression/enet.log"
log_msg  <- paste("Elastic Net:")
log_msg  <- paste(log_msg, "\n    - MSE:", enet_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", enet_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, appenetd = TRUE)


# ---------------------------------------------
