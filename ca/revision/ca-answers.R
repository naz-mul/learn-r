# CA 2016

## Question 1

# a) What are the individuals in this data set?
# Ans. Cars

# b) For each individual, what variables are given? Which of these variables are
#    categorical and which are quantitative?
# Ans. 6 variables -- Categorial: Make and Model, Vehicle Type, Tranmission Type
#                  -- Quantitative: Number of Cylinders, City MPG, Highway MPG

# c) Present City MPG data in a well-labelled bar graph.
make.and.model <- c('BMW 3181', 'BMW 3181', 'Buick Century', 'Chevrolet Blazer')
vehicle.type <- c('Subcompact', 'Subcompact', 'Midsize', 'Four-wheel drive')
trans.type <- c('Automatic', 'Maual', 'Automatic', 'Automatic')
num.cyl <- c(4, 4, 6, 6)
city.mpg <- c(22, 23, 20, 16)
high.mpg <- c(31, 32, 29, 30)

cars.data <- data.frame('Make and Model' = make.and.model, 
                        'Vehicle Type' = vehicle.type, 
                        'Transmission Type' = trans.type,
                        'Number of Cylinders' = num.cyl, 
                        'City MPG' = city.mpg, 
                        'Highway MPG' = high.mpg)
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
cars.data$City.MPG / sum(cars.data$City.MPG)
sum(cars.data$City.MPG / sum(cars.data$City.MPG))

pie(cars.data$City.MPG, labels = cars.data$Make.and.Model)


tyres <- read.csv('tyres.csv')
countres <- read.csv('countries.csv')
