

packages <- c("ggplot2", "readxl", "dplyr", "tidyr", "ggfortify", "DT", "reshape2", "knitr", "lubridate", "pwr", "psy", "car", "doBy", "imputeMissings", "RcmdrMisc", "questionr", "vcd", "multcomp", "KappaGUI", "rcompanion", "FactoMineR", "factoextra", "corrplot", "ltm", "goeveg", "corrplot", "FSA", "MASS", "scales", "nlme", "psych", "ordinal", "lmtest", "ggpubr", "dslabs", "stringr", "assist", "ggstatsplot", "forcats", "styler", "remedy", "snakecaser", "addinslist", "esquisse", "here", "summarytools", "magrittr", "tidyverse", "funModeling", "pander", "cluster", "abind")

librarian::shelf(packages)

#read missing_regression.csv
setwd("/Users/MBP/Documents/ElectronicWaste/")
df=read.csv("temp.csv",stringsAsFactors = T)
df  %>% head()
describe(df)
typeof(df)
str(df)
colnames(df)
length(df)
df$miss_another <- sub("N ", "N", df$miss_another)
table(df$miss_another
      )
printsummary <- function(df) {
  i <- 2
  xtabs(~df[,i], data = df)
  for (i in 2:length(df)) 
  {
    print(i)
    print(xtabs(~df[,i], data = df))
    i <- i + 1
    
  }  
}
#creating a mutation script


mutation_df <- function(df) {
  library(plyr)
  df$device_count_5_yr <- factor(
    df$device_count_5_yr
    ,
    levels = c("0", "1-2",
               "3-4", "4-6",
               "6-8", "8-10",
               "10-12", "12-")
  )
  #df$device_count_5_yr <- as.ordered(df$device_count_5_yr)
  mapvalues(df$device_count_5_yr,
            from = c("0", "1-2","3-4", "4-6","6-8", "8-10","10-12", "12-"),
            to = c("0", "2","4", "6","8", "10","12", "14")
            )
  
  df$device_count_5_yr <- as.numeric(df$device_count_5_yr)
  df$device_count_5_yr <- df$device_count_5_yr*2 -2  
  df$last_dumped_device <- relevel(df$last_dumped_device, "Smartphone")
  
  df$dump_within <- factor(df$dump_within,
                           levels = c("<1 mn", "<6 mn", "<1 yr", "<2 yr", "<4 yr", ">4 yr"))
  df$age <- as.ordered(df$age)
  df$dump_within <- as.ordered(df$dump_within)
  df$miss_another <- sub("N ", "N", df$miss_another)
  df$edu <- factor(df$edu,
                   levels = c("SSC","High School", "Bachelors","Masters","PhD"))
  df$edu <- factor(df$edu)
  
  
  #########checking-improving stepwise
  df$did_with_data_Y[df$did_with_data<=2]<-0 
  df$did_with_data_Y[df$did_with_data>=3]<-1
  df$did_with_device_econ[df$did_with_device<=2]<-1
  df$did_with_device_econ[df$did_with_device>=3]<-0
  #df$did_with_data <- factor()
  
  df$did_with_data_Y <- as.factor(df$did_with_data_Y)
  df$did_with_device_econ <- as.factor(df$did_with_device_econ)
  df <- dplyr::select(df,-c(did_with_data,did_with_device,X))
  
  # df$memory_dev[df$memory_dev=="N"] <- 0 
  # df$memory_dev[df$memory_dev=="Y"] <- 1
  # df$miss_another[df$miss_another=="N"] <- 0 
  # df$miss_another[df$miss_another=="Y"] <- 1
  levels(df$memory_dev) <- c(0,1)
  levels(df$miss_another) <- c(0,1)
  levels(df$miss_dev) <- c(0,1)
  
  df$bad_rep_exp <- relevel(df$bad_rep_exp,ref = "NC")
  #df$will_dev_rec[df$will_dev_rec==""] <- "NC"
  #df$will_dev_rec <- factor(df$will_dev_rec)
  df$will_dev_rec <- relevel(df$will_dev_rec,ref = "NC")
  
  #df$repair_try <- 1
  df$repair_try[df$self_try_No==1] <- 0
  df$repair_try[df$self_try_No==0] <- 1
  df$repair_try <- as.factor(df$repair_try)
  
  df$repair_succ[df$self_try_Success==1] <- 1
  df$repair_succ[df$self_try_Success==0] <- 0
  df$repair_succ <- as.factor(df$repair_succ)
  
  df$self_rep_combined[df$self_try_Success==1] <- "S"
  df$self_rep_combined[df$self_try_Failed==1] <- "F"
  df$self_rep_combined[df$self_try_No==1] <- "N"
  df$self_rep_combined <- factor(df$self_rep_combined)
  df$self_rep_combined <- relevel(df$self_rep_combined,"N")
  
 return(df)
}

