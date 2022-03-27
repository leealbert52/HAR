# Coursera Courser 3 Week 4 programming assignment March 25, 2022

#STEP ONE############################################################
#library(data.table)
#library(dplyr)
#library(reshape2)

## set up working directory 
## ~/R exercises/Coursera/Course 3/HAR Data Management/
##        

#######################STEP TWO - Data management

## ACTIVITY data frame
###V1                 V2
###1            WALKING
###2   WALKING_UPSTAIRS
###3 WALKING_DOWNSTAIRS
###4            SITTING
###5           STANDING
###6             LAYING

activity <- data.table::fread("./UCI HAR Dataset/activity_labels.txt",
                 col.names = c("classLabels", "activityName"))

features <- data.table::fread("./UCI HAR Dataset/features.txt",
                  col.names = c("index", "featureNames"))

####### Search measures required
matches <- grep("(mean|std)\\(\\)", features[, featureNames]) 
measurements <- features[matches, featureNames]

### substitute all () without space 
measurements <- gsub('[()]', '', measurements)


############ Train dataset ############################################# 
## read in X_train data frame with V1-V561
train <- data.table::fread("./UCI HAR Dataset/train/X_train.txt")[, matches, with = FALSE]

data.table::setnames(train, colnames(train), measurements)

## dim(train) 7352 x 66

## read in y_train activity and give column name "Activity"
trainActivities <- data.table::fread("./UCI HAR Dataset/train/y_train.txt", col.names = c("Activity"))

## dim(trainActivities) 7352 x 1

## read in subject data and give SubjectNum
trainSubjects <- data.table::fread("./UCI HAR Dataset/train/subject_train.txt", col.names = c("SubjectNum"))

## dim(trainSubjects) 7352 x 1
## merge by column bind

train <- cbind(trainSubjects, trainActivities, train)

## dim(train) 7352 x 68

############# Test dataset ################################################
## read in test dataset with matched columns 2947 x 66

test <- data.table::fread("./UCI HAR Dataset/test/X_test.txt")[, matches, with = FALSE]

## set column names 
data.table::setnames(test, colnames(test), measurements)

## read in test Activities

testActivities <- data.table::fread("./UCI HAR Dataset/test/y_test.txt", col.names = c("Activity"))

##dim(testActivities) 2947 x 1

## read in test Subjects

testSubjects <- data.table::fread("./UCI HAR Dataset/test/subject_test.txt", col.names = c("SubjectNum"))

## dim(testSubjects)

## merge by clumn bind testSubjects, testActivities, test

test <- cbind(testSubjects, testActivities, test)

## dim(test) 2947 x 68

############################ merge train and test datasets  10299 x 68
## concatenate by row bind

complete <- rbind(train, test)

## dim(complete) 10299 x 68

####################################################################################################
# classLabels to activityName.
 
complete[["Activity"]] <- factor(complete[, Activity]
                              , levels = activity[["classLabels"]]
                              , labels = activity[["activityName"]])

complete[["SubjectNum"]] <- as.factor(complete[, SubjectNum])

library(reshape2)
## melt

complete <- reshape2::melt(data = complete, id = c("SubjectNum", "Activity"))

##dcast
complete <- reshape2::dcast(data = complete, SubjectNum + Activity ~ variable, fun.aggregate = mean)

###################################################################################################
## output a Tidy dataset

data.table::fwrite(x = complete, file = "tidyData.csv", quote = FALSE)








############################################################################################

## TEST df
### X_test: 2947 x 561 variables V1 - V561

test_x <- data.table::fread("./test/X_test.txt")

### y_test: 2947 x V1
test_y <- data.table::fread("./test/y_test.txt")

### SUBJECT Names
subj_test <- data.table::fread("./test/subject_test.txt")

### column bind 2 data frames
testData <- cbind(test_x, test_y)







## TRAIN df
### X_train : 7352 x V561

train_x <- data.table::fread("./train/X_train.txt")

### y_train
train_y <- data.table::fread("./train/y_train.txt")

### column bind two data frames
trainData <- cbind(train_x, train_y)

## CONCATENATE TEST df and TRAIN df (10299 x 562)

myDf <- rbind(testData, trainData)

###################STEP THREE
### Add column header comes from features.txt

HAR_header <- data.table::fread("./features.txt")

names <- append(HAR_header[[2]], "activity")  #561 + 1 columns

colnames(myDf) <- names

head(myDf)

###################STEP FOUR
## search toMatch expression in the column names

toMatch <- c("-mean()", "-meanFreq()","-std()",
               "tBodyAccMean", 
               "gravityMean")

matches <- append(unique(grep(paste(toMatch,collapse="|"), names, value=TRUE)) + "activity")

###########################END of DATA MANAGEMENT

### dim(myDf1) 10299 X 87
myDf1 <- myDf[, ..matches]

### merge with activity table by by.x="activity", by.y="V1"


##STEP FIVE
library(reshape)









myDf %>% select(







write.csv(testData, "test_out.csv")



