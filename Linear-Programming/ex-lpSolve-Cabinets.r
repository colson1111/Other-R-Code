
library(lpSolve)

# Using lpSolve to solve the following:

# You need to buy some filing cabinets. You know that Cabinet X costs $10 per unit, 
# requires six square feet of floor space, and holds eight cubic feet of files. 
# Cabinet Y costs $20 per unit, requires eight square feet of floor space, and holds 
# twelve cubic feet of files. You have been given $140 for this purchase, though you 
# don't have to spend that much. The office has room for no more than 72 square feet 
# of cabinets. How many of which model should you buy, in order to maximize storage volume?

# Set up problem: 
# X1 - Number of Cabinet X purchased
# X2 - Number of Cabinet Y purchased

# maximize:  8 x1 + 12 x2 subject to:
#   cost:          10 x1 + 20 x2 <= 140
#   floor space:   6  x1 + 8  x2 <= 72
#   at least 0 x1: 1  x1 + 0  x2 >= 0
#   at least 0 x2: 0  x1 + 1  x2 >= 0


f.obj <- c(8, 12)
f.con <- matrix (c(10, 20, 6, 8, 1, 0, 0, 1), nrow = 4, byrow=TRUE)
f.dir <- c("<=", "<=", ">=", ">=")
f.rhs <- c(140, 72, 0, 0)

# What is the maximum storage volume?  100 square feet of storage volume
lp ("max", f.obj, f.con, f.dir, f.rhs)

# How many of each type of cabinet should you buy?  8 of cabinet X and 3 of cabinet Y
lp ("max", f.obj, f.con, f.dir, f.rhs)$solution
