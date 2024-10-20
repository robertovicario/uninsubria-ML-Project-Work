accuracy <- function(y_pred, y_test) {
  mean(y_pred == y_test, na.rm = TRUE)
}

precision <- function(y_pred, y_test) {
  tp <- sum(y_pred == 1 & y_test == 1, na.rm = TRUE)
  fp <- sum(y_pred == 1 & y_test == 0, na.rm = TRUE)
  
  if (tp + fp == 0) return(NA)

  tp / (tp + fp)
}

recall <- function(y_pred, y_test) {
  tp <- sum(y_pred == 1 & y_test == 1, na.rm = TRUE)
  fn <- sum(y_pred == 0 & y_test == 1, na.rm = TRUE)
  
  if (tp + fn == 0) return(NA)
  
  tp / (tp + fn)
}

f1_score <- function(y_pred, y_test) {
  precision_val <- precision(y_pred, y_test)
  recall_val <- recall(y_pred, y_test)
  
  if (is.na(precision_val) || is.na(recall_val)) return(NA)
  
  2 * (precision_val * recall_val) / (precision_val + recall_val)
}

save(accuracy, precision, recall, f1_score, file = "classification/metrics.RData") # nolint
print("Saved: 'classification/metrics.RData'")
