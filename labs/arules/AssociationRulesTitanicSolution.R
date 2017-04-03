###########################################
############ ASSOCIATION RULES ############
###########################################
# Terminologies and notes
# Tips
# Data loading - .rdata format
# Data preparation - set column names
# Association rule mining - apriori, sort by lift
# Removing redundancy - is.redundant()
# Visualise - arulesViz


######## TERMINOLOGIES AND NOTES #########
# General process to find out which things go together
# May contain several attribute values
# No good algorithm for numeric data
# Support - minimum percentage of instances containing both A and B in a given rule
# Confidence - percentage of likelihood if A go with B
# Lift - result of product association with one or more other products
# Apriori - frequent itemsets to generate rules


######## TIPS #########
# Eliminate error when predicting rules by finding the percentage (num instance / total instance)
## Set minimum confidence of the percentage (num instance/total instance)


######## DATA LOADING #########
# Install and load the association rules package
install.packages("arules")
library(arules)

# Load the R workspace file
setwd("~/Desktop/learn-r/labs/arules")
load("./titanic.raw.rdata")


######## DATA PREPARATION #########
# Assign appropriate names and view the dataset details
names(titanic.raw) <- c("Class", "Sex", "Age", "Survived")
summary(titanic.raw)


######## ASSOCIATION RULE MINING #########
# Find association rules with default settings
rules.all <- apriori(titanic.raw)
inspect(rules.all)

# Rules with rhs containing "Survived" only
# We are interested in rules containing survival only
# Remove empty lhs rule with minlen
# 12 rules are produced provided supp = 0.005
# # ceiling(0.005 * 2201)
(rules <-
    apriori(
      titanic.raw,
      control = list(verbose = F),
      parameter = list(
        minlen = 2,
        supp = 0.005,
        conf = 0.8
      ),
      appearance = list(
        rhs = c("Survived=No", "Survived=Yes"),
        default = "lhs"
      )
    ))

# Sort rules by lift to make high-lift rules first
quality(rules) <- round(quality(rules), digits = 3)
rules.sorted <- sort(rules, by = "lift")
inspect(rules.sorted)


######## REMOVING REDUNDANCY #########
# Some rules provide little or no extra information
# When a rule is a super rule of another rule,
# # and the former has the same or lower lift,
# # the former is considered to be redundant

# Find redundant rules
redundant <- is.redundant(rules.sorted)
which(redundant)

# Remove redundant rules
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)

# Find rules for children of different classes
# Better interpretation
rules <-
  apriori(
    titanic.raw,
    parameter = list (minlen = 3, sup = 0.002, conf = 0.2),
    appearance = list(
      rhs = c("Survived=Yes"),
      lhs = c(
        "Class=1st",
        "Class=2nd",
        "Class=3rd",
        "Age=Child",
        "Age=Adult"
      ),
      default = "none"
    ),
    control = list(verbose = F)
  )

rules.sorted <- sort(rules, by = "confidence")
inspect(rules.sorted)


######## VISUALISE #########
library(arulesViz)
plot(rules.pruned)
plot(rules.pruned,
     method = "graph",
     control = list(type = "items"))
plot(rules.pruned,
     method = "paracoord",
     control = list(reorder = TRUE))
