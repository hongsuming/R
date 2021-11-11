# 로지스틱 회귀분석 (분류) - weather.csv로 내일 비 유무 분류예측 모델
weather <- read.csv('testdata/weather.csv')
head(weather, 5)
dim(weather) # 366  15
str(weather)

weather_df <- weather[, c(-1, -6, -8, -14)] # 필요없는 열 제외 
head(weather_df) #   MinTemp MaxTemp Rainfall Sunshine WindGustSpeed WindSpeed Humidity Pressure Cloud Temp RainTomorrow
                 # 1     8.0    24.3      0.0      6.3            30        20       29   1015.0     7 23.6          Yes
                 # 2    14.0    26.9      3.6      9.7            39        17       36   1008.4     3 25.7          Yes
                 # 3    13.7    23.4      3.6      3.3            85         6       69   1007.2     7 20.2          Yes
                 # 4    13.3    15.5     39.8      9.1            54        24       56   1007.0     7 14.1          Yes
                 # 5     7.6    16.1      2.8     10.6            50        28       49   1018.5     7 15.4           No
                 # 6     6.2    16.9      0.0      8.2            44        24       57   1021.7     5 14.8           No
# NA가 있는 행 찾기
weather_df[!complete.cases(weather_df), ]
sum(is.na(weather_df)) # 5
weather_df <- na.omit(weather_df)
sum(is.na(weather_df)) # 0

# RainTomorrow는 더미변수(명목척도화 : 변수 값을 0과 1로 변환)로 변환
weather_df$RainTomorrow[weather_df$RainTomorrow == 'Yes'] <- 1 # RainTomorrow가 'Yes'이면 1로
weather_df$RainTomorrow[weather_df$RainTomorrow == 'No'] <- 0 # RainTomorrow가 'No'이면 0으로
weather_df$RainTomorrow <- as.numeric(weather_df$RainTomorrow) # 숫자로 형 변환
head(weather_df)
str(weather_df)

# train / test
idx <- sample(1:nrow(weather_df), nrow(weather_df) * 0.7)
train <- weather_df[idx, ]
test <- weather_df[-idx, ]
dim(train) # 252  11
dim(test) # 109  11

# 모델 작성
wmodel <- glm(RainTomorrow ~ ., data=train, family='binomial')
wmodel
summary(wmodel) # Number of Fisher Scoring iterations: 6 // 학습 횟수 
# 결과를 볼 때 일부 변수는 제외하는 것이 효과적

# 모델 평가
pred <- predict(wmodel, newdata=test, type='response')
head(pred, 10)
head(test$RainTomorrow[1:10])

result_pred <- ifelse(pred > 0.5, 1, 0)
table(result_pred) # result_pred // 비가 온다 안 온다에 대한 빈도 표
                   #       0   1 
                   #     100   9 

# 모델 평가표(confusion matrix : 혼돈행렬)
t <- table(result_pred, test$RainTomorrow) # result_pred  0  1
                                           #           0 84  7
                                           #           1  6 12
sum(diag(t)) / nrow(test) # 0.9266055 // 92%

# ROC Curve로 모델 평가 
install.packages("ROCR")
library(ROCR)

pr <- prediction(pred, test$RainTomorrow) # 예측값, 실제값 (순서 유의)
pr

prf <- performance(pr, measure = 'tpr', x.measure='fpr')
plot(prf)

# AUC : ROC Curve의 밑면적을 계산한 값. 1에 가까울수록 좋음
auc <- performance(pr, measure='auc')
auc

auc <- auc@y.values[[1]]
auc # 0.8517628 // 매우 우수한 이진 분류모델

# 새값으로 예측
new_data <- train[c(1:3), ]
new_data <- edit(new_data)
new_data

new_pred <- predict(wmodel, newdata=new_data, type='response')
ifelse(new_pred > 0.5, '흐림', '맑음') # "맑음" "흐림" "맑음" 
