# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------


# Training the model
# Strategy: rnn, Cross-Validation, Hyperparameter Tuning

rnn_n_folds       <- 10
rnn_train_control <- trainControl(method = "cv", number = rnn_n_folds)
rnn_grid          <- expand.grid(C = 2^(-5:2), sigma = 2^(-15:3))

rnn_model         <- train(type ~ .,
                           data = train,
                           method = "rnnRadial",
                           trControl = rnn_train_control,
                           tuneGrid = rnn_grid)
rnn_predictions   <- predict(rnn_model, newdata = test)

print(rnn_model$bestTune)
print(rnn_model$finalModel)


# ---------------------------------------------


# Evaluating the model
# Strategy: Accuracy, Precision, Recall, F1
confusion_matrix <- confusionMatrix(rnn_predictions, test$type)
rnn_acc          <- confusion_matrix$overall["Accuracy"]
rnn_prec         <- confusion_matrix$byClass["Pos Pred Value"]
rnn_rec          <- confusion_matrix$byClass["Sensitivity"]
rnn_f1           <- confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(rnn_acc, 3)))
print(paste("Precision:", round(rnn_prec, 3)))
print(paste("   Recall:", round(rnn_rec, 3)))
print(paste("       F1:", round(rnn_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(rnn_model, file = "./models/classification/rnn.h5")

# Exporting the metrics
log_file <- "./log/classification/rnn.log"
log_msg  <- paste("Recurrent Neural Network:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", rnn_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", rnn_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", rnn_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", rnn_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
