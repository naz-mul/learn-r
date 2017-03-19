scores <- c(61, 66, 90, 88, 100)

# create an empty data frame
scores <- data.frame()

# then invoke the built-in
scores <- edit(scores)

points <- data.frame(
  label=c("Low", "Mid", "High"),
  lbound=c( 0, 0.67, 1.64),
  ubound=c(0.674, 1.64, 2.33))

# output R script
# redirect output to a file
sink("script_output.txt")

# Run the script, capturing its output
source("script.R")

# Resume writing output to console
sink()

# append using cat rather overwrite
cat(results, file="analysisReport.txt", append=TRUE)

# NB. open a connection to a file rather
# than hard-coding it everytime (less error prone)
data <- c(2, 3, 5)
con <- file("analysisReport.txt", "w")
cat(data, file=con)

results <- c("aa", "bb", "cc", "dd", "ee")
cat(results, file=con)
close(con)

# show files in your working directory
list.files()

# show files in sub-directories as well
list.files(recursive = TRUE)

# show hidden files
list.files(all.files = TRUE)

# read files which has fixed width format
records <- read.fwf("fixed-wdith.txt", widths=c(10,10,4,-1,4))

# add labels in columns
records <- read.fwf("fixed-width.txt", widths=c(10,10,4,-1,4), col.names = c("Last", "First", "Born", "Died"))

# reading tabluar data files
dfrm <- read.table("fixed-width.txt")

# if file uses separator e.g a colon
dfrm <- read.table("fixed-width.txt", sep=":")

# find the type of data in the data frame
class(dfram$V1)

# use the column names when it builds the data frame
dfrm <- read.table("fixed-wdith.txt", header=TRUE, stringsAsFactor=FALSE)


# prevent data frame to read text as factor
dfrm <- read.table("fixed-width.txt", stringsAsFactors = FALSE)


# set N/A fields with different value e.g. a period
dfrm <- read.table("filename.txt", na.strings=".")

# tell the file contains headers
dfrm <- read.table("statisticians.txt", header=TRUE, stringsAsFactor=FALSE)

# read csv files with no header
tbl <- read.csv("table-data.csv", header=FALSE)

# display the structure of an object
str(tbl)

# set non-numeric characters as-is
tbl <- read.csv("table-data.csv", as.is=TRUE)

# write to a csv files
write.csv(tbl, file = "table-data-x.csv", row.names=TRUE)

# read csv/table files from the web
crimedata <- read.csv("http://samplecsvs.s3.amazonaws.com/SacramentocrimeJanuary2006.csv", as.is=T)

# read data from html tables
# import XML package
library(XML)
url <- "http://world.bymap.org/Population.html"
htmlTbls <- readHTMLTable(url)

# reading files with complex structure
singles <- scan("singles.txt", what=numeric(0))

# read files with repeating sequence
triples <- scan("triples.txt", what=list(character(0),numeric(0),numeric(0)))

# assign names to the list elements
triples <- scan("triples.txt", what=list(date=character(0), high=numeric(0), low=numeric(0)))

# read data stored as column order
world.series <- scan("http://lib.stat.cmu.edu/datasets/wseries", skip = 35,nlines = 23,what = list(year = integer(0), pattern = character(0)))

# sort list elements by year
perm <- order(world.series$year)
world.series <- list(year = world.series$year[perm], pattern = world.series$pattern[perm])
