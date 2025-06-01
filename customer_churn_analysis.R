install.packages("tidyverse") 
library(tidyverse)

#Step-1 LOAD AND CLEAN THE DATASET

#read the dataset
data <- read.csv("WA_Fn-UseC_-Telco-Customer-Churn.csv")

# Check structure
str(data)

# Convert TotalCharges to numeric (handle blanks)
data$TotalCharges <- as.numeric(as.character(data$TotalCharges))

# Remove rows with NA
data <- na.omit(data)



#------------------------------------------------------------------------------------------------------


#Step-2 EDA (EXPLORATORY DATA ANALYSIS)

library(ggplot2)

# Churn count plot
ggplot(data, aes(x = Churn, fill = Churn)) +
  geom_bar() +
  labs(title = "Churn Distribution", x = "Churn", y = "Count") +
  theme_minimal()

# Churn by contract
ggplot(data, aes(x = Contract, fill = Churn)) +
  geom_bar(position = "fill") +
  labs(title = "Churn by Contract Type", y = "Proportion") +
  scale_y_continuous(labels = scales::percent) +
  theme_minimal()

# Monthly Charges by churn
ggplot(data, aes(x = Churn, y = MonthlyCharges, fill = Churn)) +
  geom_boxplot() +
  labs(title = "Monthly Charges by Churn", y = "Monthly Charges") +
  theme_minimal()


#-----------------------------------------------------------------------------------------------------------

#Step-3 BUILD LOGISTIC REGRESSION MODEL

# Convert Churn to binary
data$Churn <- ifelse(data$Churn == "Yes", 1, 0)

# Split into train/test
set.seed(123)
index <- sample(1:nrow(data), 0.7 * nrow(data))
train <- data[index, ]
test <- data[-index, ]

# Build model
model <- glm(Churn ~ tenure + MonthlyCharges + TotalCharges + Contract, data = train, family = binomial)

# Predict probabilities
test$churn_prob <- predict(model, test, type = "response")


#----------------------------------------------------------------------------------------------------------

#Step-4 CREATE CHURN RISK CATEGORIES AND EXPORT FOR TABLEAU

# Round probabilities
test$churn_prob <- round(test$churn_prob, 3)

# Risk category
test$risk <- ifelse(test$churn_prob > 0.7, "High",
                    ifelse(test$churn_prob > 0.4, "Medium", "Low"))

# Export for Tableau
write.csv(test, "churn_predictions.csv", row.names = FALSE)


#----------------------------------------------------------------------------------------------------------

#Step-5 Bonus ggplot – Visualize Churn Risk from Model

# Risk distribution
ggplot(test, aes(x = risk, fill = risk)) +
  geom_bar() +
  labs(title = "Customer Churn Risk Levels", x = "Risk Category", y = "Number of Customers") +
  theme_minimal()

# Probability density
ggplot(test, aes(x = churn_prob, fill = as.factor(Churn))) +
  geom_density(alpha = 0.5) +
  labs(title = "Churn Probability Density", x = "Churn Probability", fill = "Actual Churn") +
  theme_minimal()
