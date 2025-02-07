# ---------------------------------------------


# Importing the libraries
library(ggplot2)

# Loading the models
load("./src/classification/preprocessing.rdata")
load("./models/classification/lr.rdata")
load("./models/classification/nb.rdata")
load("./models/classification/nnet.rdata")


# ---------------------------------------------


plot_confusion_matrix <- function(title, model_name, model_predictions) {
  # Strategy: Confusion Matrix
  confusion_matrix      <- table(Actual = test$type,
                                 Predicted = model_predictions)
  hm                    <- as.data.frame(as.table(confusion_matrix))
  print(ggplot(
    hm,
    aes(x = Predicted, y = Actual, fill = Freq)
  ) +
    ggtitle(title) +
    geom_tile() +
    theme_bw() +
    coord_equal() +
    scale_fill_distiller(palette = "Blues", direction = 1) +
    guides(fill = FALSE) +
    geom_text(aes(label = Freq), size = 10) +
    theme(
      plot.title = element_text(size = 24, margin = margin(t = 20, b = 32)),
      axis.text.x = element_text(size = 16),
      axis.text.y = element_text(size = 16),
      axis.title.x = element_text(size = 20, margin = margin(t = 20, b = 20)),
      axis.title.y = element_text(size = 20, margin = margin(r = 20))
    ))

  # Exporting the visualization
  filename <- paste0("./docs/plots/classification/",
                     model_name,
                     "-confusion-matrix.png")
  ggsave(filename,
         device = "png",
         width = 10,
         height = 8,
         dpi = 300)
}


# ---------------------------------------------


# Plotting the visualizations
plot_confusion_matrix("Logistic Regression Performance", "lr", lr_predictions)
plot_confusion_matrix("Naïve Bayes Performance", "nb", nb_predictions)
plot_confusion_matrix("Neural Network Performance", "nnet", nnet_predictions)


# ---------------------------------------------
