# 다중회귀 분석 : 독립변수가 복수
state.x77 # 미국 각 주 관련 dataset
str(state.x77)
class(state.x77) # "matrix" "array" 


states <- as.data.frame(state.x77[, c('Murder', 'Population', 'Illiteracy', 'Income', 'Frost')])
str(states) # 'data.frame':	50 obs. of  5 variables:
            # $ Murder    : num  15.1 11.3 7.8 10.1 10.3 6.8 3.1 6.2 10.7 13.9 ...
            # $ Population: num  3615 365 2212 2110 21198 ...
            # $ Illiteracy: num  2.1 1.5 1.8 1.9 1.1 0.7 1.1 0.9 1.3 2 ...
            # $ Income    : num  3624 6315 4530 3378 5114 ...
            # $ Frost     : num  20 152 15 65 20 166 139 103 11 60 ...
names(states) # "Murder"     "Population" "Illiteracy" "Income"     "Frost" // 살인사건 발생률, 인구수, 문맹률, 수입, 결빙일

cor(states) #                Murder Population Illiteracy     Income      Frost
            # Murder      1.0000000  0.3436428  0.7029752 -0.2300776 -0.5388834
            # Population  0.3436428  1.0000000  0.1076224  0.2082276 -0.3321525
            # Illiteracy  0.7029752  0.1076224  1.0000000 -0.4370752 -0.6719470
            # Income     -0.2300776  0.2082276 -0.4370752  1.0000000  0.2262822
            # Frost      -0.5388834 -0.3321525 -0.6719470  0.2262822  1.0000000
# 모델 작성
model <- lm(formula = Murder ~ Population + Illiteracy + Income + Frost, data=states)
model # Call:
      # lm(formula = Murder ~ Population + Illiteracy + Income + Frost, 
      #    data = states)
      # 
      # Coefficients:
      # (Intercept)   Population   Illiteracy       Income        Frost  
      #   1.235e+00    2.237e-04    4.143e+00    6.442e-05    5.813e-04
# y = wx + b // y = w1x1 + w2x2 + w3x3 + w4x4 ... + b (다중회귀 분석)
summary(model) # Call:
               # lm(formula = Murder ~ Population + Illiteracy + Income + Frost, 
               #    data = states)
               # 
               # Residuals:
               #   Min      1Q  Median      3Q     Max 
               # -4.7960 -1.6495 -0.0811  1.4815  7.6210 
               # 
               # Coefficients:
               #   Estimate Std. Error t value Pr(>|t|)    
               # (Intercept) 1.235e+00  3.866e+00   0.319   0.7510    
               # Population  2.237e-04  9.052e-05   2.471   0.0173 *  
               #   Illiteracy  4.143e+00  8.744e-01   4.738 2.19e-05 ***
               #   Income      6.442e-05  6.837e-04   0.094   0.9253    
               # Frost       5.813e-04  1.005e-02   0.058   0.9541    
               # ---
               #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
               # 
               # Residual standard error: 2.535 on 45 degrees of freedom
               # Multiple R-squared:  0.567,	Adjusted R-squared:  0.5285 
               # F-statistic: 14.73 on 4 and 45 DF,  p-value: 9.133e-08 // p 밸류가 0.05보다 작으므로 유의한 모델 

# 회귀분석모형의 적절성을 위한 조건 : 아래의 조건 위배 시에는 변수 제거나 조정을 신중히 고려해야 함.
# 1) 정규성 : 독립변수들의 잔차항이 정규분포를 따라야 한다.
# 2) 독립성 : 독립변수들 간의 값이 서로 관련성이 없어야 한다.
# 3) 선형성 : 독립변수의 변화에 따라 종속변수도 변화하나 일정한 패턴을 가지면 좋지 않다.
# 4) 등분산성 : 독립변수들의 오차(잔차)의 분산은 일정해야 한다. 특정한 패턴 없이 고르게 분포되어야 한다.
# 5) 다중공선성 : 독립변수들 간에 강한 상관관계로 인한 문제가 발생하지 않아야 한다.
# 예) 나이와 학년이 신체 구조에 미치는 영향(교집합이 매우 커 다중공선성 우려).

