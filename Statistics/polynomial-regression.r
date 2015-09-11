#  Fitting Polynomial Regression in R

# http://datascienceplus.com/normality-tests-for-continuous-data/

set.seed(802)

q <- seq(from = 0, to = 20, by = 0.1)
y <- 500 + .4 * (q - 10) ^ 3

noise <- rnorm(length(q), mean = 10, sd = 80)
noisy.y <- y + noise

plot(q, noisy.y, col = "deepskyblue", xlab = "q", main = "Observed Data")
lines(q, y, col = "firebrick1", lwd = 3)

# Build Model
model <- lm(noisy.y ~ poly(q, 3))   # produces orthogonal polynomials
model2 <- lm(noisy.y ~ q + I(q^2) + I(q^3))   # I(q^2) and I(q^3) are correlated, so it's better to use the other method

# Summary of Model
summary(model)

# Confidence Intervals of Model Parameters
confint(model, level = 0.95)  # If interval contains 0, that parameter is also not significant in the model

# Plot fitted values versus residuals
plot(fitted(model), residuals(model))  # Model is a good fit if there is no clear pattern


# predicted value
predicted.intervals <- predict(model, data.frame(x = q), interval = "confidence", level = 0.99)
plot(q, noisy.y, col = "deepskyblue", xlab = "q", main = "Observed Data")
lines(q, y, col = "firebrick1", lwd = 3)
lines(q, predicted.intervals[,1], col = "green", lwd = 3)
lines(q, predicted.intervals[,2], col = "black", lwd = 1)
lines(q, predicted.intervals[,3], col = "black", lwd = 1)
legend("bottomright", c("Observ.", "Signal", "Predicted"), 
       col = c("deepskyblue", "firebrick1", "green"), lwd = 3)



