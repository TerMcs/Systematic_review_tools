#### install ####
install.packages("metagear")
install.packages("BiocManager")
BiocManager::install("EBImage")

library(metagear)

#### load data ####
data(example_references_metagear)

names(example_references_metagear)
example_references_metagear["JOURNAL"]

theRefs <- effort_initialize(example_references_metagear)

names(theRefs)

# [1] "STUDY_ID"  "REVIEWERS" "INCLUDE"   "AUTHORS"   "YEAR"     
# [6] "TITLE"     "JOURNAL"   "VOLUME"    "LPAGES"    "UPAGES"   
# [11] "DOI"       "ABSTRACT" 

# Note that the effort_initialize() function added three new columns: "STUDY_ID" which
# is a unique number for each reference (e.g., from 1 to 11), "REVIEWERS" an empty column
# with NAs that will be later populated with our reviewers (e.g., Christina and Luc), and
# finally the "INCLUDE" column, which will later contain the screening efforts by the two
# reviewers. 

# Screening efforts are essentially how individual study references get coded for inclusion in
# the synthesis project; currently the "INCLUDE" column has each reference coded as "not
# vetted", indicating that each reference has yet to be screened.
# Our next task is to delegate screening efforts to our two reviewers Christina and Luc. Our
# goal is to randomly distribute these references to each reviewer.

# randomly distribute screening effort to a team

theTeam <- c("terence", "mona")
theRefs_unscreened <- effort_distribute(theRefs, reviewers = theTeam)

# display screening tasks
theRefs_unscreened[c("STUDY_ID", "REVIEWERS")]

# The screening efforts can also be delegated unevenly, such as below where Luc will take on
# 80% of the screening effort:
  # randomly distribute screening effort to a team, but with Luc handeling 80%
  # of the work

theRefs_unscreened <- effort_distribute(theRefs, reviewers = theTeam, effort = c(20,80))

theRefs_unscreened[c("STUDY_ID", "REVIEWERS")]

theRefs_Patsy <- effort_redistribute(theRefs_unscreened, reviewer = "mona",
                                     remove_effort = 50,
                                     reviewers = c("mona", "jacqui"))
theRefs_Patsy[c("STUDY_ID", "REVIEWERS")]

# randomly distribute screening effort to a team, but with Luc handling 80%
# of the work,
# but also saving these screening tasks to separate files for each team
# member

theRefs_unscreened <- effort_distribute(theRefs, reviewers = theTeam,
                                        effort = c(20, 80), save_split = TRUE)

list.files(pattern = "effort")

#### effort_merge ####

# merge the effort_Luc.csv and effort_Christina.csv
# WARNING: will merge all files named "effort_*" in directory

theRefs_screened <- effort_merge()

theSummary <- effort_summary(theRefs_screened)

# === SCREENING EFFORT SUMMARY ===
#   
#   6 candidate studies identified
# 3 studies excluded
# 2 challenging studies needing additional screening
# ----
#   11 TOTAL SCREENED
# 
# === SCREENING DESIGN SUMMARY ===
#   
#   MAYBE NO YES TOTAL         %
# mona        2  3   4     9  81.81818
# terence     0  0   2     2  18.18182
# TOTAL       2  3   6    11 100.00000

#### screening GUI ####

# initialize bibliographic data and screening tasks
data(example_references_metagear)
effort_distribute(example_references_metagear, initialize = T,
                  reviewers = "marc", save_split = T)

# initialise screener GIU
abstract_screener("effort_mona.csv", aReviewer = "terence")
