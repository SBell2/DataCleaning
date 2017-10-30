 
#Getting and Cleaning Data Week 4 Project\

\
The purpose of this project was to merge and tidy the datasources based on : "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
\
The zip file for this project can be downloaded here:\
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
\

The script in this repo contains notes about the intention of each section of code. In summary, the data is loaded into R from the zip file, the files are given variable names and merged as necessary, variables pertaining to the mean or standard deviation are segmented out into a new data frame, and the variable names were cleaned based on the principles in the final week\'92s lecture. \
\
Finally, a separate data frame was created to give the average of each variable in the df created by the script above, based on activity and subject groups. \
\
