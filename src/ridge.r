# ---------------------------------------------


# Loading the preprocessed data
data <- load("./src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Ridge Regression
library(glmnet)
x_train <- model.matrix(median_house_value ~ ., train)[, -1]
y_train <- train$median_house_value
x_test <- model.matrix(median_house_value ~ ., test)[, -1]

ridge_model <- cv.glmnet(x_train, y_train, alpha = 0)
ridge_predictions <- predict(ridge_model,
                             s = ridge_model$lambda.min,
                             newx = x_test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
ridge_mse <- mean((ridge_predictions - test$median_house_value)^2)
sst <- sum((test$median_house_value - mean(test$median_house_value))^2)
sse <- sum((ridge_predictions - test$median_house_value)^2)
ridge_r2 <- 1 - sse / sst

print(paste("Ridge Regression, MSE:", ridge_mse))
print(paste("Ridge Regression, R2:", ridge_r2))


# ---------------------------------------------
