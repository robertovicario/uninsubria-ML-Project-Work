# ---------------------
# ----- Importing -----
# ---------------------

load("data/models/eda.rdata")

# -------------------------
# ----- Preprocessing -----
# -------------------------

# Splitting Data
set.seed(42)
train_index <- createDataPartition(data$median_house_value, p = 0.8, list = FALSE)

# Scaling Data
train_data <- data[train_index, ]
test_data <- data[-train_index, ]
scaler <- preProcess(train_data[, -ncol(train_data)], method = c("center", "scale"))

# Preparing Data
train_scaled <- predict(scaler, train_data)
test_scaled <- predict(scaler, test_data)
y_test <- test_scaled$median_house_value
train_control <- trainControl(method = "cv", number = 10)

# ---------------------
# ----- Exporting -----
# ---------------------

save(train_scaled, test_scaled, y_test, train_control, file = "data/models/preprocessing.rdata")
