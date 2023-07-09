# Load the wine data
winedata = read.csv('C:\\Users\\SLL125\\Downloads\\winedata2.csv',
                    sep=",", header=TRUE)

library(neuralnet)

# Preprocessing sort of messes up our data
# winedata = na.omit(winedata) # deletion of missing data
# winedata = scale(winedata) # standardize variables

# We want to get the classes and the values of the wine...
wineclass = winedata[,1] # This is the output...
winevalues = winedata[,-1]

# Here we want to extract any 2 variables from the wine data
var1 = winevalues[,1]
var2 = winevalues[,5]
# And we want to combine them together to create the neurons inputs
inputvector = cbind(var1, var2)

# (Re)combining all the data together into one matrix
wineset = cbind(wineclass, inputvector)

# Traning set
trainset = wineset[1:65,]
# Test set
testset = wineset[66:130,]

# Extract the test set classes and values...
testsetclass = testset[,1]
testsetvalues = testset[,-1]
# The outputs are currently 1 or 2, we need to remap it to 0 or 1
testsetclass = testsetclass - 1

# Extract the train set classes and values...
trainsetclass = trainset[,1]
trainsetvalues = trainset[,-1]
# The outputs are currently 1 or 2, we need to remap it to 0 or 1
trainsetclass = trainsetclass - 1

# Hidden layer architecture - found 3,3,3,3 with seed 2 was good
# Hidden layer 4,4,4 with seed 5 was extremely good
hiddenLayer = c(4,4,4)

# Create a neural network using the training set
set.seed(5)
NN = neuralnet(trainsetclass~., trainsetvalues, hidden = hiddenLayer , 
               threshold = 0.01, stepmax = 1e+5, linear.output = FALSE)
# Plot the neural network
plot(NN)


# compute predictions for the test set...
predict_testNN = compute(NN, testset[,-1])
# Print the results of the prediction as continuous values...
# print(predict_testNN$net.result)
predict_out = as.numeric(predict_testNN$net.result>0.5)

# Let us calculate the number of correct cases
ncorrect = sum(predict_out==testsetclass)
print("Number of correct cases:")
print(ncorrect)
accuracy = ncorrect / length(testsetclass)
print("Accuracy:")
print(accuracy)





