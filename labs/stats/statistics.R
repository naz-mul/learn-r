####################################
############ STATISTICS ############
####################################
# Terminologies
# Dispersion - SD, sample variance, coefficients, range
# Boxplot - IQR, quantile
# Outliers
# Central tendency - mean, mode, median
# Histogram - skewed, unimodal, bimodal, spread
# Scatter-plot - regression, scatter-plot matrix
# Pie chart

######## TERMINOLOGIES #########
# Population: the complete set of individuals, objects or scores of interest.
# Sample: A subset of the population.
# Variables are the quantities measured in a sample.
# # i.e. Quantitative (Continuous and Discrete) and Categorial (Nominal and Ordinal)
# A Barchart presents the frequencies for a categorical variable


######## DISPERSION #########
# Range (variablity/variation) - range(x)
# sample variance - var(faithful$eruptions) or sd(x)^2
# standard deviation - square root of the variance
# # i.e. sqrt(var(faithful$eruptions)) or sd(faithful$eruptions)
# coefficient of variation (CV) - 
# # i.e. (var(faithful$eruptions)/mean(faithful$eruptions))*100 or coef(x)


######### BOX-PLOT #########
# Useful for comparing large sets of data
# Inter-Quartile Range - IQR(x)
pulse.rates <- c(62, 64, 68, 70, 70, 74, 74, 76, 76, 78, 78, 80)
quantile(pulse.rates)
IQR(pulse.rates)
# Q1 = 69.5
# Q3 = 76.5
# IQR - 7
boxplot(pulse.rates, names = c("Pulse"))



######### OUTLIERS #########
# Outliers - observations that fall outside the overall pattern
# Outliers can arise because of a measurement or recording error 
# or because of equipment failure during an experiment
q1 <- quantile(pulse.rates)[2]
q3 <- quantile(pulse.rates)[4]
lower.limit <- q1 - 1.5*IQR(pulse.rates)
upper.limit <- q3 + 1.5*IQR(pulse.rates)



######### CENTRAL TENDENCY #########
# Measures of location indicate where on the number 
# line the data are to be found. 
# Mode = most occured values
# Mean = the average
# Median = middle value 
# if mean=median=mode then the data are said to be symmetrical
# if the mean is inflated the histogram of the data is right skewed

x <- c(366, 327, 274, 292, 274, 230)
x.ordered <- x[order(x)]
x.ordered

# find mode
library(modeest)
mfv(x, method = "mfv")

# find median
median(x)

# find mean
mean(x)



######### HISTOGRAMS #########
# Unimodal - single peaked distributions
# Bimodal - double peaked distributions
# Uniform distribution
# Right skewed - the right tail (larger values) is much longer than the left tail (small values)
# Left skewed -  the left tail (smaller values) is much longer than the right tail (larger values).
# Spread - The data range from about 20 to about 80, so the approximate range equals 80 – 20 = 60




######### SCATTER PLOT #########
# Displays the relationship between two continuous variables
# Early stage of analysis
# Determine linear regression
# May show outliers
# Scatter plot matrix



######### PIE CHART #########
# Hard to compare two datasets
# Best for 3 to 7 categories
# Total must be specified



