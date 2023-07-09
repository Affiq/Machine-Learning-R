# C:\\Users\\SLL125\\Downloads\\ - File location
# Read the spaeth file to use - has headers
seeddata = read.csv('C:\\Users\\SLL125\\Downloads\\seeds_dataset.csv', sep=",", header=TRUE)
# Load the Weighted-Kappa function
source("C:\\Users\\SLL125\\Downloads\\WK_R.r")
# Load the actual cluster groups - no headers
realdata = read.csv('C:\\Users\\SLL125\\Downloads\\seeds_real.csv', sep=",", header=FALSE)

# Some pre-processing
seeddata = na.omit(seeddata) # deletion of missing data
seeddata = scale(seeddata) # standardize variables

# Get the groupings as a vector rather than a dataframe/matrix
realgroups = realdata$V1

# Test to see if we have loaded the seed data correctly
# Do this by checking column names
print(dimnames(seeddata))

# Create distance matrix (for hierarchical clustering)
d <- dist(seeddata, method = "euclidean")

# Initialize empty vectors to store WKs of all H Clusterings
havWKs = vector()
hsingWKs = vector()
hcompWKs = vector()
# Create empty vector to store WK of K-Means algorithm
KmeansWK = vector()

# Hierarchical Clustering - all types
havfit <- hclust(d, method="average")
hsingfit <- hclust(d, method="single")
hcompfit <- hclust(d, method="complete")

# Perform H-Clustering of all types for K from 1 to 6
print("Performing Hierachical clustering")
for (k in 1:6) {
  # Create groupings
  havgroups = cutree(havfit, k)
  hsinggroups = cutree(hsingfit, k)
  hcompgroups = cutree(hcompfit, k)
  
  # Get the WKs
  havWK = WK_R(havgroups, realgroups)
  hsingWK = WK_R(hsinggroups, realgroups)
  hcompWK = WK_R(hcompgroups, realgroups)

  # Add the WK to their respective WK vector
  havWKs = c(havWKs, havWK)
  hsingWKs = c(hsingWKs, hsingWK)
  hcompWKs = c(hcompWKs, hcompWK)
}



# K-Means clustering - perform it for K from 1 to 10
print("Performing K-Means clustering")
for (k in 1:6) {
  # K - Means clustering
  kmeansfit <- kmeans(seeddata, k)
  kgroups = kmeansfit$cluster
  
  # Calculate the Weighted Kappa for this grouping
  wk = WK_R(kgroups, realgroups)
  KmeansWK = c(KmeansWK, wk)
}

# Plotting the Weighted Kappas for different KMeans as a plot graph
plot(KmeansWK, 
     main = "Weighted Kappa for different Clustering algorithms"
     , xlab = "K-Value"
     , ylab = "Weighted Kappa Value"
     , col = "red"
     , type = "o")

# Plot the other Weighted kappas on the same graph
# Plotting hierarchical average
lines(havWKs, type ="o", col="blue")
# Plotting hierarchical complete
lines(hcompWKs, type="o", col="green")
# Plotting hierarchical single
lines(hsingWKs, type="o", col="purple")

# Add a legend to the graph
colors = c("red", "blue", "green", "purple")
names = c("K-Means", "Average Hierarchical", "Complete Hierarchical", "Single Hierarchical")
legend("bottomright",legend = names, col = colors,
       cex = 0.5, lty = 1, y.intersp = 0.7, bty = "n")

# According to graph, all clusters reach their peak when n/k = 3
# Plot the K-Means graph for k=3
kmeansfit <- kmeans(seeddata, 3)
kgroups = kmeansfit$cluster
plot(seeddata, col=kgroups, main="K-Means clustering for K=3")

# Plot the Hierarchical graph with Complete linkage
hcompfit <- hclust(d, "complete")
hcompgroups = cutree(hcompfit, 3)
plot(hcompfit, main="Hierarchical Clustering (Complete linkage)")
# Add the rectangles
rect.hclust(hcompfit, k=3, border="red") 

# Plot the Hierarchical graph with Average linkage
havfit <- hclust(d, "average")
havgroups = cutree(havfit, 3)
plot(havfit, main="Hierarchical Clustering (Average linkage)")
# Add the rectangles
rect.hclust(havfit, k=3, border="purple") 
