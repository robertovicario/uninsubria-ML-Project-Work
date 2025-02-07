# ---------------------------------------------


# Importing the libraries
library(caret)

# Loading the preprocessed data
load("./src/regression/preprocessing.rdata")


# ---------------------------------------------
# Training
# ---------------------------------------------


# Training the model
# Strategy: Random Forest Regressor, Cross-Validation, Hyperparameter Tuning
rf_n_folds       <- 10
rf_train_control <- trainControl(method = "cv",
                                 number = rf_n_folds,
                                 verboseIter = TRUE)
rf_grid          <- expand.grid(mtry = seq(1, 10, by = 1))

rf_model         <- train(MED.VALUE ~ .,
                          data = train,
                          method = "rf",
                          trControl = rf_train_control,
                          tuneGrid = rf_grid)
rf_predictions   <- predict(rf_model, newdata = test)


# ---------------------------------------------
# Learning Curve
# ---------------------------------------------


# Building the visualization
# Strategy: Learning Curve
rf_results <- rf_model$results
print(ggplot(data.frame(Hyperparameter = rf_results$mtry,
                        R2 = rf_results$Rsquared),
             aes(x = Hyperparameter,
                 y = R2)) +
        ggtitle("Random Forest Learning Curve") +
        xlab("mtry") +
        ylab("R2") +
        scale_x_continuous(breaks = unique(rf_results$mtry)) +
        geom_point(color = "darkgreen") +
        geom_line(color = "darkgreen") +
        theme_bw() +
        theme(plot.title = element_text(size = 16,
                                        margin = margin(b = 20),
                                        hjust = 0.5)))

# Exporting the visualization
filename <- "./docs/plots/regression/rf-learning_curve.png"
ggsave(filename,
       device = "png",
       width = 10,
       height = 6,
       dpi = 300)


# ---------------------------------------------
# Evaluation
# ---------------------------------------------


# Evaluating the model
# Strategy: MSE, R2

rf_mse <- mean((rf_predictions - test$MED.VALUE)^2)
rf_r2  <- cor(rf_predictions, test$MED.VALUE)^2

print(paste("MSE:", round(rf_mse, 3)))
print(paste(" R2:", round(rf_r2, 3)))


# ---------------------------------------------


# Exporting the model
save(rf_predictions, file = "./models/regression/rf.rdata")

# Exporting the metrics
log_file <- "./log/regression/rf.log"
log_msg  <- paste("Random Forest:")
log_msg  <- paste(log_msg, "\n    - MSE:", rf_mse)
log_msg  <- paste(log_msg, "\n    -  R2:", rf_r2)
cat("", file = log_file)
cat(log_msg, file = log_file, append = TRUE)


# ---------------------------------------------
