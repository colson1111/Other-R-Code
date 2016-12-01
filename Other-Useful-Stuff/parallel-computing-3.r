library(foreach)
library(doParallel)
library(parallel)

# detect number of cores
num_cores = max(parallel::detectCores() - 1, 1)

#Register Parallel Globally
doParallel::registerDoParallel(cores = num_cores)

# Generate fake data
tree.df <- data.frame(species = rep(c(1:100), each = 100000), girth = runif(100000, 7, 40))
tree.df$volume <- tree.df$species / 10 + 5 * tree.df$girth + rnorm(100000, 0, 3)

# Extract species ID to iterate over
species <- unique(tree.df$species)

# run foreach with parallelization - runs linear model for each of 100 species'
start <- Sys.time()
fits <- foreach(i = species, .combine = rbind) %dopar% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(c(i, fit$coefficients))
}
end <- Sys.time()
time <- end - start

#Stop Parallel Execution (Acquisition parallels the forest rather than type)
doParallel::stopImplicitCluster()

# run foreach without parallelization
start <- Sys.time()
fits <- foreach(i = species, .combine = rbind) %do% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(c(i, fit$coefficients))
}
end <- Sys.time()
time <- end - start
