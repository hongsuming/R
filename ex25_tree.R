# 분류 분석 모델 중 Decision Tree(의사결정나무)
install.packages("party")
library(party)

airquality # 뉴욕의 대기질에 관련된 데이터 집합합
str(airquality)
dim(airquality) # 153   6
# 온도(종속변수)에 영향을 미치는 변수(독립변수)를 설정하고 분류 모델 작성
airmodel <- ctree(Temp ~ Ozone + Solar.R + Wind, data=airquality, ) # 종속변수 : Temp, 독립변수 : Ozone, Solar.R, Wind
airmodel # Response:  Temp 
         # Inputs:  Ozone, Solar.R, Wind 
         # Number of observations:  153 
         # 
         # 1) Ozone <= 37; criterion = 1, statistic = 56.086         // temp에 가장 영향을 미침 (solar가 가장 영향이 적음) : 오존량이 떨어지면 온도가 감소 
         # 2) Wind <= 15.5; criterion = 0.993, statistic = 9.387
         # 3) Ozone <= 19; criterion = 0.964, statistic = 6.299
         # 4)*  weights = 29 
         # 3) Ozone > 19
         # 5)*  weights = 69 
         # 2) Wind > 15.5
         # 6)*  weights = 7 
         # 1) Ozone > 37
         # 7) Ozone <= 65; criterion = 0.971, statistic = 6.691
         # 8)*  weights = 22 
         # 7) Ozone > 65
         # 9)*  weights = 26 

plot(airmodel)

# iris dataset (꽃의 종류별로 분류 : 3가지) -----------------------------------------------------------------------
# train / test
set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7) # 꼭 7대3 비율이 고정은 아님
train <- iris[idx, ]
test <- iris[-idx, ]

formula <- Species ~ .
irismodel <- ctree(formula=formula, data=train)
irismodel # 중요변수는 Petal.Length, Petal.Width

plot(irismodel)

# 예측
pred <- predict(irismodel, test)
pred

t <- table(pred, test$Species)
t
sum(diag(t)) / nrow(test) # 0.9777778

# 분류정확도 계산 함수
install.packages("caret")
library(caret)

confusionMatrix(pred, test$Species) # Accuracy : 0.9778

# 새 값으로 예측 
head(iris, 1)
newdf <- iris[1, ]
newdf
newdf$Sepal.Length <- 7
newdf$Sepal.Width <- 8
newdf$Petal.Length <- 7 # 기여도가 높음 (꽃의 종류 결정)
newdf$Petal.Width <- 8 # 기여도가 높음 (꽃의 종류 결정)
newdf
predict(irismodel, newdf) # virginica

