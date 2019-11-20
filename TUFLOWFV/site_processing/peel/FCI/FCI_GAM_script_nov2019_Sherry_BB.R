
## Relating Peel-Harvey FCI scores to water quality variables
# D.Yeoh, Nov 2019

library(dplyr) # package for data manipulation
library(mgcv) # packge for model fitting


# (1.0) Load required data for model building --------------------------------------------

#FCI scores and enviro data (1979-2018, all regions and water depths)
dat <- read.csv("FCI_scores_and_enviros.csv")
head(dat)

# note - the list of enviro variables has been trimmed down through various data explorations
# to omit highly correlated variables and those with little signal. 

# (2.0) FIT MODELS ----------------------------------------------------------------------

# the best fit model for each water depth and region has been chosen through building models with
# all possible combinations of the available environmnetal variables and ranking the models by 
# lowest AICc value. Where several models had similar AICc scores (delta AICc < 2), preference was given 
# to the simpler (less variables) model.

# (2.1)  offshore waters - model for rivers

OS.R.dat <- dat%>%filter(region2 == "river" & depth == "OS") #subset relevant rows
#fit GAM model (mgcv package)
m1 <- gam(FCI ~  s(age_bottom) + s(salinity_.bottom) + s(oxygen_bottom)  + Period, 
          data = OS.R.dat, 
          method = "REML", family = "gaussian")
summary(m1) #model summary


# (2.2)  nearshore waters - model for rivers

NS.R.dat <- dat%>%filter(region2 == "river" & depth == "NS") #subset relevant rows
#fit GAM model (mgcv package)
m2 <- gam(FCI ~   s(salinity_.bottom) + s(hypoxia_area) + Period, 
          data = NS.R.dat, 
          method = "REML", family = "gaussian")
summary(m2) #model summary


# (2.3)  nearshore waters - model for basins

NS.B.dat <- dat%>%filter(region2 == "basin" & depth == "NS") #subset relevant rows
#fit GAM model (mgcv package)
m3 <- gam(FCI ~  s(salinity_.bottom) + s(hypoxia_area) + Period, 
          data = NS.B.dat, 
          method = "REML", family = "gaussian")
summary(m3) #model summary


# note - there was no signal in the offshore basin dataset and hence no best fit model.

# (3.0) PREDICTIONS  ----------------------------------------------------------------

## each GAM model can be used to predict FCI scores for a given set of env variables
# the prediction requires values of each model term to be specified.
# for example, for m1 (OS, rivers  model)  - age_bottom, salinity_.bottom, oxygen_bottom and Period 
# must be specified (with column names spelt exactly as they are in the model).


setwd("E:/Github 2018/aed_matlab_modeltools/TUFLOWFV/site_processing/peel/FCI/2016") #the folder of all your files to be looped

# to loop through all files in a folder


listcsv <- dir(pattern = "*.csv") # creates the list of all the csv files in the directory

for (k in 1:length(listcsv)){
  
  ndat <- list() # creates a list
  a <- list() # a list for results
  
 ndat <- read.csv(listcsv[k])

filename <- paste0(listcsv[k])

grid.cell <- ndat$Cell
age_bottom <- ndat$Age
# cONVERT TO MG/l FROM MMOL/M3
oxygen_bottom <- ndat$Oxy * (32/1000)
salinity_.bottom <- ndat$Sal
Period <- ndat$Period
a <- data.frame(grid.cell,age_bottom,oxygen_bottom,salinity_.bottom,Period,stringsAsFactors=FALSE)

#predict scores (and SE) for dataframe using gam m1
a$pred_FCI <- predict(m1, newdata=a, se.fit = TRUE)$fit
a$FCI.se <- predict(m1, newdata=a, se.fit = TRUE)$se.fit  

#optional - add FCI grades to estimates
a <- a%>% mutate(grade = ifelse(pred_FCI < 10.4, "E", "D"),
                 grade = ifelse(pred_FCI >= 41, "C", grade),
                 grade = ifelse(pred_FCI >=54, "B", grade),
                 grade = ifelse(pred_FCI >= 71, "A", grade))

write.csv(file=paste0("E:/Github 2018/aed_matlab_modeltools/TUFLOWFV/site_processing/peel/FCI/output/",filename),a[,c("grid.cell","pred_FCI","FCI.se","grade")])
}

