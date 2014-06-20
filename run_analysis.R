# First of all we need some libraries to help us to transform data : reshape2.
library(reshape2)
# and a library to help us to split and combining data : Plyr.
library(plyr)

## Our objectives when transform the Samsung dataset:

## A: The observation of each variable should be in a different row.
## B: Each variable should be in one column.
## C: Include id's to link tables.

## set our base directory and create an empty dataset.
root.dir <- "UCI HAR Dataset"
data.set <- list()

## Now we are going to merge the test-set and the training-set and create one new dataset.

## Loading the activity features in a dataset.
message("Read table activity_features.txt into dataset")
data.set$activity_labels <- read.table(paste(root.dir, "activity_labels.txt", sep="/"), col.names=c('id', 'Activity'))

## Loading the features in a dataset.
message("Read table features.txt into dataset")
data.set$features <- read.table(paste(root.dir, "features.txt", sep="/"), col.names=c('id', 'name'), stringsAsFactors=FALSE)

## Loading train data into dataset.
message("Read tables: subject_train.txt, y_train.txt and X_train.txt and load these into dataset")
data.set$train <- cbind(subject=read.table(paste(root.dir, "train", "subject_train.txt", sep="/"), col.names="Subject"),
                        y=read.table(paste(root.dir, "train", "y_train.txt", sep="/"), col.names="Activity.ID"),
                        x=read.table(paste(root.dir, "train", "X_train.txt", sep="/")))

## Loading test data into dataset.
message("Read tables: subject_test.txt, y_test.txt and X_test.txt and load these into dataset")
data.set$test <- cbind(subject=read.table(paste(root.dir, "test", "subject_test.txt", sep="/"), col.names="Subject"),
                       y=read.table(paste(root.dir, "test", "y_test.txt", sep="/"), col.names="Activity.ID"),
                       x=read.table(paste(root.dir, "test", "X_test.txt", sep="/")))


## renaming the labels of the feature dataset using gsub - replacing all occurences
rename.features <- function(labels) {
    labels <- gsub("tBody", "Time.Body", labels)
    col <- gsub("tGravity", "Time.Gravity", labels)
    
    labels <- gsub("fBody", "FFT.Body", labels)
    labels <- gsub("fGravity", "FFT.Gravity", labels)
    
    labels <- gsub("\\-mean\\(\\)\\-", ".Mean.", labels)
    labels <- gsub("\\-std\\(\\)\\-", ".Std.", labels)
    
    labels <- gsub("\\-mean\\(\\)", ".Mean", labels)
    labels <- gsub("\\-std\\(\\)", ".Std", labels)
    
    return(labels)
}


##  We only extract the following measurements: the mean and standard deviation for each measurement.

tidy <- rbind(data.set$test, data.set$train)[,c(1, 2, grep("mean\\(|std\\(", data.set$features$name) + 2)]

## Uses descriptive activity names to name the activities in the data set

names(tidy) <- c("Subject", "Activity.ID", rename.features(data.set$features$name[grep("mean\\(|std\\(", data.set$features$name)]))

## We are changing the labels the data set with descriptive activity names.

tidy <- merge(tidy, data.set$activity_labels, by.x="Activity.ID", by.y="id")
tidy <- tidy[,!(names(tidy) %in% c("Activity.ID"))]

## We will Create a new and independent tidy data set with the average of each variable for each activity and each subject.

tidy.mean <- ddply(melt(tidy, id.vars=c("Subject", "Activity")), .(Subject, Activity), summarise, MeanSamples=mean(value))

write.csv(tidy.mean, file = "tidy.mean.txt",row.names = FALSE)
write.csv(tidy, file = "tidy.txt",row.names = FALSE)

message("2 new datasets have been placed in the workingdirectory named: tidy.mean.txt and tidy.txt")
