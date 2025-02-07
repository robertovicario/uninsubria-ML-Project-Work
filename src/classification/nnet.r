# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/classification/preprocessing.rdata")


# ---------------------------------------------
# Training
# ---------------------------------------------


# Strategy: Neural Network, Cross-Validation, Hyperparameter Tuning
nnet_n_folds       <- 10
nnet_train_control <- trainControl(method = "cv",
                                   number = nnet_n_folds,
                                   verboseIter = TRUE)
nnet_grid          <- expand.grid(size = c(5, 10, 15),
                                  decay = c(0.1, 0.5, 1.0))

nnet_model         <- train(type ~ .,
                            data = train,
                            method = "nnet",
                            trControl = nnet_train_control,
                            tuneGrid = nnet_grid)
nnet_predictions   <- predict(nnet_model, newdata = test)


# ---------------------------------------------
# Evaluation
# ---------------------------------------------


# Strategy: Accuracy, Precision, Recall, F1
net_confusion_matrix <- confusionMatrix(nnet_predictions, test$type)
nnet_acc             <- net_confusion_matrix$overall["Accuracy"]
nnet_prec            <- net_confusion_matrix$byClass["Pos Pred Value"]
nnet_rec             <- net_confusion_matrix$byClass["Sensitivity"]
nnet_f1              <- net_confusion_matrix$byClass["F1"]

print(paste(" Accuracy:", round(nnet_acc, 3)))
print(paste("Precision:", round(nnet_prec, 3)))
print(paste("   Recall:", round(nnet_rec, 3)))
print(paste("       F1:", round(nnet_f1, 3)))


# ---------------------------------------------


# Exporting the model
save(nnet_predictions, file = "./models/classification/nnet.rdata")

# Exporting the metrics
log_file <- "./log/classification/nnet.log"
log_msg  <- paste("Neural Network:")
log_msg  <- paste(log_msg, "\n    -  Accuracy:", nnet_acc)
log_msg  <- paste(log_msg, "\n    - Precision:", nnet_prec)
log_msg  <- paste(log_msg, "\n    -    Recall:", nnet_rec)
log_msg  <- paste(log_msg, "\n    -        F1:", nnet_f1)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
