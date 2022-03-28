This is a codebook for the HAR data management project for Corsera Data Science Specialization course 3 week 4 assignment.

There are 6 activities:
# ACTIVITY data frame
###V1                 V2
###1            WALKING
###2   WALKING_UPSTAIRS
###3 WALKING_DOWNSTAIRS
###4            SITTING
###5           STANDING
###6             LAYING

There are 30 subjects from the subjects from both subject_train and suject_test.

There are 561 features, from which 66 were identified using "(mean|std)\\(\\)" to match in grep() fuction call.

measurements <- gsub('[()]', '', measurements) was applied to the names of the columns.

There were not other manipulation of the data elements.