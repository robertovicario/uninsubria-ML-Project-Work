accuracy <- function(y_pred, y_test) {
  confusion_matrix <- table(Predicted = y_pred, Actual = as.factor(y_test))
  accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
  return(round(accuracy * 100, 4))
}

save(accuracy, file = "classification/metrics.RData")
print("Saved: 'classification/metrics.RData'")
