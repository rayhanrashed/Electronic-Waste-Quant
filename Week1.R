# view(df)
# df <- mutation_df(df)
# 
# colnames(df)
# printsummary(df)
# View(df)
# #df$miss_another <- gsub
# levels(df$device_count_5_yr)
# df$device_count_5_yr <- factor(df$device_count_5_yr, 
#                                levels =c("0", "1-2","3-4",
#                                          "4-6", "6-8","8-10",
#                                          "10-12","12-"))
# levels(df$device_count_5_yr)
# levels(df$age)
# contr.sum(2)
# df$last_dumped_device <- relevel(df$last_dumped_device, "Smartphone")
# levels(df$dump_within)
# df$dump_within <- factor(df$dump_within, levels=c("<1 mn","<6 mn", "<1 yr", "<2 yr", "<4 yr", ">4yr"))
# str(df)
# df$did_with_device <- as.factor(df$did_with_device)
# df$did_with_data <- as.factor(df$did_with_data)  
# df$age <- as.ordered(df$age)
# attach(df)
# m_age <- glm(miss_dev~age,family = "binomial", data = df)
# summary(m_age)
# head(df$age)
# df$device_count_5_yr <- as.ordered(df$device_count_5_yr)
# 
# m_device_count_5_yr <- glm(miss_dev~device_count_5_yr,family = "binomial", data = df)
# summary(m_device_count_5_yr)
# 
# m_gender <- glm(miss_dev~gender,family = "binomial", data = df)
# summary(m_gender)
# 
# xtabs(~miss_dev+gender, data = df)
# 
# m4 <- glm(miss_dev~last_dumped_device*gender,family = "binomial", data = df)
# summary(m4)
# 
# m5 <- glm(miss_dev~memory_dev,family = "binomial", data = df)
# summary(m5)
# 
# 
# m6 <- glm(miss_dev~dump_within,family = "binomial", data = df)
# summary(m6)
# levels(dump_within)
# df$dump_within <- as.ordered(df$dump_within)
# 
# xtabs(~miss_dev+edu,data = df)
# 
# m_edu <- glm(miss_dev~edu,family = "binomial", data = df)
# summary(m_edu)
# df_edu <- subset(df, df$edu != "SSC")
# df_edu <- subset(df_edu, df_edu$edu != "PhD")
# 
# df_edu$edu <- df_edu$edu %>% factor()
# df_edu$edu %>% levels()
# 
# xtabs(~miss_dev+edu,data = df_edu)
# m_edu_truncated <- glm(miss_dev~edu,family = "binomial", data = df_edu)
# summary(m_edu_truncated)
# 
# m_device_count_5_yr <- glm(miss_dev~device_count_5_yr,family = "binomial", data = df)
# summary(m_device_count_5_yr)
# 
# xtabs(~miss_dev+last_dumped_device,df)
# m_last_dumped_device <- glm(miss_dev~last_dumped_device,family = "binomial", data = df)
# summary(m_last_dumped_device)
# 
# 
# m_dump_within<- glm(miss_dev~dump_within,family = "binomial", data = df)
# summary(m_dump_within)
# 
# 
# xtabs(~miss_dev+did_with_device,data=df)
# m_did_with_device <- glm(miss_dev~did_with_device,family = "binomial", data = df)
# summary(m_did_with_device)
# str(df$did_with_device)
# df$did_with_device <- as.numeric(df$did_with_device)
# df[is.na(df)] <- 0
# df$did_with_device <- as.factor(df$did_with_device)
# 
# 
# 
# df$did_with_data <- as.numeric(df$did_with_data)
# df$did_with_data[df$did_with_data >2] <- 3
# df$did_with_data <- as.factor(df$did_with_data)
# str(df$did_with_data)
# 
# xtabs(~miss_dev+did_with_data,data=df)
# m_did_with_data <- glm(miss_dev~did_with_data,family = "binomial", data = df)
# summary(m_did_with_data)
# 
# df2 %>% head()
# 
# xtabs(~miss_dev+dump_reason_1,data=df)
# m_dump_reason_new <- glm(miss_dev~dump_reason_1,family = "binomial", data = df)
# summary(m_dump_reason_new)
# 
# xtabs(~miss_dev+dump_reason_2,data=df)
# m_dump_reason_old <- glm(miss_dev~dump_reason_2,family = "binomial", data = df)
# summary(m_dump_reason_old)
# 
# 
# xtabs(~miss_dev+dump_reason_3,data=df)
# m_dump_reason_disfunctional <- glm(miss_dev~dump_reason_3,family = "binomial", data = df)
# summary(m_dump_reason_disfunctional)
# 
# xtabs(~miss_dev+dump_reason_4,data=df)
# m_dump_reason_theft <- glm(miss_dev~dump_reason_4,family = "binomial", data = df)
# summary(m_dump_reason_theft)
# 
# 
# xtabs(~miss_dev+reason67,data=df)
# m_dump_reason_lagging <- glm(miss_dev~reason67,family = "binomial", data = df)
# summary(m_dump_reason_lagging)
# (df$dump_reason_5 + df$dump_reason_6)
# view(df)
# print(df$X[df$dump_reason_5==1 & df$dump_reason_6==1])
# 
# 
# summary(m_did_with_device)
# df$reason67 <- df$dump_reason_5==1 | df$dump_reason_6==1
# view(df$reason67
# )
# df$reason67 <- as.factor(df$reason67)
# levels(df$reason67)
# 
# m_reasonable_no_interaction <- glm(miss_dev~memory_dev+dump_within+did_with_device+did_with_data+dump_reason_3,data=df,family = "binomial")
# summary(m_reasonable_no_interaction)
# 
# view(df)
# 
# 
# 



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

pack <- function(df) {
  setwd("/Users/MBP/Documents/ElectronicWaste/")
  df=read.csv("missing_regression.csv",stringsAsFactors = T)
  df <- mutation_df(df)
  df <- rename_df(df)
  df <- create_code(df)
  return(df)
}

df <- pack(df)

for (v in colnames(df)) {
  print(v)
  
  if (v == "X" | v =="occupation" | v=="miss_dev") {
    next
  }
  print(xtabs(~miss_dev+df[,v],data=df))
  model <- glm(miss_dev~df[,v],data = df,family = "binomial")
  print(summary(model))
  
}
c("X","age.sum","division.sum")
view(df)
df[!complete.cases(df),]
library(MASS)
full.model <- glm(miss_dev ~.-X, data = df, family = binomial)
#full.model <- update(full.model,~.)
# full.model <- update(full.model,~.-X-age-division)
full.model %>% summary()
forwardm <- step(full.model,direction = "backward",trace = 4)



forwardm %>% summary()
