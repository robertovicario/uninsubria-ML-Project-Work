# Load necessary libraries
library(MASS)

# Load the preprocessed data
load("regression/preprocessing.RData")

# Fit the OLS model using the PCA-transformed training data
ols_model <- lm(y_train ~ ., data = x_train_pca)

# Summarize the model
summary(ols_model)

# Make predictions on the test set
predictions <- predict(ols_model, newdata = x_test_pca)

# Evaluate the model performance
# Calculate R-squared
r_squared <- summary(ols_model)$r.squared

# Calculate RMSE
rmse <- sqrt(mean((predictions - y_test) ^ 2))

# Print evaluation metrics
print(paste("R-squared:", round(r_squared, 4)))
print(paste("RMSE:", round(rmse, 4)))
