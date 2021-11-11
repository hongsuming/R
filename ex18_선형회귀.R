# 선형회귀 : cars dataset
head(cars, 3) #   speed dist // 속도(speed) 제동거리(dist)
              # 1     4    2
              # 2     4   10
              # 3     7    4
cor(cars$speed, cars$dist) # 0.8068949
model <- lm(formula=dist ~ speed, data=cars)
model # Call:
      # lm(formula = dist ~ speed, data = cars)
      # 
      # Coefficients:
      # (Intercept)        speed  
      #     -17.579        3.932
summary(model) # Call:
               # lm(formula = dist ~ speed, data = cars)
               # 
               # Residuals:
               #   Min      1Q  Median      3Q     Max 
               # -29.069  -9.525  -2.272   9.215  43.201 
               # 
               # Coefficients:
               #   Estimate Std. Error t value Pr(>|t|)    
               # (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
               #   speed         3.9324     0.4155   9.464 1.49e-12 ***
               #   ---
               #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
               # 
               # Residual standard error: 15.38 on 48 degrees of freedom
               # Multiple R-squared:  0.6511,	Adjusted R-squared:  0.6438 
               # F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

coef(model) # (Intercept)       speed // 회귀계수
            #  -17.579095    3.932409 
fitted(model)[1:4] #         1         2         3         4  // 예측값
                   # -1.849460 -1.849460  9.947766  9.947766 
residuals(model)[1:4] #         1         2         3         4 // 잔차
                      #  3.849460 11.849460 -5.947766 12.052234
fitted(model)[1:4] + residuals(model)[1:4] #  1  2  3  4 // 예측값 + 잔차 ==> 실제값
                                           #  2 10  4 22
cars$dist[1:4] # 2 10  4 22 // 실제값
confint(model) #                  2.5 %    97.5 % // 계수 신뢰구간 
               # (Intercept) -31.167850 -3.990340
               # speed         3.096964  4.767853
summary(model)$r.squared # 0.6510794 // 결정계수 

# 예측값
predict(model, newdata = data.frame(speed=10)) #        1 
                                               # 21.74499
