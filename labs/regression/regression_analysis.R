#############################################
############ REGRESSION ANALYSIS ############
#############################################
# Avoid printing whole data with tbl_df() from dplyr
# Convert variables to standard form witn normVarNames() from rattle
# Check data type for each variable with sapply()
# Scatter-plot matrix
# Strong correlation relationship cor()
# Determine the regression between two relationships
# Set plot screen area par()
# Find straight line formula y = mx + c
# Residuals()
# Draw linear regression line - correalation, points
# Analysis of variance table anova()


# Initialise data source
dsname <- 'iris'
data <- get(dsname)
dim(data)
names(data)

# convenience of table data frame
#  Avoid printing whole data frame
class(data)
library(dplyr)
data <- tbl_df(data)
class(data)
data

# Set colnames to more readable names
# colnames(data) <- c("sepal_length", "sepal_width", "petal_length",
#                     "petal_width", "species")

# Get overall picture
summary(data)

# Review the structure of the dataset
str(data)

# Review - Meta Data Cleansing
# Normalise variable names
# R is case sensitive
# Useful when different upper/lower case conventions are intermixed
names(data)
# converting variables from a dataset to standard form
library(rattle)
names(data) <- normVarNames(names(data))
names(data)

# Review - Data formats
# Check data type of each variables
sapply(data, class)


# Scatter matrix plot
plot(data)

# Linear relationship between petal_length and petal_width
# Plots are grouped - indicates clusters
# Higher correlation value suggests strong relationship
cor(data$petal_length, data$petal_width) # 0.96

# Determine the regression between two relationships
fit <- lm(data$petal_length ~ data$petal_width)
fit

# Set plot screen area
par(mfrow = c(2, 2))
plot(fit) # plot(relation) displays four charts
par(mfrow = c(1, 1)) # change the plot screen to default


# Find straight line formula y = mx + c
petal_length <- data$petal_width * 2.224 + 1.093

# Residuals
# Vary from -1 to +1
# Difference between the observed values and fitted values
# Reducing the standard error on the regression is a good thing
## It means we are closer to the observed data points with our modeled data
residuals(fit)
summary(fit) # find outliers


# Draw linear regression line
x <- data$petal_length
y <- data$petal_width
relation <- lm(y ~ x, data) # lm(response variable ~ variable to be plotted, data)
plot(
  x, y,
  abline(relation, col = "red"),
  xlab = "petal length",
  ylab = "petal width",
  main = "petal length vs petal width"
)
# add points
points(x, y, pch=1:18, col = "red")

cor(x, y) # Strong positive relationship of 0.96

# analysis of variance table
anova(relation)
