# Read rows as columns - first column as header, second column as rows
# Only first 19 rows
# Ignore header
# Skip first row

setwd("~/Desktop/learn-r/proj")

this.path <- "odi_csv_male"
this.pattern <- ".csv$"

import.mult.csv <- function(path, pattern, ...) {
  tmp.files.list <- list.files(path, pattern, full.names = TRUE)
  tmp.list.data <- list(length = length(tmp.files.list))
  for (i in 1:length(tmp.files.list))
  {
    cur.file <- tmp.files.list[i]
    tmp.list.data[[i]] <- read.csv(cur.file, ...)
  }
  names(tmp.list.data) <- tmp.files.list
  tmp.list.data
}

# Import all the csv files as list
data <-
  import.mult.csv(
    this.path,
    this.pattern,
    nrows = 19,
    skip = 1,
    row.names = NULL,
    header = F,
    colClasses = c("NULL", NA, NA)
  )

# Convert list to data frame
df <- data.frame(lapply(data.frame(t(sapply(
  data, `[`
))), unlist))

# Remove row names
row.names(df) <- NULL


# create a data frame with first 19 rows
cric.data <- df[1:19, ]

# extract first 19 rows from column one to set it as header
names <- df$V2[1:19]
names.char <- as.character(names)
names.char

# transpose rows as columns
cric.data <- as.data.frame(t(cric.data))
cric.data <- cric.data[-1, ]
row.names(cric.data) <- NULL
names(cric.data) <- names.char

new.cric.data <- cric.data

library(plyr)
for(i in seq(from = 20, to=nrow(df), by=19)) {
  from <- i
  to <- from + 18
  tmp.cric.data <- df[from:to, ]
  tmp.cric.data <- as.data.frame(t(tmp.cric.data))
  tmp.cric.data <- tmp.cric.data[-1, ]
  row.names(tmp.cric.data) <- NULL
  names(tmp.cric.data) <- names.char
  cric.data <- rbind(cric.data, tmp.cric.data)
}
