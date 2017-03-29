setwd("~/Desktop/learn-r/ca/revision2/")

##########################
######## QUESTION 1 ######
##########################

# 1. Load the datafile cardiology.csv from lab folder into R
df <- read.csv("cardiology.csv")

# 2. Write the code to View data set in R
View(df)

# 3. Present patient age data in a well-labelled and presented histogram
hist(
  x = df$age,
  col = "green",
  xlab = "Patients age",
  ylab = "# of Patients",
  main = "Age vs Patients"
)

# 4. Calc Minimum, Maximum, 1st Quartile, Median, Mean, 3rd Quartile, Standard Deviation
# for the age column for each of the 2 class (sick and healthy)
df_healthy <- subset(df, df$class == "Healthy")
df_sick <- subset(df, df$class == "Sick")

summary(df_healthy$age)
summary(df_sick$age)

sd(df_healthy$age)
sd(df_sick$age)

# # Finding mode
install.packages("modeest")
library(modeest)

mfv(df_healthy$age, method = "mfv")
mfv(df_sick$age, method = "mfv")


# 5. Draw a boxplot for the sick and healthy patients by age
boxplot(
  df_healthy$age,
  df_sick$age,
  names = c("Healthy", "Sick"),
  xlab = "Type of patients",
  ylab = "Patients Age",
  main = "Patients vs Patients age"
)

# 6. Using the outputs from the previous questions make a short comment on the data and any links
# between age and health
# # Ans.
# There are 303 observations and 14 variables
# 165 observations are healthy
# 138 observations are sick
# 6 Quantitative variables
# 8 Qualitative/Categorial variables
# Old people are more unhealthy
# Most healthy people are middle aged people
# Larger IQR indicated greater age spread of patients (variance)


# 7. We need to determine if there is a link between scatter graph of he age and blood
# # a. Produce a well labelled and presented scatter graph of the age and blood pressure
x <- df$age
y <- df$blood.pressure
relation <- lm(y ~ x, data = df)
plot(x, y, abline(relation, col = "red"))

# Alternative solution
library(ggplot2)
(
  ggplot(data = df, aes(x, y))
  + geom_smooth()
  + geom_point()
  + xlab("Age")
  + ylab("Blood Pressure") 
  + ggtitle("Age vs Blood Pressure")
)

# # b. Make a comment on whether you think there is a strong correlation
# between age and blood pressure for this group of patients. Use the regression plot
# and data to back up your statement



##########################
######## QUESTION 2 ######
##########################
# 1
class(df$age)
kc <- kmeans(df[, 1:2], centers = 2)
