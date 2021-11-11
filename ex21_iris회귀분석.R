# iris dataset으로 회귀분석 : train / test로 데이터 분리해서 처리
head(iris, 3) #   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
              # 1          5.1         3.5          1.4         0.2  setosa
              # 2          4.9         3.0          1.4         0.2  setosa
              # 3          4.7         3.2          1.3         0.2  setosa
str(iris) # 'data.frame':	150 obs. of  5 variables:
          # $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
          # $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
          # $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
          # $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
          # $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
NROW(iris) # 150

set.seed(12)
sam_tt <- sample(1:nrow(iris), nrow(iris) * 0.7, replace = F) # sample을 사용하면 데이터가 셔플(랜덤으로 섞임) 됨
NROW(sam_tt) # 105 
train <- iris[sam_tt, ] # 모델 학습용 데이터 train data
test <- iris[-sam_tt, ] # 모델 검정용 데이터 test data
dim(train) # 105   5
dim(test) # 45   5
head(train, 5) #    Sepal.Length Sepal.Width Petal.Length Petal.Width    Species
               # 90          5.5         2.5          4.0         1.3 versicolor
               # 80          5.7         2.6          3.5         1.0 versicolor
               # 91          5.5         2.6          4.4         1.2 versicolor
               # 69          6.2         2.2          4.5         1.5 versicolor
               # 34          5.5         4.2          1.4         0.2     setosa
head(test, 5) #    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
              # 3           4.7         3.2          1.3         0.2  setosa
              # 8           5.0         3.4          1.5         0.2  setosa
              # 9           4.4         2.9          1.4         0.2  setosa
              # 11          5.4         3.7          1.5         0.2  setosa
              # 17          5.4         3.9          1.3         0.4  setosa

# 모델 작성
model <- lm(Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, data=train) # 종속변수 ; Sepal.Length (train으로 학습)
summary(model) # Call:
               # lm(formula = Sepal.Length ~ Sepal.Width + Petal.Length + Petal.Width, 
               #    data = train)
               # 
               # Residuals:
               #   Min       1Q   Median       3Q      Max 
               # -0.81034 -0.24373  0.02319  0.22748  0.86552 
               # 
               # Coefficients:
               #   Estimate Std. Error t value Pr(>|t|)    
               #   (Intercept)   1.83811    0.33100   5.553 2.28e-07 ***
               #   Sepal.Width   0.65695    0.08725   7.529 2.20e-11 ***
               #   Petal.Length  0.73632    0.06935  10.618  < 2e-16 ***
               #   Petal.Width  -0.63742    0.15531  -4.104 8.24e-05 ***
               #   ---
               #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
               # 
               # Residual standard error: 0.3256 on 101 degrees of freedom
               # Multiple R-squared:   0.85,	Adjusted R-squared:  0.8455
   
library(car)
# 다중공선성 : 독립변수가 종속변수의 분산을 설명 (독립변수들이 너무 친해서 발생되는 문제)
vif(model) #  Sepal.Width Petal.Length  Petal.Width 
           #     1.337277    15.137142    14.014160 // 10을 넘으면 다중공선성 의심 (둘 중 하나 버려야 됨)

par(mfrow=c(2, 2))
plot(model)

# 정규성
shapiro.test(model$residuals) # W = 0.99245, p-value = 0.8316 // p 밸류가 0.05보다 크기 때문에 만족

# 독립성
durbinWatsonTest(model) # D-W Statistic = 2.496394 // 2에 가까우면 만족 

# 등분산성
ncvTest(model) # p = 0.12729 // 0.05보다 크기 때문에 만족

# 검정
pred <- predict(model, test) # train으로 학습하고 test로 검정 
pred # 45개에 대해 모델이 예측한 값이 나옴

cat('실제값 : ', head(test[, 1], 5)) # 실제값 :  4.7 5 4.4 5.4 5.4
cat('예측값 : ', pred[1:5]) # 예측값 :  4.770099 5.048755 4.646646 5.245841 5.102482

