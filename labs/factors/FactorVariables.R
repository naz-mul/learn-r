##############################
#####   FACTOR VARIABLES #####
##############################
# Terminologies
# Generate numeric vector
# Generate factor vector
# Generate character (string) vector
# Create unordered factor vector
# Order factors alphabetically
# Adding and dropping levels from factor variables
# Drop a level 
# Combining factor variables into data frame
# Find total number of rows in a dataset
# Visualise using table and bwplot



######## TERMINOLOGIES #########
# Factor variables used in statistical modelling
# Storing string variables as factor is memory efficient
# levels argument determines the categories
# labels argument determines the labels of the categories
# exclude argument defines which levels will be classified as NA

# Generate numeric vector
set.seed(124)
schtype <- sample(0:1, 20, replace=T)
?sample
schtype
is.factor(schtype)
is.numeric(schtype)

# Generate a factor vector
schtype.f <- factor(schtype, labels = c("private", "public"))
schtype.f
is.factor(schtype.f)

# Generate string vector
ses <- c("low", "middle", "low", "low", "low", "low", "middle", "low",
         "middle", "middle", "middle", "middle", "middle", "high", "high",
         "low", "middle", "middle", "low", "high")
is.factor(ses)
is.character(ses)

# Create unordered factor vector 
ses.f.bad.order <- factor(ses)
is.factor(ses.f.bad.order)
levels(ses.f.bad.order)

# Order factors alphabetically
ses.f <- factor(ses, levels=c("low", "middle", "high"))
is.factor(ses.f)
levels(ses.f)

# creating ordered factor variables
ses.order <- ordered(ses, levels = c("low", "middle", "high"))
ses
ses.order
is.factor(ses.order)


# adding and dropping levels in factor variables
ses.f[21] <- "very.high"
ses.f
# the above changed high to NA

# to fix this
ses.f <- factor(ses.f, levels= c(levels(ses.f), "very.high"))
ses.f[21] <- "very.high"
ses.f
levels(ses.f)

# dropping a level
# remove all the allments within the level
# redeclare
ses.f.new <- ses.f[ses.f != "very.high"]
ses.f.new
ses.f.new <- factor(ses.f.new)
ses.f.new

ses.f <- ses.f.new
read <- c(34, 39, 63, 44, 47, 47, 57, 39, 48, 47, 34, 37, 47, 47, 39, 47, 47, 50, 28, 60)

# Combine factor variables into data frame
combo <- data.frame(schtype, schtype.f, ses, ses.f, read)
combo

# Find total number of rows in a dataset
sum(complete.cases(ses.f))


# Visualise using Table and bwplot
# tables are much easier when using factor
table(ses, schtype)
table(ses.f.new, schtype.f)

# graphics are another benefits for factor variables
library(lattice)
bwplot(schtype ~ read | ses, data = combo, layout = c(2, 2))
bwplot(schtype.f ~ read | ses.f, data = combo, layout = c(2, 2))
