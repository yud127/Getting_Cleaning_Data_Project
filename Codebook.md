# Codebook



The codebook explains all step adopted to clean the data set in Run_Analysis R. Besides coding explanation, there are also *comments that records what I tried to do but did not work within the R script*. I used this as a way to record my progress but you can just ignore my comments. 



## Step 1: Set the working directory and load required packages

- Set the working directory in the computer
- Load three packages : "data.table", "plyr","dplyr"



## Step 2: download files

### 2.a

- download required zip file 

### 2.b

- check if file existed in the working directory

### 2.c

- unzip the file

## Step 3: Read existing files into R

### 3.a import files 

- Read the txt file with the function read.table
- **X_test**  : X_test.txt is imported into R and renamed as X_test.
- **Y_test** : Y_test.txt is imported into R and renamed as Y_test
- **Subject_test**: Subject_test.txt is imported into R and renamed as Subject_test.
- **X_train**  : X_train.txt is imported into R and renamed as X_train.
- **Y_train** : Y_traint.txt is imported into R and renamed as Y_train
- **Subject_train**: Subject_train.txt is imported into R and renamed as Subject_train.
- **activity_labels**: activity_labels.txt is imported into R and renamed as activity_labels
- **features** :features.txt is imported into R and renamed as features



### 3.b rename files

- X_train is matched with features dataset. 
- X_test is matched with feature dataset.
- The column name of Y_test is changed to "activitylabel"
- The column name of Y_train is changed to "activitylabel"
- The column name of Subject_train is changed to "SubjectID"
- The column name of Subject_test is changed to "SubjectID"



## Step4:  Merge datasets together

- Create a new data set **data_test** to combind all test data with function *cbind*
- Create a new data set **data_train** to combind all train data with function *cbind*
- Create a new data set **data_merge** to merge these two data sets together with function *rbind*
- Check the dimension of **data_merge**  [10299, 563]

## Step5: Extracts only the measurements on the mean and standard deviation for each measurement.

I tried to use one code to extract all together but the grepl did not work so I had to divided that into different datasets. 

- Create a new data set **data_extract** to extract columns with *mean* and *STD*  with *grepl* function
- Create a new data set **data_id** to extract column "activitylabel" with *grepl* function
- Create a new data set **data_subject** to extract column "subjectID"  with *grepl* function
- Combine all three data sets together and create a new data set **data_new**  with function *cbind*
- Name column 47 & 48 as "activitylabel" and " subjectID"

## Step 6: Name the activities in the data set

I tried to use some alternative ways to do this step, I made some comments in the R script

- Uses descriptive activity names to name the activities in the data set, reaplce activity label with activity names

## Step 7: labels the data set with descriptive variable names

Tried to remove ()  with gsub function but did not work so I cleaned as much as I could. I tried couple of codes and leave that as a comment.

- check the names of **data_new**
- Replace "-mean" with "mean" by using function gsub.
- Replace "Body Body"  with "Body " by using function gsub.



## Step 8: create an tidy dataset

- Create the final tidy dataset **data_final** and exported as txt file. 