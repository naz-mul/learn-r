x <- 'Hello World'
print(x) # print by function
x # print by value

# create a vector
v <- c(1, 2, 3)

# create a sequence
s <- 1:5

# create a matrix
m <- matrix(data = 1:6,
            nrow = 2,
            ncol = 3)

# create an array
a <- array(data = 1:8, dim = c(2, 2, 2))

# creating a list
l <- list(TRUE, 123L, 2.34, "abc")


# creating a factor
categories <- c("Male", "Female", "Male", "Male", "Female")
factor <- factor(categories)
levels(factor) # see a list of unique names
unclass(factor) # see the underlying integer

# creating a dataframe
df <- data.frame(
  Name = c("Cat", "Dog", "Cow", "Pig"),
  HowMany = c(5, 10, 15, 20),
  IsPet = c(TRUE, TRUE, FALSE, FALSE)
)


# Index data frame by row and column
df[1, 2]

# Index data frame by column
df[, 2]
df["HowMany"]
df$HowMany

# Index data frames by row
df[1,]


# Subsetting data frames
# allows to slice and dice data in very flexible ways
df[c(2, 4),] # return 2 and 4 rows
df[2:4,] # return 2 through 4 rows
df[c(TRUE, FALSE, TRUE, FALSE),] # return by logical values
df[df$IsPet == TRUE,] # return rows where pet is true
df[df$HowMany > 10,] # return rows where pet is greater than
df[df$Name %in% c("Cat", "Cow"),] # return rows where name matches

# R is a vectorised language
# In R arguements can be passed by name or in order

# Named vs ordered arguments
m <-
  matrix(data = 1:6,
         nrow = 2,
         ncol = 3) # create a matrix m in named fashion
n <- matrix(1:6, 2, 3) # create a matrix n in ordered fashion
m == n # are the values of m and n are equal
identical(m, n) # find if m and n are identical
