# SVM으로 분류모델 작성 : iris dataset
library(e1071)

head(iris, 5) #   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
              # 1          5.1         3.5          1.4         0.2  setosa
              # 2          4.9         3.0          1.4         0.2  setosa
              # 3          4.7         3.2          1.3         0.2  setosa
              # 4          4.6         3.1          1.5         0.2  setosa
              # 5          5.0         3.6          1.4         0.2  setosa
# 모델 생성1
svm_model <- svm(Species ~ ., data=iris)
svm_model # Parameters:
          # SVM-Type:  C-classification 
          # SVM-Kernel:  radial 
          # cost:  1 
          # 
          # Number of Support Vectors:  51
summary(svm_model) # Parameters:
                   # SVM-Type:  C-classification 
                   # SVM-Kernel:  radial 
                   # cost:  1 
                   # 
                   # Number of Support Vectors:  51
                   # 
                   # ( 8 22 21 )
                   # 
                   # 
                   # Number of Classes:  3 
                   # 
                   # Levels: 
                   #   setosa versicolor virginica

# 모델 생성2 (1번째와 형식만 다를 뿐 결과는 같음)
x <- subset(iris, select=-Species) # 독립변수
y <- iris$Species

svm_model2 <- svm(x, y)
summary(svm_model2) # Parameters:
                    # SVM-Type:  C-classification 
                    # SVM-Kernel:  radial 
                    # cost:  1 
                    # 
                    # Number of Support Vectors:  51
                    # 
                    # ( 8 22 21 )
                    # 
                    # 
                    # Number of Classes:  3 
                    # 
                    # Levels: 
                    #   setosa versicolor virginica
dist(iris[, -5], method='euclidean') # 유클리디안 거리계산법
cmdscale(dist(iris[, -5])) # 유클리디안 거리 계산 결과를 공간적인 배치 형식으로 보기 
plot(cmdscale(dist(iris[, -5])), col=as.integer(iris[, 5]), pch=c('o', '+')[1:150 %in% svm_model2$index + 1])

pred <- predict(svm_model2, x)
head(pred, 5) #      1      2      3      4      5  // 예측값
              # setosa setosa setosa setosa setosa 
              # Levels: setosa versicolor virginica
t <- table(pred, y) # confusion matrix 
t # pred         setosa versicolor virginica
  # setosa         50          0         0
  # versicolor      0         48         2
  # virginica       0          2        48

sum(diag(t)) / nrow(x) # 0.9733333 // 분류정확도 97%

# 최상의 모델을 위한 튜닝
svm_tune <- tune(svm, train.x=x, train.y=y, kernel='radial', ranges=list(cost=c(0.01, 0.1, 1, 10, 100)), 
                 gammer=c(0.25, 0.5, 1.0, 2.0, 4.0))
svm_tune # - sampling method: 10-fold cross validation 
         # 
         # - best parameters:
         #   cost
         # 1
         # 
         # - best performance: 0.04 

svm_after_tune <- svm(Species ~., data=iris, kernel='radial', cost=1)
summary(svm_after_tune)

pred <- predict(svm_after_tune, x, type='response')
t <- table(pred, y) # confusion matrix
t # pred         setosa versicolor virginica
  # setosa         50          0         0
  # versicolor      0         48         2
  # virginica       0          2        48
 
sum(diag(t)) / nrow(x) # 0.9733333
