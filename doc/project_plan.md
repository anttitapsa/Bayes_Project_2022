## Goal
The goal is to predict the GPA of the first-year college students based on the different variables. The prediction is done using two different models: pooled model and hierarchical model. I.e., the goal is to find relation between the GPA and the provided variables.

## Data
**FirstYearGPA** (https://vincentarelbundock.github.io/Rdatasets/doc/Stat2Data/FirstYearGPA.html)

There are 219 observations with following 10 variables:
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
Data of the GPAs of first-year college students. The data can be installed and added to project using following r commands
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
\mu_i &= \alpha + \beta \cdot HSGPA_i + \gamma \cdot SATV_i + \delta \cdot SATM_i + ... \\
\sigma &\sim N(0, \sigma_0) \\
\alpha &\sim N(\mu_{\alpha}, \sigma_{\alpha}) \\
\beta &\sim N(\mu_{\beta}, \sigma_{\beta}) \\
\gamma &\sim N(\mu_{\gamma}, \sigma_{\gamma}) \\
\delta &\sim N(\mu_{\delta}, \sigma_{\delta}) \\
\end{aligned}
$$

### Hierarchical model 

$$
\begin{aligned}
GPA_{ij} &\sim N(\mu_{ij}, \sigma) \\
\mu_{ij} &= \alpha_j + \beta_j \cdot HSGPA_i +  ... \\
\sigma &\sim N(0, \sigma_0) \\
\alpha_j &\sim N(\mu_{\alpha }, \sigma_{\alpha }) \\
\beta_j &\sim N(\mu_{\beta }, \sigma_{\beta }) \\
\mu_{\alpha } &\sim N(0,1) \\
\sigma_{\alpha } &\sim N(0,1) \\
\mu_{\beta } &\sim N(0,1) \\
\sigma_{\beta } &\sim N(0,1) \\
\end{aligned}
$$
