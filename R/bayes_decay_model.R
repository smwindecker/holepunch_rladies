bayes_decay_model <- function (data) {
  
  sd_obs <- normal(0, 2, truncation = c(0, Inf))
  int_alpha <- normal(0, 2)
  int_beta <- normal(0, 2)
  
  alpha <- exp(int_alpha)
  beta <- exp(int_beta)
  
  mu <- data$mInit - (data$t / beta)^alpha
  distribution(data$mRem) <- normal(mu, sd_obs)
  
  m <- model(mu)
  draws <- mcmc(m)
  
  mean_pred_mass <- summary(draws)$statistics[,1]
  return(mean_pred_mass)
  
}