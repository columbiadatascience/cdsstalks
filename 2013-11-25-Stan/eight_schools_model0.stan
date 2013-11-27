data {
  int<lower=0> J;          // # schools
  real y[J];               // estimated treatment effect
  real<lower=0> sigma[J];  // std err of effect 
}
parameters {
  real<lower=0, upper=1> theta;
}
model {
}
