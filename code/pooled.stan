// Pooled model.

data {
  int<lower=0> N;
  matrix[N,10] d;
  
  real pmualpha;
  real psalpha;
  vector[9] pmubetas;
  vector[9] psbetas;
  real pssigma;
}

parameters {
  real alpha;
  vector[9] betas;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu += alpha;
  for (i in 1:9)
    mu += betas[i]*d[,i+1];
}

model {
  // priors
  alpha ~ normal(pmualpha, psalpha);
  betas ~ normal(pmubetas, psbetas);
  sigma ~ normal(0, pssigma);
  
  // likelihood
  d[,1] ~ normal(mu, sigma);
}
