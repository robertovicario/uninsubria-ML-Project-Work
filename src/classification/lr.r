# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------
# Training
# ---------------------------------------------


# Strategy: Logistic Regression, Cross-Validation, Hyperparameter Tuning
lr_n_folds       <- 10
lr_train_control <- trainControl(method = "cv",
                                 number = lr_n_folds,
                                 verboseIter = TRUE)
lr_grid          <- expand.grid(alpha = c(0, 0.5, 1),
                                lambda = c(0, 0.5, 1))

lr_model         <- train(type ~ .,
                          data = train,
                          method = "glmnet",
                          familiy = "binomial",
                          trControl = lr_train_control,
                          tuneGrid = lr_grid)
lr_predictions   <- predict(lr_model, newdata = test)


# ---------------------------------------------
# Evaluation
# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
lr_confusion_matrix <- confusionMatrix(lr_predictions, test$type)
lr_acc              <- lr_confusion_matrix$overall["Accuracy"]
lr_prec             <- lr_confusion_matrix$byClass["Pos Pred Value"]
lr_rec              <- lr_confusion_matrix$byClass["Sensitivity"]
lr_f1               <- lr_confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(lr_acc, 3)))
print(paste("Precision:", round(lr_prec, 3)))
print(paste("   Recall:", round(lr_rec, 3)))
print(paste("       F1:", round(lr_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(lr_predictions, file = "./models/classification/lr.rdata")

# Exporting the metrics
log_file <- "./log/classification/lr.log"
log_msg  <- paste("Logistic Regression:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", lr_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", lr_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", lr_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", lr_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
