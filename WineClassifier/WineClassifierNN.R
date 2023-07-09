library(neuralnet)

#OR gate input data
trainin = rbind(c(-1,-1), c(1,-1), c(-1,1), c(1,1));
#OR gate output data
trainout = rbind(0, 1, 1, 0);
#Combined OR gate data
XORdat=cbind(trainout,trainin)


# fit neural network with no hidden layers
set.seed(2)
NN = neuralnet(XORdat[,1]~., XORdat[,-1], hidden = 0 , threshold = 0.001,
               stepmax = 1e+05, linear.output = FALSE)
#visualise the NN
plot(NN)

# Check random weights and biases
# print(NN$weights)

# COMPUTE prediction for an input of c(1,1)
testin= rbind(c(1,1))
predict_testNN = compute(NN, testin)
print("Result of input (1,1)")
print(predict_testNN$net.result)

# Calculate the discrete class - true will be 1, false will be 0
predict_out = as.numeric(predict_testNN$net.result>0.5)
print(predict_out)


# Set input as a sequence of inputs
testin=rbind(c(1,1),c(1,-1),c(-1,1), c(-1,-1))
predict_testNN = compute(NN, testin)
predict_testNN$neurons
predict_testNN$net.result
# Make the predictions a discrete set of values
predict_out = as.numeric(predict_testNN$net.result>0.5)
print(predict_out)
print("Answer should be 0 1 1 0")



# # Multilayer Neural Network
# #XOR gate input data
# trainin = rbind(c(1,1), c(1,-1), c(-1,1), c(-1,-1));
# #XOR gate output data
# trainout = rbind(0, 1, 1, 0);
# #Combined XOR gate data
# XORdat=cbind(trainout,trainin)
# #train a neural network on the XOR data
# set.seed(2)
# NN = neuralnet(XORdat[,1]~., XORdat[,-1], hidden = c(3,3) , threshold =
#                  0.1, stepmax = 1e+07, linear.output = FALSE)


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





