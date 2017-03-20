### Data Preparation ###
# http://handsondatascience.com/DataO.pdf

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

# Install and load packages
package.install.func(
  c(
    'RGtk2',
    'rattle',
    'randomForest',
    'tidyr',
    'ggplot2',
    'dplyr',
    'lubridate',
    'FSelector'
  )
)

library(RGtk2)
library(rattle) # The weather dataset and normvarNames()
library(randomForest) # Impute missing values using na.roughfix()
library(tidyr) # Tidy the dataset
library(ggplot2) # Visualise data
library(dplyr) # Data prep and pipes %>%
library(lubridate) # handle dates
library(FSelector) # Feature selection

# Note data path
dspath <- "http://rattle.togaware.com/weather.csv"
# Read into memory
weather <- read.csv(dspath)

# see what data looks like
dim(weather)
names(weather)
str(weather)

# load generic variables
dsname <- 'weather'
ds <- get(dsname)
dim(ds)
names(ds)

# convenience of table data frame
#  Avoid printing whole data frame
class(ds)
ds <- tbl_df(ds) # ** IMPORTANT
class(ds)
ds

# Review and observations
head(ds)
tail(ds)
ds[sample(nrow(ds), 10), ]

# Review - structure
str(ds)

# Review - Summary
summary(ds)

# Review - Meta Data Cleansing
# Normalise variable names
# R is case sensitive
# Useful when different upper/lower case conventions are intermixed
names(ds)
# converting variables from a dataset to standard form
names(ds) <- normVarNames(names(ds))
names(ds)

# Review - Data formats
# Check data type of each variables
sapply(ds, class)
library(lubridate)
head(ds$date)
# convert date data type from factor to date using lubridate
ds$date <- ymd(as.character(ds$date))
head(ds$date)
sapply(ds, class)

# Review - Variable Roles
# Date is not relevant
# Location is a constant
# risk is an output variable, thus, should not be used as an input
(vars <- names(ds))
target <- "rain_tomorrow"
risk <- 'risk_mm'
id <- c('date', 'location')


# Clean - Ignore IDs, Outputs, Missing
# Always watch out for including output variables as inputs
ignore <- union(id, if (exists('risk'))
  risk)
# ignore <- union(id, if(exists('target')) target)

# Unique variables - they are identifiers
(ids <-
    which(sapply(ds, function(x)
      length(unique(
        x
      ))) == nrow(ds)))
ignore <- union(ignore, names(ids))

# Remove variables whre all the values are missing
# Count the number of variables with missing values
# List the variables with missing values
mvc <- sapply(ds[vars], function(x)
  sum(is.na(x)))
mvc
mvn <- names(which(mvc == nrow(ds)))
ignore <- union(ignore, mvn)

# Ignore variables with 70% values missing
mvn <- names(which(mvc >= 0.7 * nrow(ds)))
ignore <- union(ignore, mvn)


# Clean - Ignore multilevel, Constants
factors <- which(sapply(ds[vars], is.factor))
lvls <- sapply(factors, function(x)
  length(levels(ds[[x]])))
(many <- names(which(lvls > 20)))
ignore <- union(ignore, many)

# Constants
(constants <-
    names(which(sapply(ds[vars], function(x)
      all(x == x[1L])))))
ignore <- union(ignore, constants)


# Clean - Identify Correlated Variables
mc <- cor(ds[which(sapply(ds, is.numeric))], use = "complete.obs")
mc[upper.tri(mc, diag = TRUE)] <- NA
mc <-
  mc %>% abs() %>% data.frame() %>% mutate(var1 = row.names(mc)) %>% gather(var2, cor, -var1) %>% na.omit()
mc <- mc[order(-abs(mc$cor)), ]
# Keep one remove the other from the correlated pair
# Normally, limit the removals to those correlations that are 0.95 or more
ignore <- union(ignore, c('temp_3pm', 'pressure_9am', 'temp_9am'))

# Clean - Remove the variables
length(vars)
length(ignore)
ignore
vars <- setdiff(vars, ignore)
length(vars)

# Clean - Feature Selection
# sudo ln -f -s $(/usr/libexec/java_home)/jre/lib/server/libjvm.dylib /usr/local/lib
library(FSelector)
form <- formula(paste(target, '~ .'))
cfs(form, ds[vars])
information.gain(form, ds[vars])

# Clean - Remove Missing Target
# Remove missing values
# Convert variables to correct type
# Remove observations with missing target
dim(ds)
sum(is.na(ds[target]))
ds <- ds[!is.na(ds[target]), ]
sum(is.na(ds[target]))
dim(ds)

# Clean - Deal with Missing Values
# Random Forest has not built to handle missing values
# Rpart is developed to deal with missing values
# Impute missing values with data (not always admirable)
ods <- ds
dim(ds[vars])
sum(is.na(ds[vars]))
ds[vars] <- na.roughfix(ds[vars])
sum(is.na(ds[vars]))
dim(ds[vars])
ds <- ods

# Clean - Omitting observations
# Simply remove observations that have missing values
ods <- ds
omit <- NULL
dim(ds[vars])
sum(is.na(ds[vars]))
mo <- attr(na.omit(ds[vars]), 'na.action')
omit <- union(omit, mo)
if (length(omit))
  ds <- ds[-omit,]
sum(is.na(ds[vars]))
dim(ds[vars])
ds <- ods


# Clean - Normalise Factors
# Variables may have levels with spaces and mixture of cases
factors <- which(sapply(ds[vars], is.factor))
for (f in factors)
  levels(ds[[f]]) <- normVarNames(levels(ds[[f]]))


# Clean - Ensure Target is Categoric
# Ensure the target is categoric
ds[target] <- as.factor(ds[[target]])
table(ds[target])

# visualise using ggplot
p <- ggplot(ds, aes_string(x = target))
p <- p + geom_bar(width = 0.2)
print(p)


# Prepare - Variables
# Identify input variables
# Vector of char and vector of integers
inputc <- setdiff(vars, target)
inputc

inputi <-
  sapply(inputc, function(x)
    which(x == names(ds)), USE.NAMES = FALSE)
inputi

# record the number of observations
nobs <- nrow(ds)
nobs
dim(ds)
dim(ds[vars])
dim(ds[inputc])
dim(ds[inputi])

# Prepare - Numeric and Categoric Variables
numi <- intersect(inputi, which(sapply(ds, is.numeric)))
numi

numc <- names(ds)[numi]
numc

cati <- intersect(inputi, which(sapply(ds, is.factor)))
cati

catc <- names(ds)[cati]
catc


# Prepare - Save Dataset
# For large datasets, it's better to save as binary RData
# only needed once
dsdate <- paste0("_", format(Sys.Date(), "%y%m%d"))
dsrdata <- paste0(dsname, dsdate, ".RData")
save(
  ds,
  dsname,
  dspath,
  dsdate,
  target,
  risk,
  id,
  ignore,
  vars,
  nobs,
  omit,
  inputi,
  inputc,
  numi,
  numc,
  cati,
  catc,
  file = dsrdata
)

# load the data
(load(dsrdata))
dsname
dspath
dim(ds)
id
target
risk
ignore
vars
