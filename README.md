Project for the Bayesian Data Analysis Course at Aalto University.

Contributors: Antti Huttunen, Amanda Aarnio, Anni Niskanen

## Goal
The goal is to predict the GPA of first-year college students based on the different variables. The prediction is done using two different models: the pooled model and the hierarchical model. I.e., the goal is to find the relation between the GPA and the provided variables.

## Data
**FirstYearGPA** (https://vincentarelbundock.github.io/Rdatasets/doc/Stat2Data/FirstYearGPA.html)

There are 219 observations with the following 10 variables:
```
GPA           First-year college GPA on a 0.0 to 4.0 scale
HSGPA         High school GPA on a 0.0 to 4.0 scale
SATV          Verbal/critical reading SAT score
SATM          Math SAT score
Male          1= male, 0= female
HU            Number of credit hours earned in humanities courses in high school
SS            Number of credit hours earned in social science courses in high school
FirstGen      1= student is the first in her or his family to attend college, 0=otherwise
White         1= white students, 0= others
CollegeBound  1=attended a high school where >=50% students intended to go on to college, 0=otherwise
```
Data of the GPAs of first-year college students. The data can be installed and added to the project using the following r commands
```
install.packages("Stat2Data")
library(Stat2Data)
data("FirstYearGPA")
```

## Models
There are two different models for the linear regression which are implemented using R and cmdstanR.

### Pooled model 

**Mathematical notation**

$$
\begin{aligned}
GPA_i &\sim N(\mu_i, \sigma) \\
\mu_i &= \alpha + \beta_1 \cdot HSGPA_i + \beta_2 \cdot SATV_i + \beta_3 \cdot SATM_i + \beta_4 \cdot HU_i + \beta_5 \cdot SS_i \\
\sigma &\sim N(0, 10) \\
\alpha &\sim N(0, 100) \\
\beta_k &\sim N(0, 100) \\
\end{aligned}
$$

### Hierarchical model 

$$
\begin{aligned}
GPA_{ij} &\sim N(\mu_{ij}, \sigma) \\
\mu_{ij} &= \alpha_j + \beta_{1j} \cdot HSGPA_i + \beta_{2j} \cdot SATV_i + \beta_{3j} \cdot SATM_i + \beta_{4j} \cdot HU_i + \beta_{5j} \cdot SS_i \\
\sigma &\sim N(0, 10) \\
\alpha_j &\sim N(\mu_{\alpha}, \sigma_{\alpha}) \\
\beta_{1j} &\sim N(\mu_{\beta_1}, \sigma_{\beta_1}) \\
\beta_{2j} &\sim N(\mu_{\beta_2}, \sigma_{\beta_2}) \\
\beta_{3j} &\sim N(\mu_{\beta_3}, \sigma_{\beta_3}) \\
\beta_{4j} &\sim N(\mu_{\beta_4}, \sigma_{\beta_4}) \\
\beta_{5j} &\sim N(\mu_{\beta_5}, \sigma_{\beta_5}) \\
\mu_{\alpha} &\sim N(0,100) \\
\sigma_{\alpha} &\sim N(0,10) \\
\mu_{\beta_k} &\sim N(0,100) \\
\sigma_{\beta_k} &\sim N(0,10) \\
\end{aligned}
$$
