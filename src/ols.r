# ---------------------------------------------


# Loading the dataset preprocessed
data <- load("./src/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Linear Regression
ols_model <- lm(median_house_value ~ ., data = train)
ols_predictions <- predict(ols_model, newdata = test)


# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2
mse <- mean((ols_predictions - test$median_house_value)^2)
r2 <- summary(ols_model)$r.squared

print(paste("Linear Regression, MSE:", mse))
print(paste("Linear Regression, R2:", r2))


# ---------------------------------------------


#  [1] "Ridge Regression, MSE: 0.270333772729066"
#  [1] "Ridge Regression, R2: 0.723246038676229"
#  [1] "LASSO Regression, MSE: 0.25181691265452"
#  [1] "LASSO Regression, R2: 0.74220265784066"
#  [1] "Elastic Net Regression, MSE: 0.251818941392819"
#  [1] "Elastic Net Regression, R2: 0.742200580921616"
#  [1] "Random Forest, MSE: 0.12583396004206"
#  [1] "Random Forest, R2: 0.871177594426577"