create_code <- function(df) {
#  df$division.sum <- df$division
  contrasts(df$division) <- contr.sum(length(unique(df$division)))
  
  #df$age.sum <- df$age
  contrasts(df$age) <- contr.sum(length(unique(df$age)))
  contrasts(df$age) <- contr.sum(length(unique(df$age)))
  contrasts(df$last_dumped_device) <- contr.sum(length(unique(df$last_dumped_device)))
  contrasts(df$dump_within) <- contr.helmert(length(unique(df$dump_within)))
  
  return(df)
}

pack <- function(filename) {
  setwd("/Users/MBP/Documents/ElectronicWaste/")
  df=read.csv(filename,stringsAsFactors = T)
  #df=read.csv("temp.csv",stringsAsFactors = T)
  df <- mutation_df(df)
  #df <- rename_df(df)
  df <- create_code(df)
  return(df)
}

Generate_RoC <- function(full_model,null_model,df,outcome) {
  library(ROCR)
  librarian::shelf(pROC)
  n <- nrow(df)
  print(n)
  trainingidx <- sample(1:n, 0.9 * n)
  train <- df[trainingidx,]
  test <- df[-trainingidx,]
  
  step_model <- step(null_model, scope = list(lower = null_model, upper = full_model), direction = "forward", trace = FALSE)
  print(step_model %>% summary())
  
  
  test$pred <- predict(step_model,test,type="response")
  test$real <- test[,outcome]
  
  train$pred <- predict(step_model,train,type="response")
  train$real <- train[,outcome]
  
  
  plot.roc(test$real,test$pred, col = "red", main="ROC Validation set",
           percent = TRUE, print.auc = TRUE)
  
  
}


#temp <- pack("temp.csv")
filename="temp.csv"
#filename="missing_regression.csv"
df <- pack(filename)
view(df)
i=0
for (v in colnames(df)) {
  print(v)
  i=i+1
  print(i)

  print(xtabs(~df[,v],data=df))
  
  if (v == "X" | v =="occupation" | v=="miss_dev") {
    next
  }
  #model <- glm(miss_dev~df[,v],data = df,family = "binomial")
  #print(summary(model))
  
}
view(df)
df[!complete.cases(df),]
library(MASS)
givenness <- read.csv(url("https://osf.io/q9e3a/download"))
view(givenness)

df %>% colnames()

#full.model <- update(full.model,~.)
# full.model <- update(full.model,~.-X-age-division)
attach(df)
#full.model <- glm(repair_try ~age+gender+edu+device_count_5_yr+miss_dev+dump_reason_new+dump_reason_old+dump_reason_break+dump_reason_theft+dump_reason_slow+dump_reason_lag+slt_lack_tu+slt_lack_lang+slt_lack_notint+slt_lack_fear+slt_lack_parts+slt_lack_repairer+rpr_missing_trait_behave+rpr_missing_trait_ineff+rpr_missing_trait_harm+rpr_missing_trait_hard+rpr_missing_trait_wage+rpr_missing_trait_trust+rpr_missing_trait_gender+bad_rep_exp+dev_tknto_rec_Y+did_with_data_Y+gender:rpr_missing_trait_gender+did_with_device_econ, data = df, family = binomial)

