run_analysis <- function()
{
    # Course Project Description

    # R script requirements:
    # ---------------------------------------------------------------------------------------------------------------------
    # You should create one R script called run_analysis.R that does the following. 
    # 1. Merges the training and the test sets to create one data set.
    # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    # 3. Uses descriptive activity names to name the activities in the data set
    # 4. Appropriately labels the data set with descriptive variable names. 
    # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
    # ---------------------------------------------------------------------------------------------------------------------

    
    # ---------------------------------------------------------------------------------------------------------------------
    # 1. Read in the training and the test sets and merge them into one data set (req # 1).
    # ---------------------------------------------------------------------------------------------------------------------
    x_train_file <- read.table("train/X_train.txt", header=FALSE, strip.white=TRUE)
    x_train_df <- data.frame( x_train_file )
    x_test_file <- read.table("test/X_test.txt", header=FALSE, strip.white=TRUE)
    x_test_df <- data.frame( x_test_file )
    result_df_all <- rbind(x_train_df, x_test_df)


    # ---------------------------------------------------------------------------------------------------------------------
    # 2. Label the data set (req #2)
    # ---------------------------------------------------------------------------------------------------------------------
    features <- read.table("features.txt", header=FALSE, strip.white=TRUE)
    colnames(result_df_all) <- features[,2]

    
    # ---------------------------------------------------------------------------------------------------------------------
    # 3.  Add activities (req #3)
    # ---------------------------------------------------------------------------------------------------------------------
    # Read in & combine the train and test activity files and label them with activity names. Then combine
    # them with the data set.
    train_activity_file <- read.table("train/y_train.txt", header=FALSE, strip.white=TRUE)
    train_activity_df <- data.frame( train_activity_file )
    test_activity_file <- read.table("test/y_test.txt", header=FALSE, strip.white=TRUE)
    test_activity_df <- data.frame( test_activity_file )
    activities <- rbind(train_activity_df, test_activity_df)
    activity_labels <- read.table("activity_labels.txt", header=FALSE, strip.white=TRUE)
    activities$V1[activities$V1 == 1] <- as.character(activity_labels[1,2])
    activities$V1[activities$V1 == 2] <- as.character(activity_labels[2,2])
    activities$V1[activities$V1 == 3] <- as.character(activity_labels[3,2])
    activities$V1[activities$V1 == 4] <- as.character(activity_labels[4,2])
    activities$V1[activities$V1 == 5] <- as.character(activity_labels[5,2])
    activities$V1[activities$V1 == 6] <- as.character(activity_labels[6,2])
    colnames(activities) <- c("Activity")
    result_df_all <- cbind(activities, result_df_all)

    # ---------------------------------------------------------------------------------------------------------------------
    # 4.  Add subjects
    # ---------------------------------------------------------------------------------------------------------------------
    # Read in the training and test subjects. label them, and add them to the data set.
    train_subject_file <- read.table("train/subject_train.txt", header=FALSE, strip.white=TRUE)
    train_subject_df <- data.frame( train_subject_file )
    test_subject_file <- read.table("test/subject_test.txt", header=FALSE, strip.white=TRUE)
    test_subject_df <- data.frame( test_subject_file )
    subjects <- rbind(train_subject_df, test_subject_df)
    colnames(subjects) <- c("Subject")
    result_df_all <- cbind(subjects, result_df_all)

    
    # ---------------------------------------------------------------------------------------------------------------------
    # 5. Extract just the mean and standard deviation features (req #2)
    # ---------------------------------------------------------------------------------------------------------------------
    mean_indexes <- grep("mean\\(\\)", features[,2])
    std_indexes <- grep("std\\(\\)", features[,2])
    indexes <- c(mean_indexes, std_indexes)
    result_df_trimmed <- subset(result_df_all, select=indexes)


    
    # ---------------------------------------------------------------------------------------------------------------------
    # 6. Find the variable averages for each subject/activity entry and place the output in a second data set (req #5)
    # ---------------------------------------------------------------------------------------------------------------------

    # Create the second data set and add labels
    features_trimmed <- names(result_df_trimmed)
    tidy_m <- matrix(ncol=length(features_trimmed))
    colnames(tidy_m) <- features_trimmed
    tidy_df <- data.frame(tidy_m)

    # Now populate the second data set by averaging subject/activity entries from the first data set, and then
    # adding the average as an entry in the second data set.
    
    # Iterate (loop) through the subject list and extract one subject set at a time
    row_idx = 1
    subject_list <- unique(subjects)
    for ( s in 1:nrow(subject_list) )
    {
        # Extract all entries for a subject
        sub <- result_df_trimmed[ result_df_trimmed$Subject == subject_list[s,1], ]

        # Iterate through the subject set and extract one activity set at a time
        for ( a in 1:nrow(activity_labels) )
        {
            # Extract all entries for an activity
            sub_act <- sub[ sub$Activity == activity_labels[a,2], ]

            # Now add a row to the second data set containing averages for this subject/activity:
            # (a) Add the subject and activity to the second dataset for this activity/subject entry 
            tidy_df[row_idx,1] <- subject_list[s,1]
            tidy_df[row_idx,2] <- as.character(activity_labels[a,2])

            # (b) For this activity/subject set, iterate through the features and calculate an
            # an average for each feature. Then add the averages to the row in the second data set.
            # set to represent this subject/activity set.
            for ( f in 3:length(features_trimmed) )
            {
                tidy_df[row_idx,f] <- mean( sub_act[, features_trimmed[f]] )
            }
            row_idx <- row_idx + 1
        }
    }
    
    # Lastly, write out the second data set to a file
    write.table(tidy_df, file="tidy_data.txt")
}
