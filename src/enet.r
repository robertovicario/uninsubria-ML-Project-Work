# ---------------------------------------------


# Importing the libraries
library(caret)
library(glmnet)

# Loading the preprocessed data
load("./src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Elastic Net Regression, Cross-Validation, Regularization
enet_n_folds       <- 10
enet_train_control <- trainControl(method = "cv", number = enet_n_folds)
enet_grid          <- expand.grid(alpha = seq(0, 1, by = 0.1),
                                  lambda = seq(0.001, 0.1, by = 0.001))

enet_model         <- train(median_house_value ~ .,
                            data = train,
                            method = "glmnet",
                            trControl = enet_train_control,
                            tuneGrid = enet_grid)
enet_predictions   <- predict(enet_model, newdata = test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
enet_mse <- mean((enet_predictions - test$median_house_value)^2)
enet_r2  <- cor(enet_predictions, test$median_house_value)^2

print(paste("MSE:", round(enet_mse, 3)))
print(paste(" R2:", round(enet_r2, 3)))


# ---------------------------------------------


# Exporting the metrics
log_file <- "./log/enet.log"
log_msg  <- paste("Elastic Net Regression:")
log_msg  <- paste(log_msg, "\n    - MSE:", enet_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", enet_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, appenetd = TRUE)


# ---------------------------------------------
