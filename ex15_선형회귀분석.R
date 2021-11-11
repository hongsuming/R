# 선형회귀분석 모델 작성
# y = wx + b 일차방장식의 w : 기울기, b : 절편 구하기

# 부모의 IQ와 자녀의 IQ로 선형회귀분석
x <- c(110, 120, 130, 140, 150) # 부모의 IQ
y <- c(100, 105, 128, 115, 142) # 자녀의 IQ

cov(x, y) # 235 // 공분산 (필요 없음)
cor(x, y) # 0.8660744 // 상관계수 (양의 상관관계가 매우 높음)

# 분석가의 판단을 보니 부모의 IQ가 자녀의 IQ에 영향을 주는 것으로 보임 (인과관계)
# 선형회귀분석 진행
plot(x, y)

x_dev <- x - mean(x) # 편차(전차)
y_dev <- y - mean(y)
dev_mul <- (x - mean(x)) * (y - (mean(y)))
square <- x_dev ** 2
df <- data.frame(x, y, x_dev, y_dev, dev_mul, square) # x값, y값, x의 편차, y의 편차, y, x의 편차 곱
df #     x   y x_dev y_dev dev_mul square
   # 1 110 100   -20   -18     360    400
   # 2 120 105   -10   -13     130    100
   # 3 130 128     0    10       0      0
   # 4 140 115    10    -3     -30    100
   # 5 150 142    20    24     480    400
mean(df$x) # 130 // x의 평균값
mean(df$y) # 118 // y의 평균값
sum(df$dev_mul) # 940 // 분자로 사용 (두 확률 변수의 편차곱의 합)
sum(df$square) # 1000 // 분모로 사용 
slope <- sum(df$dev_mul) / sum(df$square)
slope # 0.94 // 기울기 
bias <- mean(df$y) - (slope * mean(df$x))
bias # -4.2 // 절편
# y = solpe * x + bais 회귀분석 모델 수식이 완성 (기울기 * x값 + 절편)
pred_y = slope * 100 + bias # 부모의 IQ가 100일 때 자식의 IQ
pred_y # 89.8 

pred_y = slope * 110 + bias # 부모의 IQ가 100일 때 자식의 IQ
pred_y # 99.2  

# R이 제공하는 함수를 이용해 선형 회귀모델(수식) 얻기
?lm
model <- lm(y ~ x) # 종속변수 ~ 독립변수 
model # Call:
      # lm(formula = y ~ x)
      # 
      # Coefficients:
      #   (Intercept)            x  
      #         -4.20         0.94  위에서 구했던 절편, 기울기를 lm을 사용하여 바로 구할 수 있음(최소제곱법)
plot(x, y)
abline(model, col='blue')


# 연습2 : 시간당 급여액에 대한 회귀분석
df <- data.frame(workhour = 1:7, totalpay = seq(10000, 7000, by = 10000))
df

cor(df$workhour, df$totalpay)
plot(totalpay ~ workhour, data=df)

model <- lm(totalpay ~ workhour, data=df)
model # bias -5.5e-12 slope 1.0e+04

pred_y <- 1.0e+04 * 3 + -5.5e-12
cat('예측 값 y : ', pred_y)

grid()
abline(model, col='blue', lwd=2)

# 예측값 함수
pred_y <- predict(model)
pred_y

new_pred <- predict(model, data.frame(workhour = c(8, 2.2, 7.8)))
new_pred # 80000, 22000, 78000