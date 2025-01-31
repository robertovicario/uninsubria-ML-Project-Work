# ---------------------------------------------


# Loading the dataset preprocessed
data <- load("/src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: LASSO Regression
lasso_model <- cv.glmnet(x_train, y_train, alpha = 1)
lasso_predictions <- predict(lasso_model,
                             s = lasso_model$lambda.min,
                             newx = x_test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
lasso_mse <- mean((lasso_predictions - test$median_house_value)^2)
sst <- sum((test$median_house_value - mean(test$median_house_value))^2)
sse <- sum((lasso_predictions - test$median_house_value)^2)
lasso_r2 <- 1 - sse / sst

print(paste("LASSO Regression, MSE:", lasso_mse))
print(paste("LASSO Regression, R2:", lasso_r2))


# ---------------------------------------------
