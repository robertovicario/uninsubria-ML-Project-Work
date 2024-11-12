# Load required libraries
library(glmnet)
library(caret)
library(ggplot2)
library(hexbin)

# --- EDA and Data Preprocessing Section ---

# Load data
data <- read.csv("../../data/raw/california_housing.csv")

# Remove duplicate rows
data <- unique(data)

# Impute missing values with median
for (col in names(data)) {
  if (any(is.na(data[[col]]))) {
    data[[col]][is.na(data[[col]])] <- median(data[[col]], na.rm = TRUE)
  }
}

# Cap outliers using IQR
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    Q1 <- quantile(data[[col]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[col]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    data[[col]][data[[col]] < lower_bound] <- lower_bound
    data[[col]][data[[col]] > upper_bound] <- upper_bound
  }
}

# Create a color ramp sorted by darkness
hb_colors <- colorRampPalette(c("blue", "red", "green", "yellow"))

# Hexbin plot of Total Rooms vs Median House Value
hb1 <- hexbin(data$total_rooms, data$median_house_value)
plot(hb1, xlab = "Total Rooms", ylab = "Median House Value", colramp = hb_colors)

# Hexbin plot of Total Bedrooms vs Median House Value
hb2 <- hexbin(data$total_bedrooms, data$median_house_value)
plot(hb2, xlab = "Total Bedrooms", ylab = "Median House Value", colramp = hb_colors)

# Hexbin plot of Population vs Median House Value
hb3 <- hexbin(data$population, data$median_house_value)
plot(hb3, xlab = "Population", ylab = "Median House Value", colramp = hb_colors)

# Split data into training and testing
set.seed(42)
train_index <- createDataPartition(data$median_house_value, p = 0.8, list = FALSE)
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Scale the data
scaler <- preProcess(train_data[, -ncol(train_data)], method = c("center", "scale"))
train_scaled <- predict(scaler, train_data)
test_scaled <- predict(scaler, test_data)

# Prepare matrix for regression
y_test <- test_scaled$median_house_value

# Set up training control
train_control <- trainControl(method = "cv", number = 10)

# --- Ridge Regression Section ---

ridge_model <- train(
  median_house_value ~ .,
  data = train_scaled, method = "glmnet",
  trControl = train_control,
  tuneGrid = expand.grid(alpha = 0, lambda = 10^seq(3, -3, by = -0.1))
)
ridge_preds <- predict(ridge_model, newdata = test_scaled)
ridge_rmse <- sqrt(mean((y_test - ridge_preds)^2))
cat("Ridge RMSE:", ridge_rmse, "\n")

# --- Lasso Regression Section ---

lasso_model <- train(
  median_house_value ~ .,
  data = train_scaled, method = "glmnet",
  trControl = train_control,
  tuneGrid = expand.grid(alpha = 1, lambda = 10^seq(3, -3, by = -0.1))
)
lasso_preds <- predict(lasso_model, newdata = test_scaled)
lasso_rmse <- sqrt(mean((y_test - lasso_preds)^2))
cat("LASSO RMSE:", lasso_rmse, "\n")

# --- ElasticNet Regression Section ---

elastic_net_model <- train(
  median_house_value ~ .,
  data = train_scaled, method = "glmnet",
  trControl = train_control,
  tuneGrid = expand.grid(alpha = seq(0, 1, by = 0.1), lambda = 10^seq(3, -3, by = -0.1))
)
elastic_net_preds <- predict(elastic_net_model, newdata = test_scaled)
elastic_net_rmse <- sqrt(mean((y_test - elastic_net_preds)^2))
cat("Elastic Net RMSE:", elastic_net_rmse, "\n")
