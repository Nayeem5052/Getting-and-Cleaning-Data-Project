features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")

## Opening the directory 'test' which contains the test data

file_paths <- list.files(path = "test/", pattern = "\\.txt$", full.names = TRUE)
file_paths <- file_paths[c(1, 3, 2)]
test_ds <- as.data.frame(sapply(file_paths, read.table))
names(test_ds) <- c("subject", "activity", features[[2]])

## Similarly, opening the directory 'train' which contains the training data

file_paths <- list.files(path = "train/", pattern = "\\.txt$", full.names = TRUE)
file_paths <- file_paths[c(1, 3, 2)]
training_ds <- as.data.frame(sapply(file_paths, read.table))
names(training_ds) <- c("subject", "activity", features[[2]])


## 01
## Merges the training and the test sets to create one data set.

combined_ds <- rbind(training_ds, test_ds)



## 04
## Appropriately labeling the data set with descriptive variable names. 

colnames(combined_ds) <- c("subject", "activity", features[[2]])



## 02
## Extracting only the measurements on the mean and standard deviation for each measurement. 

extracted_ds <- combined_ds[, c(TRUE, TRUE, grepl("mean", names(combined_ds)) | grepl("std", names(combined_ds)))]



## 03
## Using descriptive activity names to name the activities in the data set

extracted_ds[, 2] <- activity[extracted_ds$activity, 2]




library(dplyr)
extracted_ds <- arrange(extracted_ds, subject)

## Splitting the dataframe according to unique subject, activity pair
split_ds <- split(extracted_ds, f = list(extracted_ds$subject, extracted_ds$activity))



## 05
## From the data set in step 4, creating a second, independent tidy data set with the average 
## of each variable for each activity and each subject

average_ds <- data.frame(matrix(nrow = 0, ncol = length(extracted_ds)))
colnames(average_ds) <- colnames(extracted_ds)

for (df in split_ds) {
    average_ds <- rbind(average_ds, c(df$subject[1], df$activity[1], colMeans(df[, 3:length(extracted_ds)])))
}

colnames(average_ds) <- colnames(extracted_ds)
average_ds[, 1] <- as.numeric(average_ds[, 1])
average_ds <- arrange(average_ds, subject)

write.table(average_ds, file = "tidydata.txt", row.names = FALSE)
