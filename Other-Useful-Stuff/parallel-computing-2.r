library(foreach)
library(doSNOW)
library(parallel)

detectCores()

# create cluster with 8 cores
cl <- makeCluster(8, type = "SOCK")

# register cluster
registerDoSNOW(cl)

# find out how many cores will be used
getDoParWorkers()

# Generate fake data
tree.df <- data.frame(species = rep(c(1:100), each = 100), girth = runif(10000, 7, 40))
tree.df$volume <- tree.df$species / 10 + 5 * tree.df$girth + rnorm(10000, 0, 3)

# Extract species ID to iterate over
species <- unique(tree.df$species)

# run foreach with parallelization
start <- Sys.time()
fits <- foreach(i = species, .combine = rbind) %dopar% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(c(i, fit$coefficients))
}
end <- Sys.time()
time <- end - start
# 0.2158 seconds

# run foreach without parallelization
start2 <- Sys.time()
fits <- foreach(i = species, .combine = rbind) %do% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(c(i, fit$coefficients))
}
end2 <- Sys.time()
time2 <- end2 - start2
# 0.436 seconds

# by parallel processing, time was cut approximately in half

# get all info from the lm object
fullfits <- foreach(i = species) %dopar% {
  sp <- subset(tree.df, subset = species == i)
  fit <- lm(volume ~ girth, data = sp)
  return(fit)
}

attributes(fullfits[[1]])

# close the cluster
stopCluster(cl)
