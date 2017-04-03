########################################
############ EXPLORING DATA ############
########################################
setwd("~/Desktop/learn-r/labs/explore")

# Load data
usedcars <- read.csv("usedcars.csv", stringsAsFactors = F)

# Structure of the data
str(usedcars)
sapply(usedcars$color, class)

# Explore numeric variables
summary(usedcars$year) # single variable
summary(usedcars[c("price", "mileage")]) # multiple variable


range(usedcars$price)
diff(range(usedcars$price))

IQR(usedcars$price)
quantile(usedcars$price)
quantile(usedcars$price, probs = c(0.01, 0.99))
quantile(usedcars$price, seq(from = 0, to = 1, by = 0.20))

summary(usedcars$price)

boxplot(usedcars$price, main = "Boxplot of Used Car Prices", ylab = "Price $")
boxplot(usedcars$mileage, main = "Boxplot of Used Car Mileage", ylab = "Odometer (mi.)")

hist(usedcars$price, main = "Histogram of Used Car Prices", xlab = "Price ($)")
hist(usedcars$mileage, main = "Histogram of Used Car Mileage", xlab = "Odometer (mi.)")

var(usedcars$price)
mean(usedcars$price)
sd(usedcars$price)

var(usedcars$mileage)
sd(usedcars$mileage)


table(usedcars$year)
table(usedcars$model)
table(usedcars$color)

model_table <- table(usedcars$model)
prop.table(model_table)

color_table <- table(usedcars$color)
color_pct <- prop.table(color_table) * 100
round(color_pct, digits = 1)
