# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: Naive Bayes, Cross-Validation, Hyperparameter Tuning

naivebys_n_folds       <- 10
naivebys_train_control <- trainControl(method = "cv", number = naivebys_n_folds)
naivebys_grid          <- expand.grid(C = 2^(-5:2), sigma = 2^(-15:3))

naivebys_model         <- train(type ~ .,
                                data = train,
                                method = "svmRadial",
                                trControl = naivebys_train_control,
                                tuneGrid = naivebys_grid)
naivebys_predictions   <- predict(naivebys_model, newdata = test)

print(naivebys_model$bestTune)
print(naivebys_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
confusion_matrix <- confusionMatrix(naivebys_predictions, test$type)
naivebys_acc          <- confusion_matrix$overall["Accuracy"]
naivebys_prec         <- confusion_matrix$byClass["Pos Pred Value"]
naivebys_rec          <- confusion_matrix$byClass["Sensitivity"]
naivebys_f1           <- confusion_matrix$byClass["F1"]

print(paste("  Accuracy:", round(naivebys_acc, 3)))
print(paste(" Precision:", round(naivebys_prec, 3)))
print(paste("    Recall:", round(naivebys_rec, 3)))
print(paste("        F1:", round(naivebys_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(naivebys_model, file = "./models/classification/naivebys.h5")

# Exporting the metrics
log_file <- "./log/classification/naivebys.log"
log_msg  <- paste("naivebys:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", naivebys_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", naivebys_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", naivebys_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", naivebys_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
