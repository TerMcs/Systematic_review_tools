library(revtools)

theRefs <- read_bibliography("ss_ID_6.ris")

write.csv(theRefs, file = "ss_ID_6.csv")

theRefs <- read.csv("ss_ID_6_columns_del.csv")

# title                year        abstract        
# Length:9641        Min.   :2000   Length:9641       
# Class :character   1st Qu.:2010   Class :character  
# Mode  :character   Median :2014   Mode  :character  
#                   Mean   :2013                     
#                   3rd Qu.:2017                     
#                   Max.   :2020  

theRefsA <- theRefs[theRefs$year >= 2017, ] 
write.csv(theRefsA, file = "ss_ID_6_2017to20.csv")

theRefsB <- theRefs[theRefs$year < 2017 & theRefs$year >= 2014, ] 
write.csv(theRefsB, file = "ss_ID_6_2014to17.csv")

theRefsC <- theRefs[theRefs$year < 2014 & theRefs$year >= 2009, ] 
write.csv(theRefsC, file = "ss_ID_6_2009to14.csv")

theRefsD <- theRefs[theRefs$year < 2009, ] 
write.csv(theRefsD, file = "ss_ID_6_2000to09.csv")

screen_topics()
