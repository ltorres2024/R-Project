# Yelp User Data Analysis in R – DSC 140

This project is part of a data analysis assignment for the DSC 140 course, using R to explore user data from the Yelp Academic Dataset. The goal was to practice data wrangling, correlation analysis, regression modeling, and clustering techniques.

## Overview

The script performs:
- Correlation analysis between user engagement metrics
- Multiple linear regression models
- K-means clustering of user behaviors
- Visualization of trends in user votes and review counts

## Visualizations

- **Correlation Matrix** of cool, funny, and useful votes
- **Linear Regression Plots** for:
  - Useful Votes vs. Cool Votes
  - Fans vs. Review Count
  - Fans vs. Useful Votes
- **K-Means Clustering Plot** for Review Count and Fans

## Key Insights

- There is a strong correlation between cool and useful votes.
- Fan count increases with review activity, but the trend is modest.
- K-means clustering revealed natural groupings in user engagement behavior.

## Tools Used

- `ggplot2`
- `caret`
- `corrplot`
- R base functions (`lm`, `chisq.test`, etc.)

>  **Note:** You must update the dataset file paths in the code to match your system in order to replicate the analysis.
