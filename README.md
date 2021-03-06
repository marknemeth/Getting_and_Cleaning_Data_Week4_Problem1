---
Course: " Getting and Cleaning Data"
title: "README.md (Project Requirement)"
author: "Mark Nemeth"
date: "5/23/2021 (Submission Date)"
---

# Peer-graded Assignment: Getting and Cleaning Data Course Project

#Instructions for the Project are stated here. (The intent and content of the required README file follow this section.)


The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

***Review criteria***

1. The submitted data set is tidy. 
2. The Github repo contains the required scripts.
3. GitHub contains a **code book** that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README (this file) that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.  

***Getting and Cleaning Data Course Project***

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 
1. a tidy data set as described below, 
2. a link to a Github repository with your script for performing the analysis, and 
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called ***CodeBook.md***. You should also include a ***README.md*** in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article [broken link] . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

You should create one R script called ***run_analysis.R*** that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Local Environment (Scripts, Data, Directories)

**Machine**  

This project was completed on an HP Spectre with an Intel(R) 8th Generation Core(TM) i7 CPU @ 1.80GHz and having 16.0 GB installed RAM, a 64-bit OS on an x86-based processor.  The operating system is Windows 10 Home, version 20H2, OS build 19042.985.

This md file and the R code usewd for this analysis are constructed from R markdown and R scripting built in an RStudio version 1.4.1106 implementation with R version 4.0.5 supporting.

**Directories and Files**  

This README.md (and its R markdown construction file), as wellas the analysis R script, "run_analysis.R" and the accompanting codebook, Codebook.md (and its R markdown construction file) reside locally in a project directory on the machine's local file system.

*scripts and documentation*  
               \<local drive>:\<path to coursera files>\\Data_Science\\Getting_and_Cleaning_Data\\Projects\\<This project>

The data for the course resides in...

*data directory*  
               \<local drive>:\<path to coursera files>\\Data_Science\\Getting_and_Cleaning_Data\\data

The run_analysis.R script holds the code that downloads the data files for the project, and study of concern.  This zipfile, when downloaded, is deposited by the code in this data directory, and it  has the name "getdata_projectfiles_UCI_HAR_Dataset.zip".



**UCI HAR Study subdirectory structure**  
  
Extracting the zip archive at the data directory parent node, creates the following directory substructure.

  \<local drive>:\<path to coursera files>\\Data_Science\\Getting_and_Cleaning_Data\\data  
       
       ___
        |
        | 
        |               
        |______/UCI HAR Dataset(folder)
                        |_____________/test(folder)
                        |               |
                        |               |-subject_test.txt
                        |               |-X_test.txt
                        |               |-Y_test.txt
                        |               /Inertial Signal (folder)
                        |                               |-body_acc_<coord.s>_test.txt
                        |                               |-body_gyro_<coord.s>_test.txt
                        |                               |-total_acc_<coord.s>_test.txt
                        |
                        |_____________/train(folder)
                        |               |-subject_train.txt
                        |               |-X_train.txt
                        |               |-Y_train.txt
                        |               /Inertial Signal (folder)
                        |                               |-body_acc_<coord.s>_train.txt
                        |                               |-body_gyro_<coord.s>_train.txt
                        |                               |-total_acc_<coord.s>_train.txt
                        |-activity_labels.txt
                        |-features.txt
                        |-features_info.txt
                        |-README.txt

***
## The Analysis

### Preliminaries

The project is primarily driven towards the creation of a tidy dataset that is formed from the test and training data compiled from the UCI HAR study.

The guidance for vocabulary, construction, and the philosophy and intention surrounding Tidy Data are drawn from Hadley Wickham's publication in the Journal of statistical Software, Volume VV, Issue II (http://www.jstatsoft.org/).  Here (https://vita.had.co.nz/papers/tidy-data.pdf), Section 1 introduces the impetus and some of the history behind the development of Tidy Data as matter of study, some of the author's own work, as well as that of others, in developing a framework and a suite of tools for advancing the pursuit.  In Sections 2 and 3, the paper defines Tidy Data and provides examples of "messy data" and how to tidy it.  Section 4 provides information regarding some of the current set of Tidy Tools available. And, Section 5 provides the procedures in moving from collecting messy data and manipulating it into tidy data; it also, instructs the reader in the necessary forms of documentation for the proper production and publication of a data science study (commented scripting, start-to-finish code, codebooks, variable name construction, readme files,...).  This is the guidance used in producing the needed work here.

