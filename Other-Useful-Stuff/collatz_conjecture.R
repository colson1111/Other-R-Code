# Collatz Conjecture:  Starting with any positive integer n, if n is even, divide it
# by 2.  If n is odd, multiply it by 3 and add 1.  Repeat indefinitely.  Conjecture
# states that you will always end up at 1, regardless of the initial number.

collatz <- function(num, steps = 0){
  
  if(num <= 0){
    return(steps)
  } 
  
  while(num != 1){
    if(num %% 2 == 0){
      num <- num / 2
    } else {
      num <- (num * 3) + 1
    }
    steps = steps + 1
  }
  
  return(steps)
}

value = collatz(100)

print(value)
