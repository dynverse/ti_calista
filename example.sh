#!/usr/local/bin/Rscript

# generate dataset with certain seed
set.seed(1)
data <- dyntoy::generate_dataset(
  id = "specific_example/calista",
  num_cells = 300,
  num_features = 101,
  model = "bifurcating",
  normalise = FALSE
)

# add method specific args (if needed)
data$params <- list(
  runs = 3,
  max_iter = 5
)
data$seed <- 1

# write example dataset to file
file <- commandArgs(trailingOnly = TRUE)[[1]]
dynutils::write_h5(data, file)
