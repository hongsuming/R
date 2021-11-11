# 단순 선형회귀 모델 : 미국 여성 키, 몸무게 데이터 사용
women #    height weight
      # 1      58    115
      # 2      59    117
      # 3      60    120
      # 4      61    123
      # 5      62    126
      # 6      63    129
      # 7      64    132
      # 8      65    135
      # 9      66    139
      # 10     67    142
      # 11     68    146
      # 12     69    150
      # 13     70    154
      # 14     71    159
      # 15     72    164
cor(women$height, women$weight) # 0.9954948 // 상관관계
plot(weight ~ height, data=women)

mfit <- lm(weight ~ height, data=women)
mfit # Call:
     # lm(formula = weight ~ height, data = women)
     # 
     # Coefficients:
     # (Intercept)       height  
     #      -87.52         3.45  
abline(mfit, col='red') # 추세선 
summary(mfit) # 요약통계량
# y = 3.45000 * x + -87.51667 // 예측값 구하는 식
y = 3.45000 * 58 + -87.51667
cat('예측 몸무게 : ', y) # 몸무게가 58키로이면 키가  112.5833

y = predict(mfit, data.frame(height = c(55, 60, 65, 78)))
cat('예측 몸무게 : ', y) # 예측 몸무게 :  102.2333 119.4833 136.7333 181.5833

rsq = cor(women$height, women$weight) ** 2
cat('r_squared : ', rsq) # r_squared :  0.9910098


# 회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
# 1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
# 2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
# 3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
# 4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
# 5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.
# 예) 나이와 학년이 신체 구조에 미치는 영향(교집합이 매우 커 다중공선성 우려)

par(mfrow=c(2, 2))
plot(mfit)

