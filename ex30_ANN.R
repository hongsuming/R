# ANN(인공신공망 알고리즘) - 분류 및 예측모델 작성 가능
# 노드(뉴런) 1개로만 구성된 알고리즘 - 퍼셉트론(perceptron) : 논리회로 중 XOR 해결 못 함
install.packages("nnet")
library(nnet)

input <- matrix(c(0, 0, 1, 1, 0, 1, 0, 1), ncol=2)
input #      [,1] [,2]
      # [1,]    0    0
      # [2,]    0    1
      # [3,]    1    0
      # [4,]    1    1

# and
output <- matrix(c(0, 0, 0, 1))
output #      [,1]
       # [1,]    0
       # [2,]    0
       # [3,]    0
       # [4,]    1
ann <- nnet(input, output, maxit=100, size=1, decay=0.01) # 100번 학습 
ann

result <- predict(ann, input)
result #           [,1]
       # [1,] 0.3165459
       # [2,] 0.3144109
       # [3,] 0.3188413
       # [4,] 0.3168659
ifelse(result > 0.5, 1, 0) #      [,1]
                           # [1,]    0
                           # [2,]    0
                           # [3,]    0
                           # [4,]    1
# or
output <- matrix(c(0, 1, 1, 1))
output #      [,1]
       # [1,]    0
       # [2,]    1
       # [3,]    1
       # [4,]    1
ann <- nnet(input, output, maxit=100, size=1, dacay=0.01)
ann

result <- predict(ann, input)
result
ifelse(result > 0.5, 1, 0) #      [,1]
                           # [1,]    0
                           # [2,]    1
                           # [3,]    1
                           # [4,]    1
# XOR
output <- matrix(c(0, 1, 1, 0))
output #     [,1]
       # [1,]    0
       # [2,]    1
       # [3,]    1
       # [4,]    0
ann <- nnet(input, output, maxit=1000, size=2, dacay=0.01) # 결과가 제대로 안 나오면 maxit(학습), size(노드) 늘려줘서 해결 
ann

result <- predict(ann, input)
result
ifelse(result > 0.5, 1, 0) #      [,1]
                           # [1,]    0
                           # [2,]    1
                           # [3,]    1
                           # [4,]    0

# 연습2
df <- data.frame(
  x1 = 1:6,
  x2 = 6:1,
  y = factor(c('n', 'n', 'n', 'y', 'y', 'y'))
)
df #   x1 x2 y
   #    1  6 n
   #    2  5 n
   #    3  4 n
   #    4  3 y
   #    5  2 y
   #    6  1 y 
model_net <- nnet(y ~ ., df, size=2) # # weights:  5 // 최적의 기울기와 절편 찾기(오차가 점점 줄어듦), size(연산량)
                                     # initial  value 4.399087 
                                     # iter  10 value 0.126263
                                     # iter  20 value 0.000233
                                     # iter  30 value 0.000120
                                     # final  value 0.000043 
                                     # converged
model_net

summary(model_net) # a 2-1-1 network with 5 weights
                   # options were - entropy fitting 
                   # b->h1 i1->h1 i2->h1  // b : 경계값, h : hidden, i : input 
                   # -0.77   5.37  -5.68  // 가중치
                   # b->o  h1->o          // o : output
                   # -11.16  27.37        // 가중치 (기울기)
install.packages("devtools")
library(devtools)
source_url('https://gist.githubusercontent.com/fawda123/7471137/raw/466c1474d0a505ff044412703516c34f1a4684a5/nnet_plot_update.r')
plot.nnet(summary(model_net))
