
library(lpSolve)
library(lpSolveAPI)

library(ggplot2)
library(reshape)
library(gridExtra)

# Using lpSolveAPI to solve the following:

# A trading company is looking for a way to maximize profit per transportation of their goods. 
# The company has a train available with 3 wagons. When stocking the wagons they can choose 
# between 4 types of cargo, each with its own specifications. How much of each cargo type 
# should be loaded on which wagon in order to maximize profit?

# The following constraints that needed to be taken into consideration:
# Weight capacity per train wagon
# Volume capacity per train wagon
# Limited availability per cargo type

train<-data.frame(wagon=c('w1','w2','w3'), 
                  weightcapacity=c(10,8,12), 
                  spacecapacity=c(5000,4000,8000))

cargo<-data.frame(type=c('c1','c2','c3','c4'), 
                  available=c(18,10,5,20), 
                  volume=c(400,300,200,500),
                  profit=c(2000,2500,5000,3500))



# Create an LP model with 10 constraints and 12 decision variables
# There are two constraints per train wagon (weight capacity and volume capacity), 
# and one constraint per cargo type (limited availability)
# There are 12 decision variables:  3 train wagons * 4 cargo types
lpmodel<-make.lp(2 * nrow(train) + nrow(cargo), 12)


column <- 0
row <- 0

#build the model column per column
for(wg in train$wagon){
  row <- row + 1
  for(type in seq(1,NROW(cargo$type))){
    column <- column + 1
    
    #this takes the arguments 'column','values' & 'indices' (as in where these values should be placed in the column)
    set.column(lpmodel,column,c(1, cargo[type,'volume'],1), indices=c(row,nrow(train)+row, nrow(train)*2+type))
  }
}

#set rhs weight constraints
set.constr.value(lpmodel, rhs=train$weightcapacity, constraints=seq(1,nrow(train)))

#set rhs volume constraints
set.constr.value(lpmodel, rhs=train$spacecapacity, constraints=seq(nrow(train)+1,nrow(train)*2))

#set rhs volume constraints
set.constr.value(lpmodel, rhs=cargo$available, constraints=seq(nrow(train)*2+1,nrow(train)*2+nrow(cargo)))


#set objective coefficients
set.objfn(lpmodel, rep(cargo$profit,nrow(train)))

#set objective direction
lp.control(lpmodel,sense='max')

#I in order to be able to visually check the model, I find it useful to write the model to a text file
write.lp(lpmodel,'~model.lp',type='lp')

#solve the model, if this return 0 an optimal solution is found
solve(lpmodel)

#this return the proposed solution
get.objective(lpmodel)


# get the variables
get.variables(lpmodel)

# get the constraints
get.constraints(lpmodel)