# 시각화
par(mfrow=c(2, 2))
plot(model)

# 잔차의 정규성 
shapiro.test(residuals(model)) # 	Shapiro-Wilk normality test
                               # data:  residuals(model)
                               # W = 0.98264, p-value = 0.6672 // 정규성에서는 0.05보다 커야 정규성을 만족함 

install.packages("car", dependencies=T) # car에 종속적인 모든 패키지 설치치
library(car)
# 독립성 : D-W Statistic 값이 2에 가까울수록 좋음 
durbinWatsonTest(model) #  lag Autocorrelation D-W Statistic p-value
                        #    1      -0.2006929      2.317691   0.276
                        #   Alternative hypothesis: rho != 0

# 선형성
boxTidwell(Murder ~ Population + Illiteracy, data=states) #            MLE of lambda Score Statistic (z) Pr(>|z|)
                                                          # Population       0.86939             -0.3228   0.7468 // 0.05보다 크므로 선형성 만족
                                                          # Illiteracy       1.35812              0.6194   0.5357 // 0.05보다 크므로 선형성 만족 
                                                          # 
                                                          # iterations =  19 
# 등분산성
ncvTest(model) # Non-constant Variance Score Test 
               # Variance formula: ~ fitted.values 
               # Chisquare = 1.746514, Df = 1, p = 0.18632 // 0.05보다 크므로 등분산성 만족

# 다중공선성
vif(model) # Population Illiteracy     Income      Frost // 10을 넘으면 다중공선성 문제 발생 
           #   1.245282   2.165848   1.345822   2.082547
vif(model) > 10 # Population Illiteracy     Income      Frost 
                #      FALSE      FALSE      FALSE      FALSE 
sqrt(vif(model)) # Population Illiteracy     Income      Frost // 2를 넘으면 다중공선성 문제 발생 
                 #   1.115922   1.471682   1.160096   1.443103

# 예측값 얻기
# 기존 states로 학습
part_states <- states[1:3,] 
part_states #         Murder Population Illiteracy Income Frost
            # Alabama   15.1       3615        2.1   3624    20
            # Alaska    11.3        365        1.5   6315   152
            # Arizona    7.8       2212        1.8   4530    15
part_states <- edit(part_states) 
part_states #         Murder Population Illiteracy Income Frost
            # Alabama   15.1       1000        1.1   6000    22
            # Alaska    11.3        500        5.5   3000   200
            # Arizona    7.8       2000        7.8   2000    15
predict(model, part_states) #   Alabama    Alaska   Arizona 
                            #  6.414696 24.441538 34.133609 // Population  Illiteracy   Income   Frost   살인사건 발생률 예측값 
                                                            # 1000            1.1         6000    22    => 6.414696 
                                                            # 500             5.5         3000   200    => 24.441538 
                                                            # 2000            7.8         2000    15    => 34.133609  
# 독립변수 선택 방법
model2 <- lm(Murder ~ ., data=states)
summary(model2) # Adjusted R-squared: 0.5285

model3 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(model3) # Adjusted R-squared:  0.5484

# 두 개의 모델 비교: AIC
AIC(model2, model3) #        df      AIC // 값이 작은 것이 좋은 모델
                    # model2  6 241.6429
                    # model3  4 237.6565
# AIC를 자동으로 처리 : stepwise regression
# backward(후진소거법) : 모든 변수를 넣고 기여도가 낮은 것부터 하나씩 제거 
full_model <- lm(Murder ~ ., data=states)
reduce_model <- step(full_model, direction = 'backward')

summary(reduce_model)

# forward(전진소거법) : 변수를 하나씩 추가해 넣으며 모델 성능 파악
min_model <- lm(Murder ~ 1, data=states)
fwd_model <- step(min_model, direction='forward', scope=(Murder ~ Population + Illiteracy + Income + Frost), trace=1)
summary(fwd_model)

# 또 다른 방법
# all subset regression
library(leaps)
m <- leaps::regsubsets(Murder ~ Population + Illiteracy + Income + Frost, data=states, nbest=4)
summary(m)
par(mforw=c(1, 1, 1, 1))
plot(m, scale='adjr2')
