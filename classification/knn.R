library(class)  # For KNN
library(e1071)  # For tuning and evaluation metrics
load("classification/metrics.rData")
load("classification/preprocessing.rData")

# Scale the training and test data
x_train <- scale(x_train_lda)
x_test <- scale(x_test_lda)

# Define a range of k values to test
k_values <- seq(1, 20, by = 1)

# Initialize variables to store results
accuracy_results <- c()
precision_results <- c()
recall_results <- c()
f1_results <- c()

# Loop over k values
for (k in k_values) {
    # KNN prediction
    y_pred <- knn(x_train, x_test, as.factor(y_train), k = k)
    
    # Calculate metrics
    accuracy_results[k] <- accuracy(y_pred, y_test)
    precision_results[k] <- precision(y_pred, y_test)
    recall_results[k] <- recall(y_pred, y_test)
    f1_results[k] <- f1_score(y_pred, y_test)
}

# Find the best k value based on accuracy
best_k <- which.max(accuracy_results)
print(paste("Best k:", best_k))
print(paste("Best Accuracy:", accuracy_results[best_k]))
print(paste("Precision:", precision_results[best_k]))
print(paste("Recall:", recall_results[best_k]))
print(paste("F1-Score:", f1_results[best_k]))

y_pred <- knn(x_train, x_test, as.factor(y_train), k = best_k)

# Final evaluation
print(paste("Final Accuracy:", accuracy(final_y_pred, y_test)))
print(paste("Final Precision:", precision(final_y_pred, y_test)))
print(paste("Final Recall:", recall(final_y_pred, y_test)))
print(paste("Final F1-Score:", f1_score(final_y_pred, y_test)))
