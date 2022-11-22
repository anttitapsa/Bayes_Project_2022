// Hierarchical model.
// Betas in following order: HSGPA, SATM, SATV, HU, SS
// Alpha: intercept
data {
  int<lower=0> N1;
  int<lower=0> N2;
  int<lower=0> N3;
  int<lower=0> N4;
  matrix[N1,5] x1;
  matrix[N2,5] x2;
  matrix[N3,5] x3;
  matrix[N4,5] x4;
  vector[N1] y1;
  vector[N2] y2;
  vector[N3] y3;
  vector[N4] y4;
}

parameters {
  // parameters
  real alpha1;
  real alpha2;
  real alpha3;
  real alpha4;
  vector[5] betas1;
  vector[5] betas2;
  vector[5] betas3;
  vector[5] betas4;
  real<lower=0> sigma;
  
  // hyperparameters
  real pmualpha;
  real psalpha;
  vector[5] pmubetas;
  vector[5] psbetas;
}

transformed parameters {
  vector[N1] mu1;
  vector[N2] mu2;
  vector[N3] mu3;
  vector[N4] mu4;
  
  mu1 += alpha1;
  mu2 += alpha2;
  mu3 += alpha3;
  mu4 += alpha4;
  for (i in 1:5){
    mu1 += betas1[i]*x1[,i];
    mu2 += betas2[i]*x2[,i];
    mu3 += betas3[i]*x3[,i];
    mu4 += betas4[i]*x4[,i];
  }
}

model {
  // hyperpriors
  pmualpha ~ normal(0, 100);
  psalpha ~ normal(0, 10);
  for (i in 1:5){
    pmubetas[i] ~ normal(0, 100); 
    psbetas[i] ~ normal(0, 10); 
  }
  
  // priors
  alpha1 ~ normal(pmualpha, psalpha);
  alpha2 ~ normal(pmualpha, psalpha);
  alpha3 ~ normal(pmualpha, psalpha);
  alpha4 ~ normal(pmualpha, psalpha);
  betas1 ~ normal(pmubetas, psbetas);
  betas2 ~ normal(pmubetas, psbetas);
  betas3 ~ normal(pmubetas, psbetas);
  betas4 ~ normal(pmubetas, psbetas);
  sigma ~ normal(0, 10);
  
  // likelihoods
  y1 ~ normal(mu1, sigma);
  y2 ~ normal(mu2, sigma);
  y3 ~ normal(mu3, sigma);
  y4 ~ normal(mu4, sigma);
}