full.model <- glm(repair_try ~age+gender+edu+device_count_5_yr+miss_dev+dump_reason_new+dump_reason_old+dump_reason_break+dump_reason_theft+dump_reason_slow+dump_reason_lag+slt_lack_tu+slt_lack_lang+slt_lack_notint+slt_lack_fear+slt_lack_parts+slt_lack_repairer+rprd_usage_chlng_No+rprd_usage_chlng_reluc+rprd_usage_chlng_dur+rprd_usage_chlng_fault+rpr_missing_trait_behave+rpr_missing_trait_ineff+rpr_missing_trait_harm+rpr_missing_trait_hard+rpr_missing_trait_wage+rpr_missing_trait_trust+rpr_missing_trait_gender+bad_rep_exp+dev_tknto_rec_Y+dev_rec_chlng_fair_price+dev_rec_chlng_usable+dev_rec_chlng_datasec+dev_rec_chlng_env_poll+dev_rec_chlng_hard_find+will_dev_rec+did_with_data_Y+did_with_device_econ+gender:rpr_missing_trait_gender, data = df, family = binomial)



#full model for success- Not try
#full.model <- glm(repair_succ ~age+gender+edu+device_count_5_yr+miss_dev+dump_reason_new+dump_reason_old+dump_reason_break+dump_reason_theft+dump_reason_slow+dump_reason_lag+slt_lack_tu+slt_lack_lang+slt_lack_notint+slt_lack_fear+slt_lack_parts+slt_lack_repairer+rprd_usage_chlng_No+rprd_usage_chlng_reluc+rprd_usage_chlng_dur+rprd_usage_chlng_fault+rpr_missing_trait_behave+rpr_missing_trait_ineff+rpr_missing_trait_harm+rpr_missing_trait_hard+rpr_missing_trait_wage+rpr_missing_trait_trust+rpr_missing_trait_gender+bad_rep_exp+dev_tknto_rec_Y+dev_rec_chlng_fair_price+dev_rec_chlng_usable+dev_rec_chlng_datasec+dev_rec_chlng_env_poll+dev_rec_chlng_hard_find+will_dev_rec+did_with_data_Y+did_with_device_econ+gender:rpr_missing_trait_gender, data = df, family = binomial)


full.model %>% summary()
backward.model <- step(full.model,direction = "backward",trace = 0)



backward.model %>% summary()

1/vif(backward.model)
mean(vif(backward.model))
null.model <- glm(repair_try ~1, data = df, family = binomial)
null.model %>% summary()
Generate_RoC(full.model,null.model,df,"repair_try")


full.model <- glm(formula = repair_try ~ gender + device_count_5_yr + dump_reason_break + 
      slt_lack_tu + slt_lack_lang + slt_lack_parts + slt_lack_repairer + 
      rprd_usage_chlng_fault + rpr_missing_trait_trust + rpr_missing_trait_gender + 
      dev_tknto_rec_Y + dev_rec_chlng_hard_find + did_with_device_econ, 
    family = binomial, data = df)


full.model <- glm(formula = repair_try ~ gender + device_count_5_yr + dump_reason_break + 
                    slt_lack_tu + slt_lack_lang + slt_lack_parts + slt_lack_repairer + 
                    rprd_usage_chlng_fault + rpr_missing_trait_trust + rpr_missing_trait_gender + 
                    dev_tknto_rec_Y + dev_rec_chlng_hard_find + did_with_device_econ+device_count_5_yr:rprd_usage_chlng_fault+device_count_5_yr:dev_tknto_rec_Y+device_count_5_yr:did_with_device_econ+slt_lack_tu:dev_tknto_rec_Y+slt_lack_lang:rpr_missing_trait_gender+slt_lack_parts:rpr_missing_trait_gender+rpr_missing_trait_gender:dev_rec_chlng_hard_find+rpr_missing_trait_trust:dev_rec_chlng_hard_find+rpr_missing_trait_gender:did_with_device_econ,
                  family = binomial, data = df)
