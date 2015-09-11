
# http://datascienceplus.com/normality-tests-for-continuous-data/
install.packages("nortest")

library(nortest)

# random normal distributed data
x <- rnorm(100, 10, 1)

# random weibull distributed data
y <- rweibull(100, 1, 5)


# ANDERSON-DARLING NORMALITY TEST
# Null Hypothesis:  The data are normally distributed
# Alternative Hypohtesis:  The data are not normally distributed

ad.test(x)  # the normally distributed x dataset has p-value greater than 0.05

ad.test(y)  # the weibull distributed y dataset has p-value less than 0.05
# Note:  the anderson-darling test is susceptible to extreme values.  In these cases, try Shapiro-Wilk Test

# SHAPIRO-WILK NORMALITY TEST

shapiro.test(x)
shapiro.test(y)

# NORMAL PROBABILITY / QQ PLOT
qqnorm(x)
qqline(x, col = "red")  # the normally distributed data fall on the line

qqnorm(y)
qqline(y, col = "blue") # the non-normal data display significant curvature






