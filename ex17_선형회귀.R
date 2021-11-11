# 선형회귀 : iris dataset
data(iris)
head(iris, 3) #   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
              # 1          5.1         3.5          1.4         0.2  setosa
              # 2          4.9         3.0          1.4         0.2  setosa
              # 3          4.7         3.2          1.3         0.2  setosa
names(iris) # "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width"  "Species"
dim(iris) # 150   5
cor(iris$Sepal.Length, iris$Petal.Length) # 0.8717538 // 강한 양의 상관관계
plot(iris$Sepal.Length, iris$Petal.Length)
cor(iris$Sepal.Length, iris$Sepal.Width) # -0.1175698 // 약한 음의 상관관계
plot(iris$Sepal.Length, iris$Sepal.Width)

# 모델 1 : 약한 음의 상관관계로 작성 
model1 <- lm(formula = Sepal.Length ~ Sepal.Width, data=iris)
model1 # Call:
       # lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
       # 
       # Coefficients:
       # (Intercept)  Sepal.Width  
       #      6.5262      -0.2234
summary(model1) # Call:
                # lm(formula = Sepal.Length ~ Sepal.Width, data = iris)
                # 
                # Residuals:
                #   Min      1Q  Median      3Q     Max 
                # -1.5561 -0.6333 -0.1120  0.5579  2.2226 
                # 
                # Coefficients:
                #   Estimate Std. Error t value Pr(>|t|)    
                # (Intercept)   6.5262     0.4789   13.63   <2e-16 ***
                #   Sepal.Width  -0.2234     0.1551   -1.44    0.152    
                # ---
                #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                # 
                # Residual standard error: 0.8251 on 148 degrees of freedom
                # Multiple R-squared:  0.01382,	Adjusted R-squared:  0.007159 // R-squared는 0.01로 설명이 매우 미약함(결정계수가 매우 낮음)
                # F-statistic: 2.074 on 1 and 148 DF,  p-value: 0.1519 // p 밸류가 0.05보다 크므로 모델로 유의하지 않다.

model2 <- lm(formula = Sepal.Length ~ Petal.Length, data=iris) # 꽃잎의 길이가 꽃받침에 길이에 영향을 주는 것 같애 
model2 # Call:
       # lm(formula = Sepal.Length ~ Petal.Length, data = iris)
       # 
       # Coefficients:
       # (Intercept)  Petal.Length  
       #      4.3066        0.4089 
summary(model2) # Call:
                #   lm(formula = Sepal.Length ~ Petal.Length, data = iris)
                # 
                # Residuals:
                #   Min       1Q   Median       3Q      Max 
                # -1.24675 -0.29657 -0.01515  0.27676  1.00269 
                # 
                # Coefficients:
                #   Estimate Std. Error t value Pr(>|t|)    
                # (Intercept)   4.30660    0.07839   54.94   <2e-16 ***
                #   Petal.Length  0.40892    0.01889   21.65   <2e-16 ***
                #   ---
                #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
                # 
                # Residual standard error: 0.4071 on 148 degrees of freedom
                # Multiple R-squared:   0.76,	Adjusted R-squared:  0.7583 
                # F-statistic: 468.6 on 1 and 148 DF,  p-value: < 2.2e-16 // p 밸류가 0.05보다 작으므로 모델로 유의함

# 상관계수가 낮은 경우에는 회귀모델로 사용할 수 없다. 
