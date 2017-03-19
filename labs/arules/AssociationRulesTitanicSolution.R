#Install and load the association rules package
install.packages("arules")
library(arules)

#Load the R workspace file 
load("C:/Users/lt00049693/Desktop/titanic.raw.rdata")
#View the dataset details
names(titanic.raw) <- c("Class", "Sex", "Age", "Survived")
summary(titanic.raw)

# find association rules with default settings
rules.all <- apriori(titanic.raw)
inspect(rules.all)

# rules with rhs containing "Survived" only
rules <- apriori(titanic.raw, control = list(verbose=F),parameter = list(minlen=2, supp=0.005, conf=0.8),appearance = list(rhs=c("Survived=No", "Survived=Yes"),default="lhs"))
quality(rules) <- round(quality(rules), digits=3)                 
rules.sorted <- sort(rules, by="lift")
inspect(rules.sorted)

# find redundant rules
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
which(redundant)

# remove redundant rules
rules.pruned <- rules.sorted[!redundant]
inspect(rules.pruned)

#find rules for children of different classes
rules <- apriori(titanic.raw, parameter = list (minlen=3, sup=0.002, conf=0.2),appearance = list(rhs=c("Survived=Yes"),lhs=c("Class=1st", "Class=2nd", "Class=3rd","Age=Child","Age=Adult"),default="none"),control = list(verbose=F))
rules.sorted <- sort(rules, by="confidence")
inspect(rules.sorted)
