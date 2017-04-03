########################################
############ DECISION TREES ############
########################################
# Terminologies and notes
# Commenting and evaluation
# Tips
# Data loading - paste, .data format
# Data prepartion - set column names, remove column, change to factor, extract train and validation
# Classical decision trees - rpart, rpart.plot, prune, cptable, prp, predict
# Conditional inferance trees - ctree, plot, predict, table


######## TERMINOLOGIES AND NOTES #########
# Supervised learning
# Heuristic learning - greedy search
# Recursively partition data into sub-groups
# Output must be categorial
# Limited to one output


######## COMMENTING AND EVALUATION #########
# Is there a tie? -> break tie by opting for most frequent class
# Number of branches
# Number of classifiations
# Percentage of classification (num of classifications/num of observations)
# Generalisation -> Goodness score = Percentage of Classification / Number of branches
# Attributes with the best goodness score is the ROOT NODE
# Generate decision tree rules IF A THEN B


######## TIPS #########
# Sort numeric attributes
# Examine each branch and decide whether to continue
# Simplify trees by pruning sub-trees
# # a) Post-pruning -> Accuracy criteria
# # b) Pre-pruning -> Set stopping criteria


######## DATA LOADING #########
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



######## DATA PREPARATION #########
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

# remove first column, id is redundant
df <- breast_data[-1]

# change class values to factor
# output of a decision tree needs to be a factor
df$class <- factor(df$class, levels = c(2, 4), labels = c("benign", "malignant"))
levels(df$class) # verify if levels are set
sapply(df$class, class) # verify if values are factor

# extract training data
set.seed(1234)
train <- sample(nrow(df), 0.7 * nrow(df))
df.train <- df[train, ]

# extract validation data
df.validate <- df[-train,]

# Inspect
# Categorical variables are examined using table()
table(df.train$class)
table(df.validate$class)


######## CLASSICAL DECISION TREES #########
# Starts with a binary outcome variable
# # and a set of predictor variables
# Choose the predictor variable that best splits the data into two groups
# If the predictor variable is continuous, choose a cut-off point
# If the predictor variable is categorical, combine the categories (two groups)
# This process tends to be too large and suffers from overfitting
# Decision trees can be grown and pruned using the rpart() and prune()

library(rpart)
set.seed(1234)

# Grow decision tree using rpart()
dtree <-
  rpart(
    class ~ .,
    data = df.train,
    method = "class",
    parms = list(split = "information")
  )
dtree
summary(dtree)

# Examine cp table to choose a final tree size
# CP table contains prediction error for various tree sizes
# CP is used to penalise larger trees
# nsplit = number of branch splits i.e. n + 1 terminal nodes
# rel error = error rate
# xerror = cross-validated error based on 10-fold cross validation
# xstd = standard error of the cross validation
dtree$cptable

# Plot complexity paramenter (CP) 
plotcp(dtree)

# Prune the tree
# The tree is too large
# Prune least important splits
## smallest tree -> range between xerror + xstd and xerror - xstd 
dtree.pruned <- prune(dtree, cp = 0.0125)
plotcp(dtree.pruned)

# Plot pruned decision tree
library(rpart.plot)
prp(
  dtree.pruned,
  type = 2,
  extra = 104,
  fallen.leaves = T,
  main = "Decision Tree"
)

# Classify each observation against validation sample data
dtree.pred <- predict(dtree.pruned, df.validate, type = "class")

# Create a cross tabulation of the actual status against the predicted status
dtree.perf <- table(df.validate$class, dtree.pred, dnn = c("Actual", "Predicted"))
dtree.perf


######## CONDITIONAL INFERENCE TREES #########
# Variables and splits are selected based on significance tests rather than purity
# Pruning is not required 
# The process is more automated

library(party)
fit.ctree <- ctree(class ~ ., data = df.train)
plot(fit.ctree, main = "Conditional Inference Tree")
ctree.pred <- predict(fit.ctree, df.validate, type = "response")
ctree.perf <- table(df.validate$class, ctree.pred, dnn = c("Actual", "Predicted"))
ctree.perf
