# ---------------------------------------------


# Importing the libraries
library(ggplot2)

# Loading the models
load("./src/classification/preprocessing.rdata")
load("./models/classification/lr.rdata")
load("./models/classification/nb.rdata")
load("./models/classification/nnet.rdata")


# ---------------------------------------------
# Confusion Matrix
# ---------------------------------------------


plot_confusion_matrix <- function(title, model_name, model_predictions) {
  cm       <- table(Actual = test$type, Predicted = model_predictions)
  cm       <- as.data.frame(cm)
  print(ggplot(cm,
               aes(x = Actual,
                   y = Predicted,
                   fill = Freq)) +
    ggtitle(title) +
    xlab("Actual") +
    ylab("Predicted") +
    geom_tile() +
    scale_fill_distiller(palette = "Blues", direction = 1) +
    geom_text(aes(label = Freq), size = 10) +
    theme_bw() +
    theme(
      plot.title = element_text(size = 16,
                                margin = margin(b = 32),
                                hjust = 0.5),
      axis.text.x = element_text(size = 16),
      axis.text.y = element_text(size = 16),
      axis.title.x = element_text(size = 20,
                                  margin = margin(t = 20, b = 20)),
      axis.title.y = element_text(size = 20,
                                  margin = margin(r = 20))
    ))

  # Exporting the visualization
  filename <- paste0("./docs/plots/classification/",
                     model_name,
                     "_confusion_matrix.png")
  ggsave(filename,
         device = "png",
         width = 6,
         height = 6,
         dpi = 300)
}


# ---------------------------------------------


# Plotting the visualizations
plot_confusion_matrix("Naïve Bayes - Confusion Matrix",
                      "nb",
                      nb_predictions)
plot_confusion_matrix("Logistic Regression - Confusion Matrix",
                      "lr",
                      lr_predictions)
plot_confusion_matrix("Neural Network - Confusion Matrix",
                      "nnet",
                      nnet_predictions)


# ---------------------------------------------
