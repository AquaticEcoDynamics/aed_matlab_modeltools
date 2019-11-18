
## Relating Peel-Harvey FCI scores to water quality variables
# D.Yeoh, Nov 2019

library(dplyr) # package for data manipulation
library(mgcv) # packge for model fitting


# (1.0) Load required data for model building --------------------------------------------

#FCI scores and enviro data (1979-2018, all regions and water depths)
dat <- read.csv('FCI_scores_and_enviros.csv')
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

# example predictions using a dummy data set below:

#Create a dummy set of enviro variables for hypothetical estuarine grids
grid.cell = c(1,2,3,4,5)
age_bottom = c(30,10,60,30,75)
oxygen_bottom = c(0,2,4,6,8)
salinity_.bottom = c(0,10,15,20,30)
Period = c('2013-14','2013-14','2016-18','2016-18','2016-18')

ndat <- data.frame(grid.cell,age_bottom,oxygen_bottom,salinity_.bottom,Period) #dummy data.frame

#predict scores (and SE) for dataframe using gam m1
ndat$pred_FCI <- predict(m1, newdata=ndat, se.fit = TRUE)$fit
ndat$FCI.se <- predict(m1, newdata=ndat, se.fit = TRUE)$se.fit

ndat # estimates



#optional - add FCI grades to estimates
ndat <- ndat%>% mutate(grade = ifelse(pred_FCI < 10.4, "E", "D"),
                       grade = ifelse(pred_FCI >= 41, "C", grade),
                       grade = ifelse(pred_FCI >=54, "B", grade),
                       grade = ifelse(pred_FCI >= 71, "A", grade))
ndat #estimates with grades


