// Pooled model.
// Variables: HSGPA, SATM, SATV, HU, SS
data {
  int<lower=0> N;
  matrix[N,5] x;
  vector[N] y;
}

parameters {
  real alpha;
  vector[5] betas;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu += alpha;
  for (i in 1:5)
    mu += betas[i]*x[,i];
}

model {
  // priors
  alpha ~ normal(0, 100);
  betas ~ normal(0, 100);
  sigma ~ normal(0, 10);
  
  // likelihood
  y ~ normal(mu, sigma);
}
