# LIBRARY ----
library(dplyr)
library(stringr)

# DATASHEETS ----
ds_full_df <- read.csv("U.S._Chronic_Disease_Indicators__CDI_.csv")
ws_full_df <- read.csv("EPA_SmartLocationDatabase_V3_Jan_2021_Final.csv")


# Walking Score Data Cleaning ----

  # Finding Mean Walk Score per State
    ws_select_df <- select(ws_full_df, STATEFP, COUNTYFP, NatWalkInd, D4A_Ranked, D3B_Ranked)
    ws_select_df <- group_by(ws_select_df, STATEFP)
    ws_df <- summarize(ws_select_df, 
                       avg_walk = mean(NatWalkInd), 
                       avg_commute = mean(D4A_Ranked),
                       avg_intersection = mean(D3B_Ranked))
    ws_df$avg_walk <- round(ws_df$avg_walk, digits = 2)
    ws_df$avg_commute <- round(ws_df$avg_commute, digits = 2)
    ws_df$avg_intersection <- round(ws_df$avg_intersection, digits = 2)
    
  # Walkability Score to Phrase Function
    
    toWalkable <- function(col) {
      
      #Variables
      poor <- c("Least Walkable")
      BA <- c("Below Average Walkable")
      AA <- c("Above Average Walkable")
      best <- c("Most Walkable")
      
      #Conditionals
      if (col <= 5.75){ result <- poor }
      else if (between (col, 5.76, 10.50)){ result <- BA }
      else if (between (col, 10.51, 15.25)){ result <- AA }
      else if (between (col, 15.26, 20)){result <- best }
      else { result <- NULL}
      
      return(result)
    } 
    ws_df$walkable <- mapply(toWalkable, ws_df$avg_walk)
    
# Chronic Disease Data Cleaning ----
  ds_clean_df <- na.omit(select(ds_full_df, YearStart, YearEnd, 
                                 LocationAbbr, Topic, Question, DataValueUnit,
                                 DataValueType, DataValueAlt))

  ds_clean_df <- filter(ds_full_df, YearStart == 2021)
  
  dfClean <- function(df){
  # LIST OF POTENTIALLY RELEVANT DATA QUESTIONS
# 1.  "Overweight or obesity among adults aged >= 18 years" 
# 2. "Current asthma prevalence among adults aged >= 18 years"
# 3. "High cholesterol prevalence among adults aged >= 18 years"
# 4. "Prevalence of diagnosed diabetes among adults aged >= 18 years"
# 5. "No leisure-time physical activity among adults aged >= 18 years"
# 6. "Fair or poor self-rated health status among adults aged >= 18 years"
  
  #VARIABLES
  ds_filt_df <- filter(df, YearStart == 2021, 
                       DataValueType == "Age-adjusted Prevalence")
  main_df <- as.data.frame(state.abb)
  main_df <- rename(main_df, "LocationAbbr" = "state.abb")
  
  #QUESTION ONE: OBESITY
  ds_filt1_df <- filter(ds_filt_df, 
                        Question == "Overweight or obesity among adults aged >= 18 years")
  ds_select1_df <- select(ds_filt1_df, LocationAbbr, DataValueAlt)
  ds_select1_df <- group_by(ds_select1_df, LocationAbbr)
  ds_1_df <- summarise(ds_select1_df, Obesity = mean(DataValueAlt))
  ds_1_df$Obesity <- round(ds_1_df$Obesity, digits = 2)
  
  #QUESTION TWO: ASTHMA
  ds_filt2_df <- filter(ds_filt_df, 
                        Question == "Current asthma prevalence among adults aged >= 18 years")
  ds_select2_df <- select(ds_filt2_df, LocationAbbr, DataValueAlt)
  ds_select2_df <- group_by(ds_select2_df, LocationAbbr)
  ds_2_df <- summarise(ds_select2_df, Asthma = mean(DataValueAlt))
  ds_2_df$Asthma <- round(ds_2_df$Asthma, digits = 2)
  
  #QUESTION THREE: CHOLESTEROL
  ds_filt3_df <- filter(ds_filt_df, 
                        Question == "High cholesterol prevalence among adults aged >= 18 years")
  ds_select3_df <- select(ds_filt3_df, LocationAbbr, DataValueAlt)
  ds_select3_df <- group_by(ds_select3_df, LocationAbbr)
  ds_3_df <- summarise(ds_select3_df, Cholesterol = mean(DataValueAlt))
  ds_3_df$Cholesterol <- round(ds_3_df$Cholesterol, digits = 2)
  
  #QUESTION FOUR: DIABETES
  ds_filt4_df <- filter(ds_filt_df, 
                        Question == "Prevalence of diagnosed diabetes among adults aged >= 18 years")
  ds_select4_df <- select(ds_filt4_df, LocationAbbr, DataValueAlt)
  ds_select4_df <- group_by(ds_select4_df, LocationAbbr)
  ds_4_df <- summarise(ds_select4_df, Diabetes = mean(DataValueAlt))
  ds_4_df$Diabetes <- round(ds_4_df$Diabetes, digits = 2)
  
  #QUESTION FIVE: PHYSICAL ACTIVITY
  ds_filt5_df <- filter(ds_filt_df, 
                        Question == "No leisure-time physical activity among adults aged >= 18 years")
  ds_select5_df <- select(ds_filt5_df, LocationAbbr, DataValueAlt)
  ds_select5_df <- group_by(ds_select5_df, LocationAbbr)
  ds_5_df <- summarise(ds_select5_df, Activity = mean(DataValueAlt))
  ds_5_df$Activity <- round(ds_5_df$Activity, digits = 2)
  
  #QUESTION SIX: HEALTH STATUS
  ds_filt6_df <- filter(ds_filt_df, 
                        Question == "Fair or poor self-rated health status among adults aged >= 18 years")
  ds_select6_df <- select(ds_filt6_df, LocationAbbr, DataValueAlt)
  ds_select6_df <- group_by(ds_select6_df, LocationAbbr)
  ds_6_df <- summarise(ds_select6_df, Status = mean(DataValueAlt))
  ds_6_df$Status <- round(ds_6_df$Status, digits = 2)
  

df <- left_join(main_df,
                left_join(ds_1_df, 
                          left_join(ds_2_df, 
                                    left_join(ds_3_df, 
                                              left_join (ds_4_df, 
                                                         left_join (ds_5_df,ds_6_df,
                                              by='LocationAbbr'),
                                    by='LocationAbbr'), 
                          by='LocationAbbr'), 
                by='LocationAbbr'),
                by='LocationAbbr'),
      by='LocationAbbr')
  
  return(df)
  }
  
  ds_df <- dfClean(ds_clean_df)
  
    # State Abbr to State FP Code (KEEP CLOSED) ----