The downloaded UCI HAR study and the consequent files have the following construction.  Thirty subjects were engaged in the study, and their activity and motions were recorded.  From the downloaded README.txt file indicated above, we have the following attributions for the study.

***  
Human Activity Recognition Using Smartphones Dataset  
Version 1.0  
==================================================================  
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  
Smartlab - Non Linear Complex Systems Laboratory  
DITEN - Universit? degli Studi di Genova.  
Via Opera Pia 11A, I-16145, Genoa, Italy.  
activityrecognition@smartlab.ws  
www.smartlab.ws  
***  

The study is described with the following language within the study's README.tx file.

        "The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
        
        The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
        
        For each record it is provided:
        ======================================
        
        - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
        - Triaxial Angular velocity from the gyroscope. 
        - A 561-feature vector with time and frequency domain variables. 
        - Its activity label. 
        - An identifier of the subject who carried out the experiment."
 
### Explanation of Files Used

The sensor signal files contain the lowest level readings from the study, and they are those found in the zip archive extraction under the subdirectories name "Inertial Signal".  These files have been processed according to the methodology descibed in the study README.txt, handling overlapping time windows of sensor samples, and performing (Fast) Fourier Transforms to present the time series information in a frequency domain, decomposing the total acceleration indications into body accelerations and gravitation accelerations, as well as the axial and x,y,z decompositions for some of the signaling.  These signal files under these numerous transformas and manipulations are eventually summarized in the training and test files found under directly within the "test" and "train" subfolders of the extracted archive's file hierarchy shown above.

The study was separated into a "test" sample (30%) and a "training" sample (70%), so the thirty (30) subjects of the study divided into two groups.  Subjects 2, 4, 9, 10, 12, 13, 18, 20, and 24 were assigned to the test sample compilation, while subjects 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, and 30 were assigned to the training sample.  The number of observations obtained from these subjects ranged from 288 to 381 for the test sample group, while the number for the training sample group ranged between 281 and 409.  This meant that the total number of test sample observations were 2,947, while the total number of observations made for the training sample was 7,352.  the X-test.txt and X-train.txt hold all the final, processed measurements from all of these observations within within the two samples; hence, the X-test.txt file contains 2,947 rows of data, and the X-train.txt file contains 7,352 rows of data.

Each of these observations' measurements pertain to a particular subject (among the 30 participants) yielding sensor indications during one of the six (6) activities they volunteered themselves for study: walking, walking upstairs, walking downstairs, sitting, standing, laying.

The X_test, y_test, and subject_test files all contain 2,947 rows. The y_test file has merely one column of information: the activity ID, where 1 = Walking, 2 = Walking Upstairs, ..., 6 = Laying.  The subject_test file,likewise, contains a single column of information: the subject ID (2, 4, 9, 10, ..., or 24).  The rows of the X-test, y_test, and subject_test files must be aligned side-by-side (cbind() operation in R), so that all measurements in the X_test file are identified with their proper subject performing the observed activity.

This same construction applies to all 7,352 rows found in the X_train, y_train, and subject_train files.

One item needs mentioning here: the activities in the y_test and y_train have only the IDs of the activities; in order to have the more descriptive labels, "walking", "walking upstairs", ..., "laying", within the observation row for each observation in the combined files (after row alignment and combining), the activity_labels.txt file found under the UCI HAR Dataset parent folder needed to be joined to the files on activity ID using the proper (left/right) outer (SQL) join.  (This will be drawn out better when we walk through the actual R scripting that performs this operation.)

