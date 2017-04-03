####################################
############ STATISTICS ############
####################################
# Terminologies
# Dispersion - SD, sample variance, coefficients, range
# Variance and SD - spread, center
# Categorial variables - table, proportions, percentage using round()
# Boxplot - IQR, quantile, percentile
# Outliers - summary, IQR
# Central tendency - mean, mode, median
# Histogram - skewed, unimodal, bimodal
# Scatter-plot - regression, scatter-plot matrix, bivariate
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

range(faithful$eruptions) # span between min and max
diff(range(faithful$eruptions)) # find the difference



###### Variance and Standard Deviation #####
# Spread - The data range from about 20 to about 80, so the approximate range equals 80 – 20 = 60
# Center - 
# Variance - larger numbers indicate that the data are spread more widely around the mean
# Standard Deviation - how much each value differs from the mean

var(faithful$eruptions)
sd(faithful$eruptions)



###### CATEGORIAL VARIABLES ######
# Typically examined using tables rather than summary
# A table for a single categorial variable known as one-way table
table(usedcars$year)
prop.table(table(usedcars$year)) # find proporitons
round(prop.table(table(usedcars$color)) * 100, digits = 1)



######### BOX-PLOT #########
# Useful for comparing large sets of data
# Five number summary
# Inter-Quartile Range - IQR(x)

pulse.rates <- c(62, 64, 68, 70, 70, 74, 74, 76, 76, 78, 78, 80)

quantile(pulse.rates)
quantile(pulse.rates, probs = c(0.01, 0.99)) # percentiles
quantile(pulse.rates, seq(from = 0, to = 1, by = 0.20))

IQR(pulse.rates)
# Q1 = 69.5
# Q3 = 76.5
# IQR - 7

boxplot(
  pulse.rates,
  names = c("Pulse"),
  xlab = "",
  ylab = "",
  main = "Pulse Rates"
)

## Commenting box plot
# What the lines indicate
# Values for each line
# Min and max from whiskers
# Comment on the outliers
# high end outlier indicates mean is greater than median



######### OUTLIERS #########
# Outliers - observations that fall outside the overall pattern
# Outliers can arise because of a measurement or recording error
# or because of equipment failure during an experiment

q1 <- quantile(pulse.rates)[2]
q3 <- quantile(pulse.rates)[4]
lower.limit <- q1 - 1.5 * IQR(pulse.rates)
upper.limit <- q3 + 1.5 * IQR(pulse.rates)



######### CENTRAL TENDENCY #########
# Measures of location indicate where on the number
# line the data are to be found.
# Mode = most occured values (mainly used for categorial data)
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
# Histogram and density plot for a single numerical data vis
# visualising numeric variables
# Divides the variables values into a predefined number of portions or bins
# Unimodal (normal) - single peaked distributions
# Bimodal - double peaked distributions
# Uniform distribution - values are equally likely to occur
# Right skewed - the right tail (larger values) is much longer than the left tail (small values)
# Left skewed -  the left tail (smaller values) is much longer than the right tail (larger values).

hist(faithful$waiting,
     main = "histogram of old faithful geyser",
     xlab = "waiting", 
     breaks = 12, 
     ylim = c(0, 70))

# # commenting histogram
# number of bins = 12
# span interval = 5
# tallest bar = 80 to 85
# values = x by y 
# skew - bimodal


######### SCATTER PLOT #########
# Displays the relationship between two continuous numeric variables
# Early stage of analysis
# y depends on the x (response variable ~ dependent variable)
## e.g. price of a car depends on the mileage
### therefore, y = price, x = mileage
# Determine linear regression
## Strength of a linear regression measured by correlation
# May show outliers
# Scatter plot matrix

plot(x = faithful$eruptions, 
     y = faithful$waiting, 
     xlab = "eruptions",
     ylab = "waiting",
     main = "Old faithful geyser")

## Commenting scatter-plot
# Examine how values of the y axis variable change 
# as the values on the x axis increases
# Find outliers
# Explain the what the dots indicate
# What type of relationship associated with the data? 
## positive = sloping upwards e.g. / 
## negative = sloping downwards e.g. \
## flat or random dots scattering =  no association




######### PIE CHART #########
# Hard to compare two datasets
# Best for 3 to 7 categories
# Total must be specified

pie(cars.data$City.MPG, labels = cars.data$Make.and.Model)
