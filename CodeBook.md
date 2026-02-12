We have stored the parameters given in the 'features.txt' file in the variable 'features'.
Similarly, we have stored the names of the activities given in the 'activity_labels.txt' file in the variable 'activity'.

We then open the directories 'test' and 'train' and collect the required data stores in them in dataframes named 'test_ds' and 'training_ds' respectively.

01
We then combine both the dataframes as per given problem using thr rbind() function.


04
We then give the columns label according to the names stored in the 'features' varible. The first two columns have been named 'subject' and 'activity' respectively.


02
We then extract only the parameters from the column which store mean or standard devaition of some value.
This is done using grepl() function, which checks whether the substrings 'mean' or 'std' are contained in the individual column names.
The two 'TRUE' at the start is just for the columns 'subject' and 'activity', which we nevertheless need to select.


03
We then replace the activity names(which are till now represented by numbers from 1 to 6) by the labels stored in the variable 'activities' accordingly.


05
We then split the data frame according to each unique subject, activity pair using the split() function.
This returns a list containing dataframes, each with same subject, activity pair
We store this list in the variable called 'split_ds'.
We define a new dataframe 'average_ds' of suitable length with no rows; we will use this to store the average of the parameters for each subject, activity pair.
We run a for loop to iterate over all dataframes of the the split_df list; and each time we take mean of the column values(i.e parameters) and bind it as a new entry in 'average_ds' along with the corresponding subject and activity.
We again give names to the columns of this new dataframe accordingly like before.
We convert the subject values(which are stored as characters) to numeric; then arrange it in ascending order using the arrange() function from dplyr library. This is done for the data to look tidy and well-organised.
At last, we store this dataframe in a text file named as 'tidydata.txt'.
