#####################################
############ TITANIC LAB ############
#####################################
# Set working directory
# setwd("X:\\students\\t00152975\\Semester 8\\Big Data\\Lab 2")

# import test data
test <-
  read.csv(paste(getwd() , "test.csv", sep = .Platform$file.sep))

# import train data
# by default all strings are imported as factors
# factors are like category
train <-
  read.csv(paste(getwd() , "train.csv", sep = .Platform$file.sep),
           stringsAsFactors = F)

# find how many survived
table(train$Survived)

# find the proportion
prop.table(table(train$Survived))

# create a new survived column with 0 as deafault value
# rep simply means repeats something by n number of times, 418 in this case
test$Survived <- rep(0, 418)

# extract columns
submit <-
  data.frame(PassengerId = test$PassengerId,
             Survived = test$Survived)

# write the new "submit" vector to a file
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)

# find proportions of survivals
prop.table(table(train$Sex, train$Survived))
# the above is not a clean proportion
# how about find it in first dimesion, set it to 1
prop.table(table(train$Sex, train$Survived), 1)

# set all females as survived
# note the usage of equality (==) operator and square bracket []
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1

# find the age summary of train data frame
summary(train$Age)

# create a child variable
# set all the children as survived
train$Child <- 0
train$Child[train$Age < 18] <- 1

# find number of child survivors
aggregate(Survived ~ Child + Sex, data = train, FUN = sum)

# find the total number of children
aggregate(Survived ~ Child + Sex, data = train, FUN = length)

# find the proportions of children survivors
aggregate(
  Survived ~ Child + Sex,
  data = train,
  FUN = function(x) {
    sum(x) / length(x)
  }
)

# create readable fare prices
train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

# find the aggregate
# women who paid more than $20 are least survivors
aggregate(
  Survived ~ Fare2 + Pclass + Sex,
  data = train,
  FUN = function(x)
  {
    sum(x) / length(x)
  }
)

# new predictions
test$Survived <- 0
test$Survived[test$Sex == 'female'] <- 1
test$Survived[test$Sex == 'female' &
                test$Pclass == 3 & test$Fare >= 20] <- 0




## DECISION TREES




# import rpart library
library(rpart)

# generate decimal quantities
fit <-
  rpart(
    Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked,
    data = train,
    method = "class"
  )

# let's examine the tree
plot(fit)
text(fit)

# the above plot does not provide very informative graphics
# however, I can use external packages to see better graphical output
# let's install a few
install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')

# now, load them
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# let's render the plot a bit nicer
fancyRpartPlot(fit)

# Start predicting
Prediction <- predict(fit, test, type = "class")
submit <-
  data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "myfirstdtree.csv", row.names = FALSE)

# Maxing cp and minsplit values
# Setting minsplit to 1 is not possible
# Can't split a single passenger
fit <- rpart(
  Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare
  + Embarked,
  data = train,
  method = "class",
  control = rpart.control(minsplit = 2, cp = 0)
)
# Plot it
fancyRpartPlot(fit)





## FEATURE ENGINEERING




# set all the test survived values to na
test$Survived <- NA

# row bind train data with test
# both data frames have to have same number of columns
test$Child <- 0
test$Fare2 <- 0
combi <- rbind(train, test)

# split names containing comma or perios
strsplit(combi$Name[1], split = '[,.]')

# get the title of the name
strsplit(combi$Name[1], split = '[,.]')[[1]][2]

# create a function to extract the title
combi$Title <-
  sapply(
    combi$Name,
    FUN = function(x) {
      strsplit(x, split = '[,.]')[[1]][2]
    }
  )

# let's have a look
table(combi$Title)

# strip off spaces from the title
combi$Title <- sub(' ', '', combi$Title)

# combile Mademoiselle and Madame values
combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'

# and more
combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <-
  'Sir'

# and more
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <-
  'Lady'

# changes title values to a factor
# this is needed for decision trees
# titles are in fact categories
combi$Title <- factor(combi$Title)

# combile family size
combi$FamilySize <- combi$SibSp + combi$Parch + 1

# extract the surname
combi$Surname <-
  sapply(
    combi$Name,
    FUN = function(x) {
      strsplit(x, split = '[,.]')[[1]][1]
    }
  )

# append the family size
# we need to combile family size to string
# string operators need strings
combi$FamilyID <-
  paste(as.character(combi$FamilySize), combi$Surname, sep = "")

# separate large families with small
combi$FamilyID[combi$FamilySize <= 2] <- 'Small'

# store family ids to a dataframe
famIDs <- data.frame(table(combi$FamilyID))

# separate family with less then 3 ppl
famIDs <- famIDs[famIDs$Freq <= 2, ]

# overwrite small family with correct values
combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'

# change family id back to factor
combi$FamilyID <- factor(combi$FamilyID)

# lets break teh dataset back
train <- combi[1:891,]
test <- combi[892:1309,]

# create new predictions
fit <-
  rpart(
    Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
    data = train,
    method = "class"
  )

# plot it
fancyRpartPlot(fit)






## RANDOM FORESTS




# bootstrap aggregating aka bagging
# randomised sample of rows
sample(1:10, replace = T)

# view summary of age
summary(combi$Age)

# we are not trying to predict a category anymore
# lets grow another tree
# Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize, data=combi[!is.na(combi$Age),], method="anova")

Agefit <-
  rpart(
    Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize,
    data = combi[!is.na(combi$Age), ],
    method = "anova"
  ) <- predict(Agefit, combi[is.na(combi$Age), ])

# Age, Embarked and Fare both are lacking values in two different ways
summary(combi$Embarked)

# find which passengers have empty embark
which(combi$Embarked == '')

# replace them with values
combi$Embarked[c(62, 830)] = "S"

# encode it as a factor
combi$Embarked <- factor(combi$Embarked)

# find passenger with na fare
summary(combi$Fare)
which(is.na(combi$Fare))

# replace with median fare
combi$Fare[1044] <- median(combi$Fare, na.rm = T)

# copy familyid to a new variable
combi$FamilyID2 <- combi$FamilyID
# convert it from factor to char
combi$FamilyID2 <- as.character(combi$FamilyID2)
# increase the cut-off for small families
combi$FamilyID2[combi$FamilySize <= 3] <- 'Small'
# convert it back to factor
combi$FamilyID2 <- factor(combi$FamilyID2)

# install random forest package
install.packages('randomForest')
# load them
library(randomForest)

# set up random seed
# this allows to produce same results multiple times
# otheriwise, it will give dif results each time
# make sure same seed number is used
set.seed(891)

# lets break the dataset back
train <- combi[1:891,]
test <- combi[892:1309,]

# run the model
fit <-
  randomForest(
    as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID2,
    data = train,
    importance = T,
    ntree = 2000
  )

# find important variables
varImpPlot(fit)

# start predicting
Prediction <- predict(fit, test)
submit <-
  data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit, file = "firstforest.csv", row.names = FALSE)

# install party package
install.packages('party')
# load it
library(party)

# set random forest seed
set.seed(891)

fit <-
  cforest(
    as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
    data = train,
    controls = cforest_unbiased(ntree = 2000, mtry = 3)
  )


Prediction <- predict(fit, test, OOB = TRUE, type = "response")
