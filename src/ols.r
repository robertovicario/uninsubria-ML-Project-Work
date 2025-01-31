# ---------------------------------------------


# Loading the dataset preprocessed
load("./src/preprocessing.rdata")


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

print(paste("Linear Regression, MSE:", round(mse, 3)))
print(paste("Linear Regression, R2:", round(r2, 3)))


# ---------------------------------------------
