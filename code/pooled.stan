// Pooled model.
// Variables: HSGPA, SATM, SATV, HU, SS

data {
  int<lower=0> N;
  matrix[N,5] x;
  vector[N] y;
  
  real musigma;
  real sigmasigma;
}

parameters {
  real alpha;
  vector[5] betas;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu = alpha + betas[1]*x[,1] + betas[2]*x[,2] + betas[3]*x[,3]
       + betas[4]*x[,4] + betas[5]*x[,5];
}

model {
  // priors
  alpha ~ normal(0, musigma);
  betas ~ normal(0, musigma);
  sigma ~ normal(0, sigmasigma);
  
  // likelihood
  y ~ normal(mu, sigma);
}

generated quantities {
  vector[N] ypred;
  vector[N] log_lik;
  
  // Generate predictive distributions for GPA
  for (i in 1:N)
    ypred[i] = normal_rng(mu[i], sigma);
  
  // log likelihoods
  for (i in 1:N)
    log_lik[i] = normal_lpdf(y[i] | mu[i], sigma);
}
