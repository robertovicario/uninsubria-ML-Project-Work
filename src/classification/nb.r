# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Naive Bayes, Cross-Validation, Hyperparameter Tuning
nb_n_folds       <- 10
nb_train_control <- trainControl(method = "cv", number = nb_n_folds)
nb_grid          <- expand.grid(fL = c(0, 0.5, 1),
                                usekernel = c(TRUE, FALSE),
                                adjust = c(1, 1.5, 2))

nb_model         <- train(type ~ .,
                          data = train,
                          method = "nb",
                          trControl = nb_train_control,
                          tuneGrid = nb_grid)
nb_predictions   <- predict(nb_model, newdata = test)

print(nb_model$bestTune)
print(nb_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
confusion_matrix <- confusionMatrix(nb_predictions, test$type)
nb_acc          <- confusion_matrix$overall["Accuracy"]
nb_prec         <- confusion_matrix$byClass["Pos Pred Value"]
nb_rec          <- confusion_matrix$byClass["Sensitivity"]
nb_f1           <- confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(nb_acc, 3)))
print(paste("Precision:", round(nb_prec, 3)))
print(paste("   Recall:", round(nb_rec, 3)))
print(paste("       F1:", round(nb_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(nb_model, file = "./models/classification/nb.h5")

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
