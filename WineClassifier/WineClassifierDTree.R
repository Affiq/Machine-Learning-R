# Reading in the wine data...
winedata = read.csv('C:\\Users\\SLL125\\Downloads\\winedata.csv', sep=",", header=TRUE)

# Import the class library
library(class)

# Extract the column names and the values themselves
wineclass = winedata[,1]
winevalues = winedata[,-1]

# Set up the training set
wineclassTrain = wineclass[1:100]
winevaluesTrain = winevalues[1:100,]

# Set up the test set
wineclassTest = wineclass[100:178]
winevaluesTest = winevalues[100:178,]

# Use rpart to build a classifier/decision tree
library(rpart)
fit <- rpart(wineclassTrain~., method="class", data=winevaluesTrain)

# Plot the decision tree
plot(fit, uniform=TRUE, main="Decision Tree for WineData3")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# Test the classifier on the test set - 
# calculate the predictions for each testcase in our test set
treepred <-predict(fit, winevaluesTest, type = 'class')

# Get number of testcases
n = length(wineclassTest) 
# Get number of correctly guessed testcases
ncorrect = sum(treepred==wineclassTest)
# Get accuracy
accuracy=ncorrect/n
print(accuracy)


# View results as a confusion matrix
table_mat = table(wineclassTest, treepred)
print(table_mat)

# Observing pruning effect 
pfit<- prune(fit, cp=0.1)
plot(pfit, uniform=TRUE, main="Pruned Decision Tree for WineData3")
text(pfit, use.n=TRUE, all=TRUE, cex=.8)

# K Nearest neighbours algorithm
knn3pred = knn(winevaluesTrain, winevaluesTest, wineclassTrain, k=3)
# Calculate num of test cases, correctly guessed and accuracy
n = length(wineclassTest) #the number of test cases
ncorrect = sum(knn3pred==wineclassTest)
accuracy=ncorrect/n
print(accuracy)


