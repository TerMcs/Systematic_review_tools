

# key points:
# import search results to Mendeley. 
# Must be saved from Mendeley as .ris file type, .bib won't work
# use revtools to read the bibliography and creat a data frame
# then use metagear effort_initialize to add columns.
# Then divide the efforts between reviewers.
# Save the efforts as csv files.
# KEY STEP: the columns abstract and title headings must be capitalised
# to ABSTRACT and HEADING for the GUI function to work, 
# so go into each effort_* file and change the headings.
# Then the GUI can be used for screening the articles.
# When doing the GUI make sure you save often. Note: saving won't 
# work if the xls file is open.


mendeley_all <- revtools::read_bibliography("mendeley_phd.ris")

library(metagear)

theRefs <- effort_initialize(mendeley_all)

theTeam <- c("terence")

theRefs_unscreened <- effort_distribute(theRefs, reviewers = theTeam,
                                        effort = c(100), save_split = TRUE)

abstract_screener("effort_terence3.csv", aReviewer = "terence")
