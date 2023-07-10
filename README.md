# R-Classifiers

This repository highlights different methods of Machine Learning used in Artificial Intelligence, programmed in R as part of a set of academic exercises. Each folder contains the examples of Unsupervised Learning (K-Means Clustering, Nearest Neighbour, Agglomerative Clustering and Apriori) and Supervised Learning (Decision Trees and Neural Networks). The ReadMe serves as a brief overview of each algorithm used.

<h2> Clustering Methods </h2>
<p> To partition a dataset into subsets (known as Clusters), so that the data in each subset share some common trait - often proximity or similarity for some defined distance measurement. A cluster is therefore a collection of objects where the constituents are somewhat similar to each other and are disimilar to objects belonging in another cluster. It can see usage in scenarios that include Social networks, marketing, resource allocation, customer segregation and more. </p>

<p> Distance is a metric used to measure similarity and disimilarity between datapoints. Different types of distance metrics can be used which also yield different results. These can include the typical Euclidean distance (which can be considered as the magnitude of the vectors) or the Manhattan distances which are the sum of all the absolute differences of the vectors. There should be some careful consideration on which distance metric should be used before applying the selected Clustering algorithm. </p>

<h3>K-Means Clustering</h3>
<p> K-Means clustering involves placing K points into the feature space which will function as a cluster's centroid. The algorithm then iteratively places each data into the closest cluster before the centroid is recalculated. This is then repeated until the maximum number of iterations is run or that there is no change in centroid position. This can be advantageous as the algorithm is typically faster than other clustering algorithms and can produce tighter clusters, useful for 'globular' datasets. </p>

<p> However, due to the fixed number of clusters, the results depend entirely on the chosen K-Value and hence may require some trial and error before finding an optimal clustering. Different initial partitions (due to the K points being randomly chosen at the start) can also result in different clusterings. There also exists the probability of producing empty clusters - not necessarily a bad indication. Typically, this algorithm should be avoided for non-globular datasets.</p>

<h3> Agglomerative / Heirarchical Clustering </h3>
<p> Agglomerative Clustering Results in a series of clustering results where all results start off with each object in it's own cluster and end with all of the objects in the same cluster. Intermediate clusters are created by a series of pairs or merges, creating a tree-like plot. The resultant tree like structure is called a Dendogram. This can be advantageous for non-globular datasets, can produce ordering of how clusters form and generates smaller initial clusters which can be critical for data discovery. However, this comes with the disadvantage of not being able to regroup datapoints which may have incorrectly been clustered initially, as well as being parameter specific - different approaches of agglomerative clustering will yield different results. </p>

<p> At the start of the algorithm, each item is assigned to its own cluster (n clusters of size one) and let the distances between the clusters equal the distances between the objects they contain. The algorithm then iteratively finds the closest pair of clusters and merge them into a single cluster (one less cluster) and then re-computes the distances between the new cluster and each of the old clusters (this can also be dependent on the linkages used which will be explained) until one cluster is left. </p>

<p> The type of linkage used can also determine the distances between each cluster where: </p>
<ul>
     <li> Single Linkage is the shortest distance between two clusters (as clusters may contain many nodes) </li>
     <li> Average Linkage is the distance between the average centroids between two clusters</li>
     <li> Complete Linkage is the largest distance between two clusters</li>
</ul>

<h2> Apriori Algorithm </h2>
<p>Apriori algorithm is an algorithm that is typically run on shopping basket data to generate rules about sets of items and their relation to each other - namely deriving 3 values called Support, Lift and Confidence from the sets of items. One such example is that a large chain finding a correlation between two unseemingly related items - beer bottles and diapers - which were often bought together. From here a business could aim to change a strategy to further capitalise on this correlation, such as physically placing the two items closer together, or by bundling the two items together and offering a discount (although this may seem a bit taboo). </p>

<p> Support defines how often an item appears in a set whilst confidence is a measure of how often the rule is found to be true. Lift is generated from both the support and confidence value. The following shows the output of our Apriori.r script on our shopping basket data. We can see the likelihood of the item on the RHS column being bought given the current LHS set. Note this does not mean the inverse! [Given citrus fruit and root vegetables, people are more likely to buy other vegetables BUT given other vegeatables, this does not mean people are likely to buy citrus fruit and root vegetables.] </p>

```
[1] "Transactions sorted by confidence"
> inspect(head(sort(grocery_rules, by = 'confidence'), 15))
     lhs                     rhs                   support confidence   coverage     lift count
[1]  {citrus fruit,                                                                            
      root vegetables}    => {other vegetables} 0.01037112  0.5862069 0.01769192 3.029608   102
[2]  {tropical fruit,                                                                          
      root vegetables}    => {other vegetables} 0.01230300  0.5845411 0.02104728 3.020999   121
[3]  {curd,                                                                                    
      yogurt}             => {whole milk}       0.01006609  0.5823529 0.01728521 2.279125    99
[4]  {other vegetables,                                                                        
      butter}             => {whole milk}       0.01148958  0.5736041 0.02003050 2.244885   113
[5]  {tropical fruit,                                                                          
      root vegetables}    => {whole milk}       0.01199797  0.5700483 0.02104728 2.230969   118
[6]  {root vegetables,                                                                         
      yogurt}             => {whole milk}       0.01453991  0.5629921 0.02582613 2.203354   143
[7]  {other vegetables,                                                                        
      domestic eggs}      => {whole milk}       0.01230300  0.5525114 0.02226741 2.162336   121
[8]  {yogurt,                                                                                  
      whipped/sour cream} => {whole milk}       0.01087951  0.5245098 0.02074225 2.052747   107
[9]  {root vegetables,                                                                         
      rolls/buns}         => {whole milk}       0.01270971  0.5230126 0.02430097 2.046888   125
[10] {pip fruit,                                                                               
      other vegetables}   => {whole milk}       0.01352313  0.5175097 0.02613116 2.025351   133
[11] {tropical fruit,                                                                          
      yogurt}             => {whole milk}       0.01514997  0.5173611 0.02928317 2.024770   149
[12] {other vegetables,                                                                        
      yogurt}             => {whole milk}       0.02226741  0.5128806 0.04341637 2.007235   219
[13] {other vegetables,                                                                        
      whipped/sour cream} => {whole milk}       0.01464159  0.5070423 0.02887646 1.984385   144
[14] {root vegetables,                                                                         
      rolls/buns}         => {other vegetables} 0.01220132  0.5020921 0.02430097 2.594890   120
[15] {root vegetables,                                                                         
      yogurt}             => {other vegetables} 0.01291307  0.5000000 0.02582613 2.584078   127
```
