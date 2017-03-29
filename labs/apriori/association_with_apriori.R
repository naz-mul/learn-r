## Association Rule Learning and the Apriori Algorithm

library(arulesViz)
library(arules)

# create random patterns
patterns <- random.patterns(nItems = 1000)
summary(patterns)
trans <- random.transactions(nItems = 1000, nTrans = 1000, method =
                              "agrawal",  patterns = patterns);
image(trans)

# Using apriori
data("AdultUCI")
summary(AdultUCI)
Adult <- as(AdultUCI, 'transactions')


rules <- apriori(Adult, parameter = )