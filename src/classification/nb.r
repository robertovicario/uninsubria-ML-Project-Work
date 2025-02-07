# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------
# Training
# ---------------------------------------------


# Strategy: Naive Bayes, Cross-Validation, Hyperparameter Tuning
nb_n_folds       <- 10
nb_train_control <- trainControl(method = "cv",
                                 number = nb_n_folds,
                                 verboseIter = TRUE)
nb_grid          <- expand.grid(fL = c(0, 0.5, 1),
                                usekernel = c(FALSE, TRUE),
                                adjust = c(0, 0.5, 1))

nb_model         <- train(type ~ .,
                          data = train,
                          method = "nb",
                          trControl = nb_train_control,
                          tuneGrid = nb_grid)
nb_predictions   <- predict(nb_model, newdata = test)


# ---------------------------------------------
# Evaluation
# ---------------------------------------------


# Strategy: Accuracy, Precision, Recall, F1
nb_confusion_matrix <- confusionMatrix(nb_predictions, test$type)
nb_acc              <- nb_confusion_matrix$overall["Accuracy"]
nb_prec             <- nb_confusion_matrix$byClass["Pos Pred Value"]
nb_rec              <- nb_confusion_matrix$byClass["Sensitivity"]
nb_f1               <- nb_confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(nb_acc, 3)))
print(paste("Precision:", round(nb_prec, 3)))
print(paste("   Recall:", round(nb_rec, 3)))
print(paste("       F1:", round(nb_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(nb_predictions, file = "./models/classification/nb.rdata")

# Exporting the metrics
log_file <- "./log/classification/nb.log"
log_msg  <- paste("Naive Bayes:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", nb_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", nb_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", nb_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", nb_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
