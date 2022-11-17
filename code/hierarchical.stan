// Hierarchical model.

data {
  int<lower=0> N1;
  int<lower=0> N2;
  matrix[N1,10] d1;
  matrix[N2,10] d2;
  
  real hypermu;
  real hypers;
  real pssigma;
}

parameters {
  // parameters
  real alpha1;
  real alpha2;
  vector[9] betas1;
  vector[9] betas2;
  real<lower=0> sigma;
  
  // hyperparameters
  real pmualpha;
  real psalpha;
  vector[9] pmubetas;
  vector[9] psbetas;
}

transformed parameters {
  vector[N1] mu1;
  vector[N2] mu2;
  mu1 += alpha1;
  for (i in 1:9)
    mu1 += betas1[i]*d1[,i+1];
  mu2 += alpha2;
  for (i in 1:9)
    mu2 += betas2[i]*d2[,i+1];
}

model {
  // hyperpriors
  pmualpha ~ normal(hypermu, hypers);
  psalpha ~ normal(hypermu, hypers);
  pmubetas ~ normal(hypermu, hypers); // The parameters here should be vectors so that each slope beta has its own distribution!
  psbetas ~ normal(hypermu, hypers); // Here as well
  
  // priors
  alpha1 ~ normal(pmualpha, psalpha);
  alpha2 ~ normal(pmualpha, psalpha);
  betas1 ~ normal(pmubetas, psbetas);
  betas2 ~ normal(pmubetas, psbetas);
  sigma ~ normal(0, pssigma);
  
  // likelihoods
  d1[,1] ~ normal(mu1, sigma);
  d2[,1] ~ normal(mu2, sigma);
}
