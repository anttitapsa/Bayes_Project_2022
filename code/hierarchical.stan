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
  
  real musigma;
  real sigmasigma;
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
  real<lower=0> psalpha;
  vector[5] pmubetas;
  vector<lower=0>[5] psbetas;
}

transformed parameters {
  vector[N1] mu1 = alpha1 + betas1[1]*x1[,1] + betas1[2]*x1[,2] + betas1[3]*x1[,3]
                   + betas1[4]*x1[,4] + betas1[5]*x1[,5];
  vector[N2] mu2 = alpha2 + betas2[1]*x2[,1] + betas2[2]*x2[,2] + betas2[3]*x2[,3]
                   + betas2[4]*x2[,4] + betas2[5]*x2[,5];
  vector[N3] mu3 = alpha3 + betas3[1]*x3[,1] + betas3[2]*x3[,2] + betas3[3]*x3[,3]
                   + betas3[4]*x3[,4] + betas3[5]*x3[,5];
  vector[N4] mu4 = alpha4 + betas4[1]*x4[,1] + betas4[2]*x4[,2] + betas4[3]*x4[,3]
                   + betas4[4]*x4[,4] + betas4[5]*x4[,5];
}

model {
  // hyperpriors
  pmualpha ~ normal(0, musigma);
  psalpha ~ normal(0, sigmasigma);
  for (i in 1:5){
    pmubetas[i] ~ normal(0, musigma);
    psbetas[i] ~ normal(0, sigmasigma); 
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
  sigma ~ normal(0, sigmasigma);
  
  // likelihoods
  y1 ~ normal(mu1, sigma);
  y2 ~ normal(mu2, sigma);
  y3 ~ normal(mu3, sigma);
  y4 ~ normal(mu4, sigma);
}

generated quantities{
  vector[N1] ypred1;
  vector[N2] ypred2;
  vector[N3] ypred3;
  vector[N4] ypred4;
  vector[N1+N2+N3+N4] log_lik;
  
  // Generate predictive distributions for GPA
  for (i in 1:N1)
    ypred1[i] = normal_rng(mu1[i], sigma);
  for (i in 1:N2)
    ypred2[i] = normal_rng(mu2[i], sigma);
  for (i in 1:N3)
    ypred3[i] = normal_rng(mu3[i], sigma);
  for (i in 1:N4)
    ypred4[i] = normal_rng(mu4[i], sigma);
    
  // log likelihoods
  for (i in 1:N1)
    log_lik[i] = normal_lpdf(y1[i] | mu1[i], sigma);
  for (i in 1:N2)
    log_lik[N1+i] = normal_lpdf(y2[i] | mu2[i], sigma);
  for (i in 1:N3)
    log_lik[N1+N2+i] = normal_lpdf(y3[i] | mu3[i], sigma);
  for (i in 1:N4)
    log_lik[N1+N2+N3+i] = normal_lpdf(y4[i] | mu4[i], sigma);
}
