accuracy <- function(y_pred, y_test) {
  val <- mean(y_pred == y_test)
  return(val)
}

precision <- function(y_pred, y_test) {
  tp <- sum(y_pred == 1 & y_test == 1)
  fp <- sum(y_pred == 1 & y_test == 0)
  val <- tp / (tp + fp)
  return(val)
}

recall <- function(y_pred, y_test) {
  tp <- sum(y_pred == 1 & y_test == 1)
  fn <- sum(y_pred == 0 & y_test == 1)
  val <- tp / (tp + fn)
  return(val)
}

f1_score <- function(y_pred, y_test) {
  precision <- precision(y_pred, y_test)
  recall <- recall(y_pred, y_test)
  val <- 2 * (precision * recall) / (precision + recall)
  return(val)
}

confusion_matrix <- function(y_pred, y_test) {
  val <- table(y_test, y_pred)
  return(val)
}

save(accuracy, confusion_matrix, precision, recall, f1_score, file = "classification/metrics.RData") # nolint
print("Saved: 'classification/metrics.RData'")
