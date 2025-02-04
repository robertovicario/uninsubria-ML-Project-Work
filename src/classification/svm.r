# ---------------------------------------------


# Importing the libraries
library(caret)
library(e1071)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: SVM, Cross-Validation, Hyperparameter Tuning
svm_n_folds       <- 10
svm_train_control <- trainControl(method = "cv", number = svm_n_folds)
svm_grid          <- expand.grid(C = 2^(-5:2), sigma = 2^(-15:3))

svm_model         <- train(type ~ .,
                           data = train,
                           method = "svmRadial",
                           trControl = svm_train_control,
                           tuneGrid = svm_grid)
svm_predictions   <- predict(svm_model, newdata = test)

print(svm_model$bestTune)
print(svm_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
confusion_matrix <- confusionMatrix(svm_predictions, test$type)
svm_acc          <- confusion_matrix$overall["Accuracy"]
svm_prec         <- confusion_matrix$byClass["Pos Pred Value"]
svm_rec          <- confusion_matrix$byClass["Sensitivity"]
svm_f1           <- confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(svm_acc, 3)))
print(paste("Precision:", round(svm_prec, 3)))
print(paste("   Recall:", round(svm_rec, 3)))
print(paste("       F1:", round(svm_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(svm_model, file = "./models/classification/svm.rdata")

# Exporting the metrics
log_file <- "./log/classification/svm.log"
log_msg  <- paste("Support Vector Machine:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", svm_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", svm_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", svm_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", svm_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
