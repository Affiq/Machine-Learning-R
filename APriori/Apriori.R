#ASSOCIATION RULES
#Adapted from https://towardsdatascience.com/association-rule-mining-in-rddf2d044ae50
library(arules)
#Read in Groceries data
data('Groceries')



#inspect first 10 transactions
print("First 3 transactions in Groceries")
inspect(head(Groceries, 3))


#Apriori Algorithm - generate rules using entire grocery list
print("Performing apriori algorithm")
grocery_rules <- apriori(Groceries, parameter = list(support = 0.01, confidence = 0.5))#


#Inspect first 3 Rules sorted by confidence
print("Transactions sorted by confidence")
inspect(head(sort(grocery_rules, by = 'confidence'), 15))
# Minval - minimum value of Support of an item to be considered as a rule
# smax - maximum support vlaue for an item set
# arem - Additional Rule Evaluation Parameter. Method of constraining rules.
# aval - Logical indicating whether to return additional rule evluation measure
#         selected with arem
# originalSupport - Traditional support value considers both LHS and RHS items
#         for calculating support
# maxtime - the maximum amount of time allowed for checking subsets 
# minlen - minimimum number of items required in a rule
# maxlen - maximum number of items required in a rule


# Lift is generated using the parameters Support and Confidence
# Support represents how often an item appears in the transactions/ entire dataset
# Confidence represents how often the rule has been found to be true - after rule generation