The last set of files needing an overview are those in the archve's parent directory called "features.txt" and features_info.txt".  The features.txt contains two columns: an index column (intergers) and a measurements column.  The measurements column are the variable names used for all of the final, processed measurements for each of the observations in the X-test and X_train files.  There are 561 variable names, and each of the X_test and X-train has 561 columns of numeric entries.  These feature variable names must be aligned with the columns in the X-test and X-train files.  This is easily done in R once the X_test, X_train, and features files have been imported into proper dataframes.  Here is the code used for the assignement on the training sample.

```r
colnames(data_train)=features[["feature"]]
```

The features_info.txt file helps us undertsand exactly what each variable is measuring and whether it is an average, a standard deviation, a maximum value, a minimum value, an autoregression coefficient, an entropy calculation, an angle, etc.  As mentioned above, some processing involved taking measurements from the time-domain to a frequency-domain.  Variables with a "t" prefix are time-domain variables and the "f" prefix indicates a frequency-domain measure.  

**Measurments are:**  

1. tBodyAcc-XYZ
2. tGravityAcc-XYZ
3. tBodyAccJerk-XYZ
4. tBodyGyro-XYZ
5. tBodyGyroJerk-XYZ
6. tBodyAccMag
7. tGravityAccMag
8. tBodyAccJerkMag
9. tBodyGyroMag
10. tBodyGyroJerkMag
11. fBodyAcc-XYZ
12. fBodyAccJerk-XYZ
13. fBodyGyro-XYZ
14. fBodyAccMag
15. fBodyAccJerkMag
16. fBodyGyroMag
17. fBodyGyroJerkMag

The acceleration measurements have been decomposed into gravitational and body-movement, and this is a linear acceleration measurement.  When the linear acceleration has been impacted by angular velocity motion, this additional form of first-order displacement combined with the second-order linear acceleration displacement yields the measure for the third-order displacement of Jerk.  The angular displacement is sensed via "gyro".  Each of these Gyro, Acc and Jerk motions, either decomposed along the gravity aspect or the body have been further decomposed into x-coordinate measurement, y-coordinate measurement, and z-coordinate measurement.  So, the 17 measures listed above, in fact represent 33 measures; there being tBodyAcc-X, tbodyAcc-Y, and tBodyAcc-Z associated with the single listing of tBodyAcc-XYZ above.

These 33 measures, along with their 17 different aggregations in the X-test and X-train observations provide for the 33*17 = 561 column measures in thos X- files.

**Aggregations' List**  

1. mean(): Mean value
2. std(): Standard deviation
3. mad(): Median absolute deviation 
4. max(): Largest value in array
5. min(): Smallest value in array
6. sma(): Signal magnitude area
7. energy(): Energy measure. Sum of the squares divided by the number of values. 
8. iqr(): Interquartile range 
9. entropy(): Signal entropy
10. arCoeff(): Autorregresion coefficients with Burg order equal to 4
11. correlation(): correlation coefficient between two signals
12. maxInds(): index of the frequency component with largest magnitude
13. meanFreq(): Weighted average of the frequency components to obtain a mean frequency
14. skewness(): skewness of the frequency domain signal 
15. kurtosis(): kurtosis of the frequency domain signal 
16. bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
17. angle(): Angle between to vectors.

### Limit the analysis file to only the "mean" and "std" variables.

The following is a sample of the total listing of measures found in the X_ files.

**tBodyAccMag-mean()**  
**tBodyAccMag-std()**  
tBodyAccMag-mad()
tBodyAccMag-max()
tBodyAccMag-min()
tBodyAccMag-sma()
tBodyAccMag-energy()
tBodyAccMag-iqr()
tBodyAccMag-entropy()
tBodyAccMag-arCoeff()1
tBodyAccMag-arCoeff()2
tBodyAccMag-arCoeff()3
tBodyAccMag-arCoeff()4
**tGravityAccMag-mean()**  
**tGravityAccMag-std()**  
tGravityAccMag-mad()
tGravityAccMag-max()
tGravityAccMag-min()
tGravityAccMag-sma()
tGravityAccMag-energy()
tGravityAccMag-iqr()
tGravityAccMag-entropy()
tGravityAccMag-arCoeff()1
tGravityAccMag-arCoeff()2
tGravityAccMag-arCoeff()3
tGravityAccMag-arCoeff()4
.
**angle(tBodyAccMean,gravity)**  
**angle(tBodyAccJerkMean),gravityMean)**  
**angle(tBodyGyroMean,gravityMean)**  
**angle(tBodyGyroJerkMean,gravityMean)**  
**angle(X,gravityMean)**  
**angle(Y,gravityMean)**  
**angle(Z,gravityMean)**  

