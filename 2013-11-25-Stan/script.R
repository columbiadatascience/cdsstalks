library(rstan)
source('eight_schools.data.R')
data <- list(J=J, sigma=sigma, tau=tau, y=y)


## Model 0:
dev.off()
model0 <- stan(file='eight_schools_model0.stan',
               data=data)
model0

plot(model0)
traceplot(model0, pars='theta')
theta_0 <- extract(model0, inc_warmup=FALSE, pars='theta')$theta

range(theta_0)
mean(theta_0)

hist(theta_0)


## No pooling:
no_pooling <- stan(file='eight_schools_no_pooling.stan',
                   data=data)
no_pooling

plot(no_pooling)
traceplot(no_pooling, pars='theta')
theta_no <- extract(no_pooling, inc_warmup=FALSE, pars='theta')$theta

xlim <- range(theta_no)
par(mfrow=c(2,4))
for (j in 1:J) {
  hist(theta_no[,j], xlim=xlim, main=LETTERS[j])
}


## complete pooling:
complete_pooling <- stan(file='eight_schools_complete_pooling.stan',
                         data=data)
complete_pooling


plot(complete_pooling)
traceplot(complete_pooling, pars='mu')
mu_complete <- extract(complete_pooling, inc_warmup=FALSE, pars='mu')$mu

hist(mu_complete)



## partial pooling:
dev.off()
partial_pooling <- stan(file='eight_schools_partial_pooling.stan',
                        data=data)
partial_pooling


plot(partial_pooling)
traceplot(partial_pooling, pars='mu')
traceplot(partial_pooling, pars='theta')
mu_partial <- extract(partial_pooling, inc_warmup=FALSE, pars='mu')$mu
theta_partial <- extract(partial_pooling, inc_warmup=FALSE, pars='theta')$theta


xlim <- range(theta_partial)
par(mfrow=c(2,4))
for (j in 1:J) {
  hist(theta_partial[,j], xlim=xlim, main=LETTERS[j])
}




## full hierarchical model
eight_schools <- stan(file='eight_schools_hier.stan',
                      data=data)
eight_schools

plot(eight_schools)
traceplot(eight_schools, pars=c('theta'))
traceplot(eight_schools, pars=c('mu','tau'))
mu_hier <- extract(eight_schools, inc_warmup=FALSE, pars='mu')$mu
tau_hier <- extract(eight_schools, inc_warmup=FALSE, pars='tau')$tau
theta_hier <- extract(eight_schools, inc_warmup=FALSE, pars='theta')$theta

hist(mu_hier)
hist(tau_hier)

xlim <- range(theta_hier)
par(mfrow=c(2,4))
for (j in 1:J) {
  hist(theta_hier[,j], xlim=xlim, main=LETTERS[j])
}
