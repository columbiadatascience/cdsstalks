data {
  int<lower=0> J;          // # schools
  real y[J];               // estimated treatment effect
  real<lower=0> sigma[J];  // std err of effect 
}
parameters {
  real theta[J];           // school effect
}
model {
  y ~ normal(theta, sigma);
}
