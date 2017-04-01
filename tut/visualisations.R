##############################
####### VISUALISATIONS #######
##############################

# Base Graphics System
# Base plotting:
## barplot
# Lattice based:
## barchart
# ggplot2 based

# Frequency barchart for a single categorical data vis
# Histogram and density plot for a single numerical data vis
# Scatter plot to visualise two numeric variables
# Faceted data vis for three or more variables at the same time
# Scatter-plot matrix to view the relationship between many variables at once

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

cars <- read.table("Cars.txt", sep = "\t", header = T)

# Install and load ggplot
package.install.func(c('ggplot2'))
library(ggplot2)

# Create bar chart
(
  ggplot(data = cars, aes(x = Transmission)) +
    geom_bar() +
    ggtitle('Count of Cars for Transmission Type') +
    xlab('Transmission Type') +
    ylab('Count of Cars')
)

# Create histogram
(
  ggplot(data = cars, aes(x = Fuel.Economy)) +
    geom_histogram(bins = 10) +
    ggtitle('Distribution of Fuel Economy') +
    xlab('Fuel Economy (mpg)') +
    ylab('Count of Cars')
)

# Create density plot
(
  ggplot(data = cars, aes(x = Fuel.Economy)) +
    geom_density() +
    ggtitle('Distribution of Fuel Economy') +
    xlab('Fuel Economy (mpg)') +
    ylab('Density')
)

# Create scatter plot
(
  ggplot(data = cars, aes(x = Cylinders, y = Fuel.Economy)) +
    geom_point() +
    ggtitle('Fuel Economy by Cylinders') +
    xlab('Number of Cylinders') +
    ylab('Fuel Economy (mpg)')
)
