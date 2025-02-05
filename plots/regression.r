# ---------------------------------------------


# Importing the libraries
library(ggplot2)

# Loading the model
load("./src/regression/preprocessing.rdata")
load("./models/regression/enet.rdata")
load("./models/regression/ols.rdata")
load("./models/regression/rf.rdata")


# ---------------------------------------------


plot_scatterplot <- function(title, model_name, model_predictions) {
  # Strategy: Scatterplot
  print(ggplot(data.frame(Actual = test$MED.VALUE,
                          Predicted = model_predictions),
               aes(x = Actual, y = Predicted)) +
          ggtitle(title) +
          geom_point() +
          geom_abline(intercept = 0, slope = 1, color = "red") +
          labs(title = title, x = "Actual", y = "Predicted") +
          theme_bw())

  # Exporting the visualization
  filename <- paste0("./docs/plots/regression/",
                     model_name,
                     "-scatterplot.png")
  ggsave(filename,
         device = "png",
         width = 10,
         height = 6,
         dpi = 300)
}


# ---------------------------------------------


# Plotting the visualizations
plot_scatterplot("Elastic Net Performance", "enet", enet_predictions)
plot_scatterplot("OLS Performance", "ols", ols_predictions)
plot_scatterplot("Random Forest Performance", "rf", rf_predictions)


# ---------------------------------------------
