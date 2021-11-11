# Ligistic Regression - 이진 분류(시그모이드 함수 사용용)
# 상관/인과관계 x
# 독립변수 ; 연속형, 종속변수 : 범주형

# 연습1 - binary.csv : 영어 성적 등으로 대학원 입학 여부 분류 모델 작성하기
mydata <- read.csv('testdata/binary.csv')
head(mydata, 5) #   admit gre  gpa rank
                # 1     0 380 3.61    3
                # 2     1 660 3.67    3
                # 3     1 800 4.00    1
                # 4     1 640 3.19    4
                # 5     0 520 2.93    4
dim(mydata) # 400   4
str(mydata) # 'data.frame':	400 obs. of  4 variables:
            # $ admit: int  0 1 1 1 0 1 1 0 1 0 ...
            # $ gre  : int  380 660 800 640 520 760 560 400 540 700 ...
            # $ gpa  : num  3.61 3.67 4 3.19 2.93 3 2.98 3.08 3.39 3.92 ...
            # $ rank : int  3 3 1 4 4 2 1 2 3 2 ...
summary(mydata) #      admit             gre             gpa             rank      // 데이터의 대략적 분포 확인
                # Min.   :0.0000   Min.   :220.0   Min.   :2.260   Min.   :1.000  
                # 1st Qu.:0.0000   1st Qu.:520.0   1st Qu.:3.130   1st Qu.:2.000  
                # Median :0.0000   Median :580.0   Median :3.395   Median :2.000  
                # Mean   :0.3175   Mean   :587.7   Mean   :3.390   Mean   :2.485  
                # 3rd Qu.:1.0000   3rd Qu.:660.0   3rd Qu.:3.670   3rd Qu.:3.000  
                # Max.   :1.0000   Max.   :800.0   Max.   :4.000   Max.   :4.000

# admit에 대한 rank 빈도 수 출력
table(mydata$admit, mydata$rank) #      1  2  3  4 // rank
                                 #   0 28 97 93 55 // 불합격(admit)
                                 #   1 33 54 28 12 // 합격  (admit)
# 위와 같은 내용
xtabs(formula = ~admit + rank, data=mydata) #      rank
                                            # admit  1  2  3  4
                                            # 0     28 97 93 55
                                            # 1     33 54 28 12

# train
set.seed(1)
idx <- sample(1:nrow(mydata), nrow(mydata) * 0.7)
length(idx) # 280
train <- mydata[idx, ]
test <- mydata[-idx, ]
dim(train) # 280   4
dim(test) # 120   4

# 모델 작성
lgmodel <- glm(formula = admit ~ ., data=train, family=binomial(link='logit')) # . : admit을 제외한 나머지 // 이항분포
lgmodel

summary(lgmodel)

# 분류 예측
pred <- predict(lgmodel, newdata=test, type='response') 
cat('예측값 : ', head(pred, 10)) # 예측값 :  0.7357278 0.1456463 0.09775971 0.3832154 0.4278922 0.2434423 0.2308873 0.5384551 0.3128394 0.09603385
cat('예측값 : ', head(ifelse(pred > 0.5, 1, 0), 30)) # 예측값 :  1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1
cat('실제값 : ', test$admit[1:30]) # 실제값 :  1 1 0 1 1 0 1 0 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 0 0 0 0 1 0

# 분류 정확도 계산
result_pred <- ifelse(pred > 0.5, 1, 0)
t <- table(result_pred, test$admit) # confusion matrix
t # result_pred  0  1
  #           0 77 24 // 제대로 예측한 것 : 77
  #           1  8 11 // 제대로 예측한 것 : 11
(77+11) / nrow(test) # 0.7333333 // 분류 정확도 73%
(t[1,1] + t[2,2]) / nrow(test) # 0.7333333
sum(diag(t)) / nrow(test) # 0.7333333

# 새값으로 분류
new_data <- test[c(1:3), ]
new_data <- edit(new_data)
new_data #   admit gre gpa rank
         # 3     1 800 4.00    1
         # 4     1 640 3.19    4
         # 5     0 520 2.93    4

new_pred <- predict(lgmodel, newdata=new_data, type='response')
new_pred #         3         4         5 
         # 0.73572784 0.14564633 0.09775971  
ifelse(new_pred > 0.5, '합격', '불합격') # "합격" "불합격" "불합격" 
