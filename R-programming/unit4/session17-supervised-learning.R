pop_mean <- 50
pop_sd <- 5

x <- seq(1:100)
y <- dnorm(x, pop_mean, pop_sd)

plot(x, y, type="l", lwd=2, axes=F, xlab="", ylab="")

sd_axis_bounds = 5
axis_bounds <- seq(
  -sd_axis_bounds * pop_sd + pop_mean,
  sd_axis_bounds * pop_sd + pop_mean,
  by = pop_sd
)

axis(side=1, at = axis_bounds, pos=0)
sd1plus <- pop_mean + pop_sd
sd1minus <- pop_mean - pop_sd

sd2plus <- pop_mean + 2* pop_sd
sd2minus <- pop_mean - 2 *pop_sd

abline(v = pop_mean, col = "red", lwd = 2, lty = 2)  # Add vertical line at mean
abline(v = sd1plus, col = "green", lwd = 2, lty = 2)
abline(v = sd1minus, col = "green", lwd = 2, lty = 2)

abline(v = sd2plus, col = "blue", lwd = 2, lty = 2)
abline(v = sd2minus, col = "blue", lwd = 2, lty = 2)
