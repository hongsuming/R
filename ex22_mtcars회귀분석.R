# 단순 / 다중 회귀분석 : mtcars dataset

head(mtcars)
str(mtcars)
dim(mtcars) # 32 11

# 연습1 - 단순선형회귀
# 1. 임의의 마력수를 입력하면 연비를 예측하는 모델 얻기
# 2. 데이터 수집 후 가공하기 (이미 제공되는 mtcars 데이터 사용)
# hp : 독립변수 , mpg : 종속변수

# 상관관계 확인
cor(mtcars$ hp, mtcars$mpg) # -0.7761684 // 음의 상관관계가 매우 높음 (둘 사이는 반비례 관계)
plot(mpg ~ hp, data=mtcars)

# 인과관계가 있다고 판단 됨
model <- lm(mpg ~ hp, data=mtcars)
model
# y = -0.06823 * new_hp + 30.09886
summary(model) # p-value: 1.788e-07 < 0.05 유의한 모델. R-squared:  0.6024
abline(model, col='blue') # 추세선 

# 예측 - 수식 사용
new_hp = 110
cat('예측값 : ', -0.06823 * new_hp + 30.09886) # 예측값 :  22.59356
new_hp = 160
cat('예측값 : ', -0.06823 * new_hp + 30.09886) # 예측값 :  19.18206
new_hp = 70
cat('예측값 : ', -0.06823 * new_hp + 30.09886) # 예측값 :  25.32276

# 예측 - predict 함수
mynew <- mtcars[c(1, 2), ]
mynew <- edit(mynew) # hp를 160, 70으로 수정
mynew #               mpg cyl disp  hp drat    wt  qsec vs am gear carb
      # Mazda RX4      21   6  160 160  3.9 2.620 16.46  0  1    4    4
      # Mazda RX4 Wag  21   6  160  70  3.9 2.875 17.02  0  1    4    4
pred = predict(model, newdata = mynew)
pred #     Mazda RX4 Mazda RX4 Wag 
     #      19.18234      25.32288 
cat('예측값 : ', pred) # 예측값 :  19.18234 25.32288

# 연습2 - 다중선형회귀
# 1. 임의의 마력수, 차체무게를 입력하면 연비를 예측하는 모델 얻기
# 2. 데이터 수집 후 가공하기 (이미 제공되는 mtcars 데이터 사용)
# hp, wt : 독립변수 , mpg : 종속변수
cor(mtcars$hp, mtcars$mpg) # -0.7761684 // 음의 상관계수 높음
cor(mtcars$wt, mtcars$mpg) # -0.8676594 // 음의 상관계수 높음 

model2 <- lm(mpg ~ hp + wt, data=mtcars)
model2 # Coefficients:
       # (Intercept)           hp           wt  
       #    37.22727     -0.03177     -3.87783

summary(model2) # p-value: 9.109e-12 < 0.05 유의한 모델. Adjusted R-squared:  0.8148 
# y = -0.03177 * new_hp + -3.87783 * new_wt + 37.22727

# 예측 - 수식 사용
new_hp = 110
new_wt = 2.620
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727) # 예측값 :  23.57266
new_hp = 150
new_wt = 5.620
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727) # 예측값 :  10.66837
new_hp = 80
new_wt = 1.620
cat('예측값 : ', -0.03177 * new_hp + -3.87783 * new_wt + 37.22727) # 예측값 :  28.40359

# 예측값 / 실제값 비교
pred2 = predict(model2)
cat('예측값 : ', pred2[1:10]) # 예측값 :  23.57233 22.58348 25.27582 21.26502 18.32727 20.47382 15.59904 22.88707 21.99367 19.97946
cat('실제값 : ', mtcars$mpg[1:10]) # 실제값 :  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2

# 예측 - predict 함수 
new_data <- data.frame(hp=110, wt=2.620)
predict(model2, newdata=new_data) # 23.57233
new_data <- data.frame(hp=80, wt=1.620)
predict(model2, newdata=new_data) # 28.40335 
new_data <- data.frame(hp=150, wt=5.620)
predict(model2, newdata=new_data) # 10.66792 
