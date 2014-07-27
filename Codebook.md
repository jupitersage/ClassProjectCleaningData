codebook.md
the codebooks available to you with the data to indicate all
 the variables and summaries you calculated, along with units,
 and any other relevant information?
 
 What are the variable names?
 What are the units of the variables
 What is the meaning of the variable?
 
 Descriptive names were applied to the columns and 
 I subset  only the columns to do with mean or standard deviation.
 
 
 Only one script was used.
 How I put the data together?
 
 cbind () was used to combine the columns together.
 For joining training to test rbind() was used to merge the training and test
 set to create one big data set.
 With the 6 Activity labels, they were subset first and applied 6 times.
 
 rbind () was used to combine both of then to one .
 
 
 What were the functions used to read the file in R? 
 
 for #1 -  this data can be read in R with the command read.table(features.txt, header= FALSE)
 
 for #2  - the data set was labled "features.txt" and read.table was used to read the file into R.
 
 for #3 - Add Activity, read.table(), data.frame (), rbind() and cbind was used to read the file
 into R. y_train and y_test were some of the files used.
 
 for #4 - the steps were the same as #3 but different data frames and tables like
 subject_train and subject_test were used. rbind was used to bind the rows and 
 cbind was used to bind the columns.
 
 
 for #5 What did you do to the entries that include mean and std?
 The subset function was used to extract only mean and std so only 
 this subset of variables had to be named. grep() was  used to extract this subset.
 
 for #6 - the 2nd data set is called results_df_trimmed and was passed to a 
 variable called features_trimmed.
 I looped thru the subject list and extracted onse subject set at a time.
 
 
 The activity numbers for mean and std were replaced with descriptive terms as seen in 
 features.txt
 
 How did you modify the column names? inside R or outside R as in parsed the file manually.
 The columns were modified inside R using grep()
 