
library(lpSolve)

# Using lpSolve to solve the following:

# A calculator company produces a scientific calculator and a graphing calculator. 
# Long-term projections indicate an expected demand of at least 100 scientific and 
# 80 graphing calculators each day. Because of limitations on production capacity, 
# no more than 200 scientific and 170 graphing calculators can be made daily. To 
# satisfy a shipping contract, a total of at least 200 calculators much be shipped each day.

# If each scientific calculator sold results in a $2 loss, but each graphing calculator produces 
# a $5 profit, how many of each type should be made daily to maximize net profits?

# Set up problem: 
# maximize:  -2 x1 + 5 x2 subject to:
#   x1 + x2 >= 200
#   x1 <= 200
#   x1 >= 100
#   x2 <= 170
#   x2 >= 80


f.obj <- c(-2, 5)
f.con <- matrix (c(1, 1, 1, 0, 1, 0, 0, 1, 0,1), nrow = 5, byrow=TRUE)
f.dir <- c(">=", "<=", ">=", "<=", ">=")
f.rhs <- c(200, 200, 100, 170, 80)

# What is the maximum net profit?  $650
lp ("max", f.obj, f.con, f.dir, f.rhs)

# How many of each type of calculator should be made?  100 scientific and 170 graphing
lp ("max", f.obj, f.con, f.dir, f.rhs)$solution
