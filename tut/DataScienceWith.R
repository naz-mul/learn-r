# ETL
# Extract, Transform and Load
# Import, Clean, Transform, Export


##########################
##### IMPORTING DATA #####
##########################

# File based, web based, database, statisical etc.



##########################
##### CLEANING DATA ######
##########################

# Most raw data are not suitable for using

# Process of cleaning data includes
## Reshaping data,
## renaming columns,
## convert data types,
## ensure proper encoding,
## ensure internal consistency,
## handle errors and outliers

# Libraries to use for cleaning
# base, tidyr, reshape2, stringr, lubridate, validate



##########################
#### TRANSFORING DATA ####
##########################

## Select columns, filter rows, groups rows, order rows, merge tables

# Librarie to use for transforming data
# base, plyr, dplyr, data.table, sqldf



##########################
##### EXPORTING DATA #####
##########################

# file based, web based, databases, statistical etc.

# USING DPLYR
# Tools include: select, filter, mutate, summarise, arrange
# Designed to work with data frame, data tables and data bases
# A set of grammar and verbs for data manipulation


#############################
##### WORKING WITH DATA #####
#############################

package.install.func <- function(x) {
  for (i in x) {
    #  require returns TRUE invisibly if it was able to load package
    if (!require(i , character.only = TRUE)) {
      #  If package was not able to be loaded then re-install
      install.packages(i , dependencies = TRUE)
      #  Load package after installing
      require(i , character.only = TRUE)
    }
  }
}

setwd("~/Desktop/learn-r/tut")

# Import the data
cars <- read.table(
  file = "Cars.txt",
  header = TRUE,
  sep = "\t",
  quote = "\""
)

# Peek at the data
head(cars)

# Install and load package
package.install.func(c('dplyr'))
library(dplyr)

# Select a subset of the data - select
temp <- select(.data = cars, Transmission, Cylinders, Fuel.Economy)
# Inspect
head(temp)

# Filter a subset of rows - filter
temp <- filter(.data = temp, Transmission == 'Automatic')
# Inspect
head(temp)

# Compute a new column Consumption - mutate
# Convert mpg to km/l
temp <- mutate(.data = temp, Consumption = Fuel.Economy * 0.425)
# Inspect
head(temp)

# Group by column - group_by
# Group rows of data by number of engine cylinders
temp <- group_by(.data = temp, Cylinders)
# Inspect
head(temp)

# Aggregate based on groups - summarize
# Summarise values contained in each group
# Avg.Consumption
temp <- summarise(.data = temp, Avg.Consumption = mean(Consumption))
# Inspect
head(temp)

# Arrange the rows in descending order - arrange
# of Avg.Consumption
temp <- arrange(.data = temp, desc(Avg.Consumption))
# Inspect
head(temp)

# Convert to data frame using as.data.frame
# to a new variable effieciency variable
efficiency <- as.data.frame(temp)

# Chain methods together
(
  efficiency <- cars %>%
    select(Fuel.Economy, Cylinders, Transmission) %>%
    filter(Transmission == 'Automatic') %>%
    mutate(Consumption = Fuel.Economy * 0.425) %>%
    group_by(Cylinders) %>%
    summarise(Avg.Consumption = mean(Consumption)) %>%
    arrange(desc(Avg.Consumption)) %>%
    as.data.frame()
)

# Export to csv
write.csv(x = efficiency,
          file = 'fuel-efficiency.csv',
          row.names = FALSE)
