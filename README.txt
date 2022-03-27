## This is a README file for the HAR Data Management project

Step 1
Create activity and features data frames by data.table::read function

Step 2 
Match the columns required from the 561 features by searching regular expression we learn in this class; fixing some texts

Step 3
Create train data frame by data.table package, column bind train Subjects, train Activity and features data farmes

Create test data frame by data.table package, column bind test Subjects, test Activity and features data frames

Row bind train and test data frames to get the Subjects, Activities, and features

Step 4
Melt and d-cast so that the final TidyData set has 
180 x 68 (30 subjects, 6 activities, 66 columns)



