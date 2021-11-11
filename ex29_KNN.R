# KNN(최근접 이웃 알고리즘) - k값이 중요

install.packages("ggvis")
library(ggvis)

cor(iris[, 1:4]) # 상관관계 
unique(iris$Species) # setosa     versicolor virginica // 꽃의 종류

iris %>% ggvis(~Petal.Length, ~Petal.Width, fill=~factor(Species))

# 데이터 표준화 : (요소값 - 최소값) / (최대값 - 최소값)
func_normal <- function(x){
  num <- x - min(x)
  m_m <- max(x) - min(x)
  return(num / m_m)
}

# test <- data.frame(x=c(1, 2, 3, 4, 5))
# func_normal(test) # 1 0.00
#                   # 2 0.25
#                   # 3 0.50
#                   # 4 0.75
#                   # 5 1.00
# lapply(test, func_normal) # 0.00 0.25 0.50 0.75 1.00

head(iris, 3)
normal_d <- as.data.frame(lapply(iris[1:4], func_normal)) # 0에서 1사이의 범위 내에 갇아버림 
head(normal_d, 3) #   Sepal.Length Sepal.Width Petal.Length Petal.Width
                  # 1    0.2222222   0.6250000   0.06779661  0.04166667
                  # 2    0.1666667   0.4166667   0.06779661  0.04166667
                  # 3    0.1111111   0.5000000   0.05084746  0.04166667

df <- data.frame(normal_d, Species=iris$Species)
head(df, 3) #   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
            # 1    0.2222222   0.6250000   0.06779661  0.04166667  setosa
            # 2    0.1666667   0.4166667   0.06779661  0.04166667  setosa
            # 3    0.1111111   0.5000000   0.05084746  0.04166667  setosa

set.seed(123)
idx <- sample(1:nrow(df), nrow(df) * 0.7) # 꼭 7:3으로 안 나눠도 됨
ir_train <- df[idx, ]
ir_test <- df[-idx, ]
dim(ir_train) # 105   5
dim(ir_test) # 45  5

library(class)
model <- knn(train=ir_train[, -5], test=ir_test[, -5], cl=ir_train$Species, k=3)
model # predict() 함수 지원하지 않음 
summary(model) #     setosa versicolor  virginica 
               #         14         18         13

t <- table(model, ir_test$Species)
t # model        setosa versicolor virginica
  # setosa           14          0         0
  # versicolor        0         17         1
  # virginica         0          1        12
acc <- sum(diag(t)) / nrow(ir_test)
acc # 0.9555556 // 95%

install.packages("gmodels")
library(gmodels)
CrossTable(x=ir_test$Species, y=model) # 실제값, 예측값 순으로

# 모델2
model2 <- knn(train=ir_train[, -5], test=ir_test[, -5], cl=ir_train$Species, k=11) # k값을 바꿔가면서 확인
model2 # predict() 함수 지원하지 않음 
summary(model2) #     setosa versicolor  virginica 
                #         14         17         14

t2 <- table(model2, ir_test$Species)
t2 # model2       setosa versicolor virginica
   #   setosa         14          0         0
   #   versicolor      0         17         0
   #   virginica       0          1        13
acc2 <- sum(diag(t2)) / nrow(ir_test)
acc2 # 0.9777778 // 97%

# 반복문으로 최적의 k값 얻기
k = seq(from=3, to=13, by=2)
k # 3  5  7  9 11 13

result <- c()
for(i in k){
  m <- knn(train=ir_train[, -5], test=ir_test[, -5], cl=ir_train$Species, k=i)
  tab <- table(m, ir_test$Species)
  accuracy <- sum(diag(tab)) / nrow(ir_test)
  result <- c(result, accuracy)
}
result # 0.9555556 0.9555556 0.9555556 0.9777778 0.9777778 0.9777778 // k값이 3, 5, 7, 9, 11, 13일 때의 정확도 

acc_df <- data.frame(k값=k, 정확도=result)
acc_df #   k값    정확도
       # 1   3 0.9555556
       # 2   5 0.9555556
       # 3   7 0.9555556
       # 4   9 0.9777778
       # 5  11 0.9777778
       # 6  13 0.9777778
plot(acc_df)
