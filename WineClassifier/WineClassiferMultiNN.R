# Read the spaeth file to use - has some headers
seeddata = read.csv('C:\\Users\\SLL125\\Downloads\\seeds_dataset.csv', sep=",", header=TRUE)
# Load the actual cluster groups - no headers
outputdata = read.csv('C:\\Users\\SLL125\\Downloads\\seeds_real.csv', sep=",", header=FALSE)

# Let us construct a new matrix out of two variables
# inputdata = cbind(seeddata[,1], seeddata[,2])

trainvalues = seeddata[1:200,]
trainclass = outputdata[1:200,]

# formatted train class
type1 = rep(0,200)
type2 = type1
type3 = type1
formattedtrainclass = cbind(type1,type2,type3)

for (i in 1:200)
{
  if (trainclass[i]==1) {
    formattedtrainclass[,1] = 1
  }
  else if (trainclass[i]==2) {
    formattedtrainclass[,2] = 1
  }
  else if (trainclass[i]==3) {
    formattedtrainclass[,3] = 1
  }
}

# Hidden layer architecture 
hiddenLayer = c(4,4,4)

# Let us construct and train the neural network
set.seed(5)
NN = neuralnet(formattedtrainclass~., trainvalues, hidden = hiddenLayer , 
               threshold = 0.01, stepmax = 1e+5, linear.output = FALSE)
plot(NN)
