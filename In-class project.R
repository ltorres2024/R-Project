# Load necessary libraries
library(ggplot2)
library(caret)
library(corrplot)
library(class)
library(readr)

# Load the business data
business <- read.csv("~/Library/CloudStorage/OneDrive-UniversityofMountUnion/DSC 140 Fall 2024/OA 11.7 - yelp_academic_dataset_business.json.csv")

# Print the first five rows of the business data
head(business, 5)

# Bar chart of business count by state
ggplot(business) +
  geom_bar(aes(x = state), fill = 'darkgreen') +
  labs(title = "Number of Businesses by State", x = "State", y = "Count")

# Create a table of star ratings
star_counts <- table(business$stars)

# Generate the pie chart for star ratings
pie(star_counts, main = "Distribution of Star Ratings", col = rainbow(length(star_counts)))

# Box plot of review counts by star rating
ggplot(business) +
  geom_boxplot(aes(x = as.factor(stars), y = review_count), fill = "lightblue") +
  labs(title = "Box Plot of Review Count by Star Rating", x = "Star Rating", y = "Review Count")

# Perform chi-squared test between stars = 1.0 and stars = 5.0
stars_1 <- subset(business, stars == 1.0)
stars_5 <- subset(business, stars == 5.0)

# Create a table comparing counts
review_table <- table(c(rep(1, nrow(stars_1)), rep(5, nrow(stars_5))))

# Perform chi-squared test
chi_test <- chisq.test(review_table)

# Print the result of the chi-squared test
print(chi_test)

# Load the user data
user <- read.csv("~/Library/CloudStorage/OneDrive-UniversityofMountUnion/DSC 140 Fall 2024/OA 11.6 - yelp_academic_dataset_user.json.csv")

# Print column names of the user data
colnames(user)
View(user)
# Calculate the correlation matrix for votes
cor_matrix <- cor(user[, c("cool_votes", "funny_votes", "useful_votes")], use = "complete.obs")

# Print and visualize the correlation matrix
print(cor_matrix)
corrplot(cor_matrix, method = "shade", type = "lower", title = "Correlation Matrix of Votes")

# Linear regression of useful_votes vs cool_votes
lm_model <- lm(useful_votes ~ cool_votes, data = user)
summary(lm_model)

# Equation of the fit line
intercept <- coef(lm_model)[1]
slope <- coef(lm_model)[2]
cat("Equation of the line: useful_votes = ", round(intercept, 2), " + ", round(slope, 2), "* cool_votes\n")

# Plot the linear regression
ggplot(user, aes(x = cool_votes, y = useful_votes)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", col = "red") +
  labs(title = "Linear Regression of Useful Votes vs. Cool Votes", x = "Cool Votes", y = "Useful Votes")

# Linear regression for review_count and fans
lm_fans <- lm(fans ~ review_count, data = user)
summary(lm_fans)

# Plot the regression for review_count and fans
ggplot(user, aes(x = review_count, y = fans)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", col = "blue") +
  labs(title = "Linear Regression of Fans vs. Review Count", x = "Review Count", y = "Fans")

# Linear regression for fans and another variable
lm_fans_votes <- lm(fans ~ useful_votes, data = user)
summary(lm_fans_votes)

# Plot the regression for fans and useful_votes
ggplot(user, aes(x = useful_votes, y = fans)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", col = "green") +
  labs(title = "Linear Regression of Fans vs. Useful Votes", x = "Useful Votes", y = "Fans")

# Normalize the data first since k-means is sensitive to the scale of the data
user_normalized <- preProcess(user[, c("review_count", "fans")], method = "range")
user_norm_data <- predict(user_normalized, user[, c("review_count", "fans")])

# Perform k-means clustering with 3 clusters
set.seed(123)
kmeans_result <- kmeans(user_norm_data, centers = 3)

# Add cluster assignments to the data
user_norm_data$cluster <- as.factor(kmeans_result$cluster)

# Plot clusters for review_count and fans
ggplot(user_norm_data, aes(x = review_count, y = fans, color = cluster)) +
  geom_point() +
  labs(title = "K-Means Clustering of Review Count and Fans", x = "Review Count", y = "Fans")

