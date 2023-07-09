# C:\\Users\\SLL125\\Downloads\\ - File location
library(class)

# Read the spaeth file to use - has some headers
seeddata = read.csv('C:\\Users\\SLL125\\Downloads\\seeds_dataset.csv', sep=",", 
                    header=TRUE)
realdata = scan('C:\\Users\\SLL125\\Downloads\\seeds_real.csv', sep=",")
seeddata['Class'] = realdata


# Used to mix up ordering of rows
# This is done so each execution uses a different set
# of training and test values
seeddata=seeddata[sample(209,209),] 

# Extract the column names and values...
seedclass = seeddata[,8]
seedvalues = seeddata[,-8]

# Extract the length of the classes
print(length(seedclass))

# Seed training set
seedclassTrain = seedclass[1:150]
seedvaluesTrain = seedvalues[1:150,]
# Seed test set
seedclassTest = seedclass[151:209]
seedvaluesTest = seedvalues[151:209,]

# Create the decision tree
library(rpart)
fit <- rpart(seedclassTrain~., method="class", data=seedvaluesTrain)
# Plot the decision tree
plot(fit, uniform=TRUE, main="Decision Tree for Seed values")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# Create our predictions for the test set
treepred <-predict(fit, seedvaluesTest, type = 'class')
plot(seedvaluesTest, col=treepred)

# Testing the classifier, getting correct cases & accuracy
n = length(seedclassTest)
ncorrect = sum(treepred==seedclassTest)
accuracy = ncorrect/n
print("Accuracy before pruning")
print(accuracy)
# Obtain accuracy of decision tree
dectreeacc = rep(accuracy,5)

prunetreeacc = vector()
for (i in 1:5) {
  cp = 0.2*i
  # Prune the tree
  prunedfit <- prune(fit, cp=0.1)
  plot(prunedfit, uniform=TRUE, main="Pruned Decision tree for Seed Values")
  text(fit, use.n=TRUE, all=TRUE, cex=.8)
  
  # Test everything again - but with pruned tree
  prunedtreepred <- predict(prunedfit, seedvaluesTest, type = "class")
  n = length(seedclassTest)
  ncorrect = sum(prunedtreepred==seedclassTest)
  accuracy = ncorrect/n
  print("Accuracy after pruning")
  print(accuracy)
  # Add to vectors of pruned decision tree accuracy
  prunetreeacc = c(prunetreeacc,accuracy)
}

# Empty vector to store KNN Accuracies with different Ks
kaccuracies = vector()
# Start KNN algorithm
library(class)
for (k in 1:5) {
  # Apply KNN Algorithm
  knnpred = knn(seedvaluesTrain, seedvaluesTest, seedclassTrain, k)
  # Test out the accuracy
  n = length(seedclassTest)
  ncorrect = sum(knnpred==seedclassTest)
  accuracy=ncorrect/n
  # Add accuracy to vector of KNN accuracies
  kaccuracies = c(kaccuracies, accuracy)
}

# Plot the vector of KNN accuracies for different values of K
plot(kaccuracies, 
     main = "Accuracies of different algorithms"
     , xlab = "K-Value"
     , ylim = c(0.4,1)
     , ylab = "Accuracy"
     , col = "red"
     , type = "o")

# Plot accuracies of the decision trees and pruned decision trees
lines(dectreeacc, type ="o", col="blue")
lines(prunetreeacc, type = "o", col="green")

# Add a legend to the graph
colors = c("red", "blue", "green")
names = c("K-Nearest Neighbour", "Decision Tree", "Pruned Decision Tree")
legend("bottomright",legend = names, col = colors,
       cex = 0.5, lty = 1, y.intersp = 0.7, bty = "n")