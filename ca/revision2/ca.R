# CA Tutorial
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
cor(x, y)
# correlation between age and blood pressure is 0.279
# Lower the correlation, lower the relationship between x and y
# i.e. Age vs Blood pressure



##########################
######## QUESTION 2 ######
##########################
# 1. Consider the scenario where patients need to be classfied into two groups: sick and healthy.
#    Apply k-means to the data, and store the clustering result
summary(df)

df_factor <- read.csv("cardiology.csv", stringsAsFactors = TRUE)
str(df_factor)
kc <- kmeans(df_factor, centers = 2)


# 2. Plot the cluster and their centers for the first two dimensions: age and sex
# plot(
#   df_factor[, c("age", "sex")],
#   col = kc$cluster,
#   xlab = "age",
#   ylab = "sex",
#   main = "Age vs Sex Clustering"
# )
# points(kc$centers, pch=19,cex=1.5, col=1:100)



# 3. Make a comment on the clusters formed, are there any meaningful patterns or significant
# differences that you can determine between the clusters




# 4. Create a digaram of you choosing (scatter plot, histogram, box-plot, pie chart etc) that
# supports your answer to the previous question



# 5. Examining the cluster profiles and characterstics what can you deduce about the individuals
# that are in the sick cluster, make a detailed note on what type of patients are typically
# classed as sick



##########################
######## QUESTION 3 ######
##########################

# 1. Create a decision tree that determines if an individual is healthy or sick
library(rpart)
set.seed(300)
dtree <-
  rpart(
    class ~ .,
    data = df_factor,
    method = "class",
    parms = list(split = "information"),
    control = rpart.control(usesurrogate = 0, maxsurrogate = 0)
  )

# 2. View the root noede of the decision tree and note which patients have been
# classified as Sick or Healthy. Make a short note on the data, what is the percentage
# split between sick and healthy in the dataset?
plotcp(dtree)
library(rpart.plot)
prp(
  dtree,
  type = 2,
  extra = 104,
  fallen.leaves = TRUE,
  main = "Healthy vs Sick"
)


# 3. Following this tree from root to leaf, what can you deduce about the individuals
# that are classed as Healthy. List the production rule produced. How accurate is the model?




# 4. Investigate the sex attribute, are male individuals more or less likely to be Healthy?
# Make reference to your tree diagram/outputs and make a comment in your file.
