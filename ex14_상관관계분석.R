# 상관관계 분석
result <- read.csv("testdata/drinking_water.csv", header=T, fileEncoding = 'utf-8')
head(result) #   친밀도 적절성 만족도 // 건수 안 적으면 6개가 기본 값 
             # 1      3      4      3
             # 2      3      3      2
             # 3      4      4      4
             # 4      2      2      2
             # 5      2      2      2
             # 6      3      3      3 
str(result) # 'data.frame':	264 obs. of  3 variables:
            # $ 친밀도: int  3 3 4 2 2 3 4 2 3 4 ...
            # $ 적절성: int  4 3 4 2 2 3 4 2 2 2 ...
            # $ 만족도: int  3 2 4 2 2 3 4 2 3 3 ...
cov(result$친밀도, result$적절성) # 0.4164218 // 공분상
cov(result) #           친밀도    적절성    만족도
            # 친밀도 0.9415687 0.4164218 0.3756625
            # 적절성 0.4164218 0.7390108 0.5463331
            # 만족도 0.3756625 0.5463331 0.6868159

# 상관계수
cor(result$친밀도, result$적절성) # 0.4992086 // 피어슨 상관계수 (0.4~0.2) : 낮음
cor(result$친밀도, result$만족도) # 0.467145 
cor(result$적절성, result$만족도) # 0.7668527
cor(result$적절성+result$친밀도, result$만족도) # 0.7017394

cor(result, method='pearson') #           친밀도    적절성    만족도
                              # 친밀도 1.0000000 0.4992086 0.4671450
                              # 적절성 0.4992086 1.0000000 0.7668527
                              # 만족도 0.4671450 0.7668527 1.0000000

# 상관관계를 시각화
symnum(cor(result)) #        친 적 만 // 숫자를 심볼로 표시 
                    # 친밀도 1       
                    # 적절성 .  1    
                    # 만족도 .  ,  1 
                    # attr(,"legend")
                    # [1] 0 ‘ ’ 0.3 ‘.’ 0.6 ‘,’ 0.8 ‘+’ 0.9 ‘*’ 0.95 ‘B’ 1
install.packages("corrgram")
library(corrgram)
corrgram(result) # 색상으로 표시를 해줌 
corrgram(result, upper.panel = panel.conf)
corrgram(result, lower.panel = panel.conf)

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)

chart.Correlation(result, histogram = , pch='+')

# 참고
cor(result, method='spearman') #           친밀도    적절성    만족도 // 서열척도 (범주형)
                               # 친밀도 1.0000000 0.5110776 0.5012007
                               # 적절성 0.5110776 1.0000000 0.7485096
                               # 만족도 0.5012007 0.7485096 1.0000000
cor(result, method='kendall') #           친밀도    적절성    만족도
                              # 친밀도 1.0000000 0.4667293 0.4593528
                              # 적절성 0.4667293 1.0000000 0.7032140
                              # 만족도 0.4593528 0.7032140 1.0000000

# 상관계수 검정
x <- result$적절성
y <- result$만족도
cor.test(x, y, method='pearson') # 	Pearson's product-moment correlation
                                 # 
                                 # data:  x and y
                                 # t = 19.34, df = 262, p-value < 2.2e-16
                                 # alternative hypothesis: true correlation is not equal to 0
                                 # 95 percent confidence interval:
                                 #   0.7120469 0.8123706
                                 # sample estimates:
                                 #   cor 
                                 # 0.7668527 // 