# RandomForest : 앙상블 학습기법 - DecisionTree를 여러 개를 묶음
install.packages("randomForest")
library(randomForest)

set.seed(123)
idx <- sample(1:nrow(iris), nrow(iris) * 0.7)
train <- iris[idx, ]
test <- iris[-idx, ]

model <- randomForest(formula=Species ~ ., data=train)
model
(36 + 29 + 34) / nrow(train) # 0.9428571
model2 <- randomForest(formula=Species ~ ., data=train, ntree=200, mtry=3, na.action=na.omit)
model2
(36 + 30 + 34) /nrow(train) # 0.952381
model3 <- randomForest(formula=Species ~ ., data=train, importance=T, na.action=na.omit)
model3

importance(model3) # Petal.Length, Petal.Width가 Accuracy와 Gini 값이 높아 중요 변수임
varImpPlot(model3)

# 예측
pred <- predict(model3, test)
cat('예측값 : ', pred) # 예측값 :  1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 3 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3
cat('실제값 : ', test$Species) # 실제값 :  1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3 3 3 3 3 3