#Link for future reference to codes:
#https://www.census.gov/library/reference/code-lists/ansi/ansi-codes-for-states.html
  
  ds_df$STATEFP <- ds_df$LocationAbbr
  
  ds_df$STATEFP <- gsub('AL', '1', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('AK', '2', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('AZ', '4', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('AR', '5', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('CA', '6', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('CO', '8', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('CT', '9', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('DE', '10', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('DC', '11', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('FL', '12', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('GA', '13', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('HI', '15', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('ID', '16', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('IL', '17', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('IN', '18', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('IA', '19', ds_df$STATEFP)    
  ds_df$STATEFP <- gsub('KS', '20', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('KY', '21', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('LA', '22', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('ME', '23', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('MD', '24', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('MA', '25', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('MI', '26', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('MN', '27', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('MS', '28', ds_df$STATEFP)    
  ds_df$STATEFP <- gsub('MO', '29', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('MT', '30', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NE', '31', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NV', '32', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NH', '33', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NJ', '34', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NM', '35', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NY', '36', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('NC', '37', ds_df$STATEFP)    
  ds_df$STATEFP <- gsub('ND', '38', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('OH', '39', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('OK', '40', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('OR', '41', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('PA', '42', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('RI', '44', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('SC', '45', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('SD', '46', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('TN', '47', ds_df$STATEFP)    
  ds_df$STATEFP <- gsub('TX', '48', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('UT', '49', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('VT', '50', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('VA', '51', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('WA', '53', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('WV', '54', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('WI', '55', ds_df$STATEFP)
  ds_df$STATEFP <- gsub('WY', '56', ds_df$STATEFP)
  

# Merge Data Sets ----
  df <- merge(ds_df, ws_df, by = "STATEFP", all.x = TRUE)
  
#  usethis::use_git()
  