# This script gives an example of running code distributed across processors.

# install.packags("foreach")
# install.packages("doSNOW")
# install.packages("parallel")
# install.packages("randomForest")

library(foreach)
library(doSNOW)
library(parallel)
library(randomForest)

# doSNOW functions
detectCores()
getDoParWorkers()
getDoParName()
cl <- makeCluster(4, type = "SOCK")
registerDoSNOW(cl)

# example random forest
x <- matrix(runif(500), 100)
y <- gl(2, 50)
rf <- foreach(ntree = rep(250, 4), .combine = combine, .packages = "randomForest") %dopar%
  randomForest(x, y, ntree = ntree)

stopCluster(cl)

rf
