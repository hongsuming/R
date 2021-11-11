name <- c("aa","bb","cc","dd")
gender <- c("F","M","M","F")
price <- c(50,65,45,75) # 단위는 만원으로 가정
client <- data.frame(name,gender,price)


client$result <- ifelse(price >= 65, 'Best', 'Normal')
client$gender2 <- ifelse(gender == 'M', 'Male', 'Female')

client

x <- c(2, 3, 5, 6, 7, 10)
max(x)
min(x)
mean(x)

x <- matrix(c(1:12), 3)
x
t(x)

hf <- read.csv('testdata/galton.csv')
hf_woman <- subset(hf, sex=='F')
head(hf_woman)

model <- lm(height ~ mother, data=hf_woman)
model

mynew <- hf_woman[c(1), ]
mynew <- edit(mynew) 
pred = predict(model, newdata = mynew)
pred
cat('예측값 : ', pred)








install.packages("plyr")
library(plyr)

a <- 10
b <- 20
ls()
rm(list=ls())
gc()
