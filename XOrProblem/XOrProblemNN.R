library(neuralnet)

#OR gate input data
trainin = rbind(c(1,1), c(1,-1), c(-1,1), c(-1,-1));
#OR gate output data
trainout = rbind(1, 1, 1, 0);
#Combined OR gate data
ORdat=cbind(trainout,trainin)


# fit neural network with no hidden layers
set.seed(2)
NN = neuralnet(ORdat[,1]~., ORdat[,-1], hidden = 0 , threshold = 0.001,
               stepmax = 1e+05, linear.output = FALSE)
#visualise the NN
plot(NN)

# Check random weights and biases
print(NN$weights)

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
# Make the predictions a dsicrete set of values
predict_out = as.numeric(predict_testNN$net.result>0.5)
print(predict_out)




