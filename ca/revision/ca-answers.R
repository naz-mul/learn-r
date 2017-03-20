# CA 2016

################################
######### Question 1 ###########
################################

# a) What are the individuals in this data set?
# Ans. Cars

# b) For each individual, what variables are given? Which of these variables are
#    categorical and which are quantitative?
# Ans. 6 variables -- Categorial: Make and Model, Vehicle Type, Tranmission Type
#                  -- Quantitative: Number of Cylinders, City MPG, Highway MPG

# c) Present City MPG data in a well-labelled bar graph.

make.and.model <-
  c('BMW 3181', 'BMW 3181', 'Buick Century', 'Chevrolet Blazer')
vehicle.type <-
  c('Subcompact', 'Subcompact', 'Midsize', 'Four-wheel drive')
trans.type <- c('Automatic', 'Maual', 'Automatic', 'Automatic')
num.cyl <- c(4, 4, 6, 6)
city.mpg <- c(22, 23, 20, 16)
high.mpg <- c(31, 32, 29, 30)

cars.data <- data.frame(
  'Make and Model' = make.and.model,
  'Vehicle Type' = vehicle.type,
  'Transmission Type' = trans.type,
  'Number of Cylinders' = num.cyl,
  'City MPG' = city.mpg,
  'Highway MPG' = high.mpg
)

barplot(
  cars.data$City.MPG,
  beside = TRUE,
  col = c("lightblue", "mistyrose",
          "lightcyan", "lavender"),
  legend = cars.data$Make.and.Model,
  ylim = c(0, 30),
  main = "Fuel Economy of 1998 cars",
  font.main = 4,
  sub = "Question 1 - Section C",
  col.sub = "gray20",
  ylab = "City MPG",
  cex.names = 1.5
)

# d) Would it also be correct to use a pie chart to display these data? If so,
#    construct the pie chart. If not, explain why not.
# Ans. Although, pie chart can be created, the law of pie chart is the percentage
#      must add up to 100%

# calculate percentage
cars.data$City.MPG / sum(cars.data$City.MPG)
sum(cars.data$City.MPG / sum(cars.data$City.MPG))

# or use this to find percentage
prop.table(cars.data$City.MPG)

# plot a pie chart
pie(cars.data$City.MPG, labels = cars.data$Make.and.Model)



################################
######### Question 2 ###########
################################

# a) Load the file tyres.csv into R
tyres <- read.csv('tyres.csv')


# b) Produce a well labelled and presented scatter graph of the data, displaying
#    the trend line
plot(tyres$Distance...kms., 
     tyres$Tread..mm.,
     xlab = 'Distance (km)',
     ylab = 'Tread (mm)',
     main = 'Tyre Change Estimation',
     sub = 'Queston 2 - Section b')

library(ggplot2)
(ggplot(tyres, aes(tyres$Distance...kms., tyres$Tread..mm.)) 
  + geom_point() 
  + geom_smooth() 
  + xlab('Distance (km)') 
  + ylab('Tread (mm)')
  + ggtitle('Estimated Tyre Tread vs Distance travelled'))


# c) If the tyre travels 16 thousand km’s what 
#   would the forecasted tread be?
library(forecast)





# d) Governmentregulationsstatethatminimumtreadis4mm.Whatisthe
#    forecasted maximum distance you could travel on one set of tyres?





################################
######### Question 3 ###########
################################

# a) Load the faithful data set that is built in to R.
faithful.data <- faithful


### b) Plot the data and then briefly describe the dataset
plot(x = faithful.data, main = 'Old Faithful Geyser', sub = 'Yellowstone National Club, WY, USA')
# Ans. Describe??


# c) Summarise the data and calculate the
# Minimum value : 1.600 and 43.0
# 1st Quartile:   2.163 and 58.0
# Median:         4.000 and 76.0
# 3rd Quartile:   4.454 and 82.0
# Maximum Value:  5.100 and 96.0
summary(faithful.data)

#### alternative solution ####

# find min values
min(faithful.data$eruptions)
min(faithful.data$waiting)

# find 1st and 3rd quartile values
quantile(faithful.data$eruptions)
quantile(faithful.data$waiting)

# find median values
median(faithful.data$eruptions)
median(faithful.data$waiting)

# find max values
max(faithful.data$eruptions)
max(faithful.data$waiting)


# d) Calculate the standard deviations of the waiting time between eruptions. Can
#    we assume a constant spread across the groups make a brief note.
sd(faithful.data$waiting)




################################
######### Question 4 ###########
################################

# a) Import data from the countries.csv file
countries <- read.csv('countries.csv')


# b) Apply k-means to the data, and store the clustering result (ensure you set the
#    correct number of clusters)


# c) Print the components of for the k-Means operation(print)


# d) Plot the clusters and their centres for the first two dimensions: per capita
#    income and literacy.




# e) Plot the clusters for all dimensions displayed in a single graph (similar to
#    below)



# f) Briefly discuss the clusters that were generated 
#   and the countries that are in each cluster are they 
#   homogeneous did the clustering algorithm work?


