library(reticulate)
sklearn <- import("sklearn.datasets")
california_housing <- sklearn$fetch_california_housing()
