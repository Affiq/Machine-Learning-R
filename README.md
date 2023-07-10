# R-Classifiers

This repository highlights different methods of Machine Learning used in Artificial Intelligence, programmed in R as part of a set of academic exercises.

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
