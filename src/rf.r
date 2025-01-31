# ---------------------------------------------


# Imports
library(caret)
library(randomForest)

# Loading the preprocessed data
data <- load("./src/preprocessing.rdata")


# ---------------------------------------------


# Tuning the hyperparameters
# Strategy: Cross-Validation with 5 folds
n_fold <- 5
control <- trainControl(method = "cv", number = n_fold)
tune_grid <- expand.grid(mtry = c(2, 4, 6, 8, 10))


# ---------------------------------------------


# Training the model
# Strategy: Random Forest with 500 trees
set.seed(123)
n_tree <- 500
rf_tuned <- train(median_house_value ~ .,
                  data = train,
                  method = "rf",
                  trControl = control,
                  tuneGrid = tune_grid,
                  ntree = n_tree)
best_mtry <- rf_tuned$bestTune$mtry
rf_model <- randomForest(median_house_value ~ .,
                         data = train,
                         ntree = n_tree,
                         mtry = best_mtry)
rf_predictions <- predict(rf_model, newdata = test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
rf_mse <- mean((rf_predictions - test$median_house_value)^2)
sst <- sum((test$median_house_value - mean(test$median_house_value))^2)
sse <- sum((rf_predictions - test$median_house_value)^2)
rf_r2 <- 1 - sse / sst

print(paste("Random Forest, MSE:", rf_mse))
print(paste("Random Forest, R2:", rf_r2))


# ---------------------------------------------
