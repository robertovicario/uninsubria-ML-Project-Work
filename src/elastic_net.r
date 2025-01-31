# ---------------------------------------------


# Loading the preprocessed data
data <- load("./src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Elastic Net Regression
elastic_net_model <- cv.glmnet(x_train, y_train, alpha = 0.5)
elastic_net_predictions <- predict(elastic_net_model,
                                   s = elastic_net_model$lambda.min,
                                   newx = x_test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
mse <- mean((elastic_net_predictions - test$median_house_value)^2)
sst <- sum((test$median_house_value - mean(test$median_house_value))^2)
sse <- sum((elastic_net_predictions - test$median_house_value)^2)
r2 <- 1 - sse / sst

print(paste("MSE:", round(mse, 3)))
print(paste("R2:", round(r2, 3)))


# ---------------------------------------------