We are instructed to use only the "mean" and "std" variables in our analysis.  Those types are highlighted in the above listing.  We must use some REGEX searching in our R scripting to select only these columns in X_ files.  That code is shown here.  (We have already stacked our X-test and X-train datasets with the proper column names attached and the subject and activity identifying information aligned; our working dataframe is now named "data_all".)

```r
#The needed REGEX
cleanVarnames<-function(x){grep("(.*Mean|-mean|-std)",x, value=TRUE)}
keeps<-sapply(features[["feature"]],cleanVarnames)

keeps
length(keeps[keeps[]!="character(0)"])
#A check on how many variabkes we keep when filtering to just the mean and std variables...
#86 measures (tested in MS Access, too.) Then Subject and Activity = 88 total columns at end.


keeps<-(keeps[keeps[]!="character(0)"])
keeps<-names(keeps) #some cleaning to get the names as needed for selection in our data_all dataframe

keeps<-append(c("activityID", "activity", "subjectID"),keeps)
keeps # these are all the needed columns of measure and for final grouping

#The stacked dataframe with only the variables needed and the observation identifying columns attached.
data_all <- data_all[,(names(data_all) %in% keeps)]
```

The accompanying Codebook.md file will providee more detail on these variables.


### Summarize -> A Tidy Dataset

Now, we have a dataframe that will allow us to summarize on means, and the result will be a Tidy dataset.

This dataset has one observation per row identified by the activity and subjectID.  Each column outside of the two containing these two identifying data items are measurement variables; their is only one variable in each column, 86 measurements.

In the codebook, there is a table that shows the information contained within the tidy dataset's observation identifying columns and the statistics for each of the other 86 columns, the descriptive statsitics for each of the measures.

Additionally, this tidy dataset has human readable, descritpive names, the nomenclature described in the codebook's full table (csv file) and the "Codebook_VarList" worksheet of the codebook's MS Excel workbook.

## Final results

# Components of a Tidy Data Set
1. The raw data
2. A tidy data set
        a. One column for each variable of measure
        b. Each row holds a different observation of the variable measurements
        c. One tabklle for each kind of measure.
        d. If multiple tables needed, they should include an addditional ID column for being able to connect the tables. 
        
3. A code book
        a. Information about the variables, including units of measure.
        b. Infromation about the siuummary choices made.
        c. Information about the experimental design (ypou used).
        
4. An explicit, exact recipe

# Requirements met

1. The raw data is taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
        a. The file is saved to a local directory
        b. The zip file is unzipped via the "recipe", our R script.
        c. The raw data files are read into R exactly as is.
2. The final tidy data set meets the requirements of such a file, as is detailed in the previous section.
3. The codebook is provided in the Codebook.md file and has accompanying MS ERxcel and csv files that provide for 
   the naming conventions, the descriptions and explanatiions of the variable contents and the raw adat file contents.  The means and stds gathered and the means taken on these columns are all noted as the requirements for the assignment.
        a. Locations of files and how they inetract is supplied in the code book.
        b. Units for each variable measurement are given here.
4. The run_analysis.R script contains the code that retrieves the zip archive of the original study and  performs the needed connecting operations.  It also proofs the file contents, and condiucts the need summaries to produce the proper tidy data set.  This is one table holding the observations being measured for by these sensors.  We did not do this here, but we might have added one additioal column indicating the data's "test" or "train" origins.
















