# 추론통계를 위한 자료의 정리, 요약, 해석 등을 통해 자료의 특성을 규명하는 통계적 방법
data <- read.csv('testdata/descriptive.csv', header=T)
dim(data) # 300 8
head(data, 3) #   resident gender age level cost type survey pass
              # 1        1      1  50     1  5.1    1      1    2
              # 2        2      1  54     2  4.2    1      2    2
              # 3       NA      1  62     2  4.7    1      1    1
data <- na.omit(data) # NA 값 제거
summary(data$cost) #     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.  // cost : 생활비
                   # -457.200    4.750    5.400    3.674    6.300  115.700  
dim(data) # 139 8

data <- subset(data, data$cost >= 2 & data$cost <= 10)
data
dim(data) # 134 8

length(data$cost) # 134
plot(data$cost)
boxplot(data$cost)

mean(data$cost) # 5.420896
sd(data$cost) # 1.107261

# 왜도, 첨도 // 얼마나 치우쳐있는 가
install.packages("moments")
library(moments)

cost <- data$cost
skewness(cost) # -0.2402368 // skewness : 왜도 값
hist(cost, prob=T)
lines(density(cost))

kurtosis(cost) # 2.832625 // kurtosis : 첨도 값 

# 거주지역
data$resident2[data$resident == 1] <- '특별시'
data$resident2[data$resident >= 2 & data$resident <= 4] <- '광역시'
data$resident2[data$resident == 5] <- '시군'

head(data, 2) #   resident gender age level cost type survey pass resident2
              # 1        1      1  50     1  5.1    1      1    2    특별시
              # 2        2      1  54     2  4.2    1      2    2    광역시
x <- table(data$resident2)
x # 광역시   시군 특별시 
  #     53     18     63 
prop.table(x) #    광역시      시군    특별시 
              # 0.3955224 0.1343284 0.4701493

# 위와 유사한 작업을 통해 보고서 작성
