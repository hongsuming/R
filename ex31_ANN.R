# ANN : iris dataset

library(devtools)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')

set.seed(123)
idx <- sample(1:nrow(iris), 0.7 * nrow(iris))
train <- iris[idx, ]
test <- iris[-idx, ]
dim(train) # 105   5
dim(test) # 45  5

# node가 1개
model <- nnet(Species ~ ., train, size=1)
model
summary(model) # a 4-1-3 network with 11 weights // 입력 4개 출력 3개
               # options were - softmax modelling 
               # b->h1  i1->h1  i2->h1  i3->h1  i4->h1 
               # 3.03    0.39    0.56   -1.17   -1.17 
               # b->o1  h1->o1 
               # -46.81   79.97 
               # b->o2  h1->o2 
               # -0.17   26.97 
               # b->o3  h1->o3 
               # 46.20 -106.93 
plot.nnet(summary(model))

# 분류 예측
pred <- predict(model, test, type='class')
t1 <- table(pred, test$Species) # 예측값, 실제값 순
t1 # pred         setosa versicolor virginica
   # setosa           14          0         0
   # versicolor        0         17         0
   # virginica         0          1        13
sum(diag(t1)) / nrow(test) # 0.9777778 // 정확도 97%

# node가 3개
model3 <- nnet(Species ~ ., train, size=3) # size로 노드 수 조절해서 결과를 더 잘 나오게 함  
model3
summary(model3) # a 4-3-3 network with 27 weights
                # options were - softmax modelling 
                # b->h1 i1->h1 i2->h1 i3->h1 i4->h1 
                # -8.65 -16.20 -36.79  38.59  19.31 
                # b->h2 i1->h2 i2->h2 i3->h2 i4->h2 
                # 6.17  11.23  28.51 -39.49 -17.88 
                # b->h3 i1->h3 i2->h3 i3->h3 i4->h3 
                # -33.44 -76.12 -56.39 109.83  76.07 
                # b->o1 h1->o1 h2->o1 h3->o1 
                # -4.21 -30.50  45.58  -4.82 
                # b->o2 h1->o2 h2->o2 h3->o2 
                # 29.67   2.67  -8.72 -25.17 
                # b->o3 h1->o3 h2->o3 h3->o3 
                # -25.27  28.86 -36.60  30.06
plot.nnet(summary(model3))

# 분류 예측
pred3 <- predict(model3, test, type='class')
t3 <- table(pred3, test$Species) # 예측값, 실제값 순
t3 # pred3        setosa versicolor virginica
   # setosa           14          0         0
   # versicolor        0         17         0
   # virginica         0          1        13
sum(diag(t3)) / nrow(test) # 0.9777778 // 정확도 97% (97%보다 높게 나오기는 힘듦)

