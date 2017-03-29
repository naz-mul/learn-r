# Decision trees

# Set location and data set
loc <- "http://archive.ics.uci.edu/ml/machine-learning-databases/"
ds <- "breast-cancer-wisconsin/breast-cancer-wisconsin.data"
url <- paste(loc, ds, sep = "")
# Import data
breast_data <-
  read.table(url,
             sep = ",",
             header = F,
             na.strings = "?")
# Inspect data
summary(breast_data)
class(breast_data)

# set name for each column
colnames(breast_data) <- c(
  "id",
  "clump_thickness",
  "uniformity_of_cell_size",
  "uniformity_of_cell_shape",
  "marginal_adhesion",
  "single_epithelial",
  "bare_nuclei",
  "bland_chromatin",
  "normal_nucleoli",
  "mitoses",
  "class"
)

# remove first column
df <- breast_data[-1]

# change class values to factor
df$class <- factor(df$class, levels = c(2, 4))
labels <- c("benign", "malignant")

# extract training data
set.seed(1234)
train <- sample(nrow(df), 0.7 * nrow(df))
df.train <- df[train,]

# extract validation data
df.validate <- df[-train, ]

# Inspect
table(df.train$class)
table(df.validate$class)

# decision trees can be grown and pruned using the rpart() and prune()
library(rpart)
set.seed(1234)
# The following listing creates a decision tree for classifying the cell data as benign or malignant.
dtree <- rpart(class ~ ., data = df.train, method = "class", parms = list(split = "information"))
dtree$cptable

plotcp(dtree)
dtree.pruned <- prune(dtree, cp = 0.0125)
plotcp(dtree.pruned)
library(rpart.plot)
prp(dtree.pruned, type = 2, extra = 104, fallen.leaves = T, main = "Decision Tree")
