# R-Classifiers

This repository highlights different methods of Machine Learning used in Artificial Intelligence, programmed in R as part of a set of academic exercises. Each folder contains the examples of Unsupervised Learning (K-Means Clustering, Agglomerative Clustering and Apriori) and Supervised Learning (Decision Trees, Nearest Neighbour and Neural Networks). The ReadMe serves as a brief overview of each algorithm used.

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

<h3> Fuzzy Clustering </h3>
<p> Both clustering methods introduce the problem of only belonging to one cluster, in cases of equal probability of going to a cluster, the data will eventually diverge towards one. Fuzzy Clustering can be used where a cluster membership can be a weight between 0 and 1 to determine the 'likeness' to the cluster. The most notable Fuzzy Clustering method is known as the Fuzzy C-Means which is a 'fuzzification' of the K-Means algorithm.</p>

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
...
```

<h2> Decision Trees </h2>
<p> Data can be classified by creating a decision tree from a training set (the most popular method). Nodes in the tree represent decisions while arcs represent possible answers. Each terminal node (leaf node) represent a classification of our data. Once our tree is formed, we can start classifying data by traversing starting from the root node and following the correct branches depending upon the decision. Following these rules, the algorithm will then reach a leaf node which represents the classification of our data. </p>

<p> Building our decision tree, often known as Rule Induction, involves splitting nodes until all elements belong to one class, in which they become terminal nodes. Different algorithms may be used to form these decision trees, but ID3 will be used in our examples as they incorporate an element of information gain (entropy) into the generation. </p>

<h3> Overfitting </h3>
<p> Often our model may be suitable for our training set but give incorrect classifications for our test set, which is an indication of overfitting to the data set. While one may opt to retrain or create a new model entirely, there exists methods to alter different models to compensate for this overfitting. In Decision Trees, this method is called 'Occam's Razor' which is used to prune undesirable decisions in our decision tree. Each leaf node is inspected and if it does not reduce classification accuracy for the training set, it is removed and thereby 'pruned'</p>

<h2> K-Nearest Neighbours</h2>
<p> - The KNN algorithm is a Case based reasoning algorithm that looks at the K nearest datapoints for unknown data which will be used to determine the classification of the data. Using this algorithm allows a visual slice of the feature space which can help determine the classification of future unknown data. It takes in a K parameter (the number of nearest neighbours) and the used distance metric. Much like the K-Means, determining the ideal K value is again an art-form as choosing a lower value may lead to inaccurate classification while too high of a value can tend to lead to overfitting (the feature space will diverge away from a linear slice). KNN may also be unsuitable to classify new datapoints which are far from other datapoints in the feature-space and cannot be used to determine their classification.</p>
