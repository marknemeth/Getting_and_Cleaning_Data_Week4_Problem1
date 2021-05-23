Course: " Getting and Cleaning Data"
title: "Codebook.md (Project Requirement)"
author: "Mark Nemeth"
date: "5/23/2021"


# Peer-graded Assignment: Getting and Cleaning Data Course Project

### Codebook_tables_and_notes workbook

This document will make reference to the primary code book documentation, which is in the accompanying MS Excel workbook, "Codebook_table_and_notes.xls".  This is Excel '95 formatted workbook containing four worksheets.

1. VarLists_Import:
        Contains the original study's variable names and the corresponding list of Tidy dataset variable names used in this project.  (Note that the "subjectID" and "activity" variables are truly only variables from this project's work; however, they are implicit in the original study's work.)

2. Codebook_Varlist: 
        Shows how the Tidy dataset variable names are derived form the original study's variable names.  The original study's variable names are derived from an understanding that they were of FFT nature or a time sereis nature, that they were decomposed along the body axis or along the gravity vector, that they were linearly derived or angular in dexcribing motion or that they combined the two, and that the reference coordinate system was used for projection or not.  Beyond that, the measures were either averages of samples within an observatiional unit or they were standard deviations.  The derivation is presented and the resulting natural Tidy dataset variable names are constructed from this.  A full description of these variables is presented on this worksheet, as well as the units of measurement for each.
        
3. Codebook_notes:
        Important information on the units of measurment, how the sampling series are mapped, an explanation of "jerk", and the normalization of reported measurements is emphasized.
        
4. Codebook_TidySet_Stats:
        The descriptive statistics for each of the measurement variables in the final tidy dataset.  The subjectID contents are confirmed here, as are the activity variable's contents.
        
        
### CSV equivalents

Each of the worksheets described above are duplicated in csv format as four separate csv files: Codebook_VarLists_Import.csv, Codebook_FullTable.csv, Codebook_notes.csv, Codebook_Variable_Stats.csv.
