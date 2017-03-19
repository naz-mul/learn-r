# Draw Venn Diagram
# https://rstudio-pubs-static.s3.amazonaws.com/13301_6641d73cfac741a59c0a851feb99e98b.html

package.install.func <- function(x){
  for( i in x ){
    #  require returns TRUE invisibly if it was able to load package
    if( ! require( i , character.only = TRUE ) ){
      #  If package was not able to be loaded then re-install
      install.packages( i , dependencies = TRUE )
      #  Load package after installing
      require( i , character.only = TRUE )
    }
  }
}

# install and load packages
package.install.func(c('VennDiagram'))
library(VennDiagram)

# Load the data
titanic.raw <- load('./titanic.raw.rdata')

# Get subset of the data
area1 <- titanic.raw[titanic.raw$Age == 'Child', ]
area2 <- titanic.raw[titanic.raw$Class == '2nd', ]
cross.area <- titanic.raw[titanic.raw$Class == '2nd' & titanic.raw$Age == 'Child', ]

# Create venn diagram
grid.newpage()
draw.pairwise.venn(nrow(area1), nrow(area2), nrow(cross.area), 
                   category = c("Child", "2nd Class"), lty = rep("blank", 2), 
                   fill = c("light blue", "pink"), 
                   alpha = rep(0.5, 2), 
                   cat.pos = c(0, 0), 
                   cat.dist = rep(0.025, 2), 
                   scaled = FALSE)
