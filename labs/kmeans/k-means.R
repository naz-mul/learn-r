############################################
############ K-MEANS CLUSTERING ############
############################################
# Terminologies and notes
# Find K - manually using scree plot, NbClust
# K-means clustering - determine mean, quantify agreement
# Iris data - plot clusters and centers
# PAM Clustering - partitioning around medoids


######## TERMINOLOGIES AND NOTES #########
# kmeans clustering can be sensitive to outliers
# kmeans only works for numeric (continuous) variables
# use partitioning around medoids (pam) for mixed data types


######## FIND K #########
# Create a function to calculate k clusters
wssplot <- function(data, nc = 15, seed = 1234) {
  wss <- (nrow(data) - 1) * sum(apply(data, 2, var))
  for (i in 2:nc) {
    set.seed(seed)
    wss[i] <- sum(kmeans(data, centers = i)$withinss)
  }
  plot(1:nc,
       wss,
       type = "b",
       xlab = "Number of Clusters",
       ylab = "Within groups sum of squares")
}

# Import wine data from rattle
library(rattle)
data(wine, package = "rattle")
head(wine)

# Drop first column (redundant)
df <- scale(wine[-1])


# Find the best number of clustering using scree plot
# Sharp elbow in the line indicates k
wssplot(df)


# Find the best number of clusters using NbClust
library(NbClust)
set.seed(1234)
devAskNewPage(ask = T) # prompt to ask for a new plot page
par(mar = rep(2, 4)) # Set the plotting screen size
nc <- NbClust(df,
              min.nc = 2,
              max.nc = 15,
              method = "kmeans")
table(nc$Best.n[1, ])

# Bar plot the best number of clusters
barplot(table(nc$Best.n[1,]), xlab = "Number of Clusters", main = "Number of Clusters Chosen by 26 Criteria")


######## KMEANS CLUSTERING #########
# Create k-means cluster
set.seed(1234)
fit.km <- kmeans(df, 3, nstart = 25)

# Inspect
fit.km
fit.km$size
fit.km$centers

# Determine variable means for each cluster in the original metric
aggregate(wine[-1], by = list(cluster = fit.km$cluster), mean)

# Check how well did the k-means clustering uncover the actual structure
ct.km <- table(wine$Type, fit.km$cluster)
ct.km

# Quantify the agreement between type and cluster
# Agreement measured in -1 (no agreement) to 1 (perfect agreement)
library(flexclust)
randIndex(ct.km)


######## IRIS DATA #########
# Import iris data and remove last column
x <- iris[-5]
y <- iris$Species

# Find K
# using scree plot
wssplot(x)

# using NbClust
library(NbClust)
nc.iris <- NbClust(x,
                   min.nc = 2,
                   max.nc = 15,
                   method = "kmeans")

# Bar plot the best number of clusters
barplot(table(nc.iris$Best.n[1,]), xlab = "Number of Clusters", main = "Number of Clusters Chosen by 26 Criteria")


# Apply k-means
set.seed(1234)
kc <- kmeans(x, 3)

# To know how many error and missing data
# # Compare the clustering result with the species/classes iris data
table(y, kc$cluster)

# Plot clusters and centers
plot(x[c("Sepal.Length", "Sepal.Width")], col = kc$cluster)
points(kc$centers[, c("Sepal.Length", "Sepal.Width")],
       col = 1:3,
       pch = 23,
       cex = 3)



######## PAM CLUSTERING #########
library(cluster)
cardiology.pam <- pam(df, 2)
names(cardiology.pam)

plot(cardiology.pam)
plot(df, col = cardiology.pam$medoids)