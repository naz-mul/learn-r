##########################
####### STATISTICS #######
##########################

# Observations - rows of data
# Variables - columns of data
# Categorical - Qualitative
# Numberical - Quantitative
# Correlation - Strength of relationship

setwd("~/Desktop/learn-r/tut")

# Load data
cars <- read.csv('Cars.csv')
head(cars)

# Create frequency table
table(cars$Transmission)

# Get min value
min(cars$Fuel.Economy)

# Get the max value
max(cars$Fuel.Economy)

# Get the average/median value
median(cars$Fuel.Economy)

# Get the quartiles
quantile(cars$Fuel.Economy)

# Get the standard deviation
sd(cars$Fuel.Economy)

# Get the total value
sum(cars$Fuel.Economy)

# Get the correlation coefficient
cor(x = cars$Cylinders, y = cars$Fuel.Economy)

# Summarise an entire table
summary(cars)
