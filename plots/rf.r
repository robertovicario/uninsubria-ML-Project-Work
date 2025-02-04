# ---------------------------------------------


# Importing the libraries
library(ggplot2)

# Loading the model
load("./src/regression/preprocessing.rdata")
load("./models/regression/rf.data")


# ---------------------------------------------


# Plotting the visualizations
# Strategy: Residual vs Fitted



# ---------------------------------------------


# Exporting the visualizations
ggsave("./docs/plots/nnet/confusion-matrix.png",
       plot = confusion_matrix_plot,
       device = "png",
       width = 10,
       height = 8,
       dpi = 300)

#ggsave("./docs/plots/nnet/roc-auc.png",
#       plot = roc_plot,
#       device = "png",
#       width = 10,
#       height = 8,
#       dpi = 300)


# ---------------------------------------------
