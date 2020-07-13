

packages <- c("ggplot2", "readxl", "dplyr", "tidyr", "ggfortify", "DT", "reshape2", "knitr", "lubridate", "pwr", "psy", "car", "doBy", "imputeMissings", "RcmdrMisc", "questionr", "vcd", "multcomp", "KappaGUI", "rcompanion", "FactoMineR", "factoextra", "corrplot", "ltm", "goeveg", "corrplot", "FSA", "MASS", "scales", "nlme", "psych", "ordinal", "lmtest", "ggpubr", "dslabs", "stringr", "assist", "ggstatsplot", "forcats", "styler", "remedy", "snakecaser", "addinslist", "esquisse", "here", "summarytools", "magrittr", "tidyverse", "funModeling", "pander", "cluster", "abind")

librarian::shelf(packages)

#read missing_regression.csv
setwd("/Users/MBP/Documents/ElectronicWaste/")
df=read.csv("missing_regression.csv",stringsAsFactors = T)
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
  df$device_count_5_yr <- factor(
    df$device_count_5_yr
    ,
    levels = c("0", "1-2",
               "3-4", "4-6",
               "6-8", "8-10",
               "10-12", "12-")
  )
  df$device_count_5_yr <- as.ordered(df$device_count_5_yr)
  
  df$last_dumped_device <- relevel(df$last_dumped_device, "Smartphone")
  
  df$dump_within <- factor(df$dump_within,
                           levels = c("<1 mn", "<6 mn", "<1 yr", "<2 yr", "<4 yr", ">4 yr"))
  df$age <- as.ordered(df$age)
  df$dump_within <- as.ordered(df$dump_within)
  df$miss_another <- sub("N ", "N", df$miss_another)
  df$edu <- factor(df$edu,
                   levels = c("SSC","High School", "Bachelors","Masters","PhD"))
  

  
  
  #########checking-improving stepwise
  df$did_with_data[df$did_with_data<=2]<-1 
  df$did_with_data[df$did_with_data>=3]<-2
  df$did_with_device[df$did_with_device<=2]<-1
  df$did_with_device[df$did_with_device>=3]<-2
  #df$did_with_data <- factor()
  
  df$did_with_data <- as.factor(df$did_with_data)
  df$did_with_device <- as.factor(df$did_with_device)

 return(df)
}

rename_df <- function(df) {
  
    df$dump_reason_new=df$dump_reason_1
    df$dump_reason_old=df$dump_reason_2
    df$dump_reason_break=df$dump_reason_3
    df$dump_reason_theft=df$dump_reason_4
    df$dump_reason_slow=df$dump_reason_5
    df$dump_reason_lag=df$dump_reason_6
    
    df <- df[,-c(15:20)]
  
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
  df <- rename_df(df)
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
temp <- pack("temp.csv")
#filename="temp.csv"
filename="missing_regression.csv"
df <- pack(filename)

for (v in colnames(df)) {
  print(v)
  
  if (v == "X" | v =="occupation" | v=="miss_dev") {
    next
  }
  print(xtabs(~miss_dev+df[,v],data=df))
  #model <- glm(miss_dev~df[,v],data = df,family = "binomial")
  print(summary(model))
  
}
view(df)
df[!complete.cases(df),]
library(MASS)

#full.model <- update(full.model,~.)
# full.model <- update(full.model,~.-X-age-division)
full.model <- glm(miss_dev ~(.-X-division-occupation+gender:dump_reason_break), data = df, family = binomial)
full.model %>% summary()
backward.model <- step(full.model,direction = "backward",trace = 1)



backward.model %>% summary()

null.model <- glm(miss_dev ~1, data = df, family = binomial)

Generate_RoC(full.model,null.model,df,"miss_dev")
