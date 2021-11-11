# 상관분석 : 두 변수 사이의 관계를 수치적으로 나타내는 분석
# 예1)
x <- c(1, 2, 3, 4, 5)
y <- c(3, 5, 8, 11, 13) 
plot(x, y)

cov(x, y) # 공분산 6.5 양의 관계. 힘의 크기는 단위가 제각각이므로 관계를 구체적으로 표현할 수 없다.
cor(x, y) # 0.9970545 // 상관계수(변함 없음) 

# 예2) 아버지와 아들 키의 자료로 상관분석 
hf <- read.csv('testdata/galton.csv', header=T)
dim(hf) # 898   6
summary(hf) 
class(hf) # "data.frame"
head(hf, 5) #   family father mother sex height nkids
            # 1      1   78.5   67.0   M   73.2     4
            # 2      1   78.5   67.0   F   69.2     4
            # 3      1   78.5   67.0   F   69.0     4
            # 4      1   78.5   67.0   F   69.0     4
            # 5      2   75.5   66.5   M   73.5     4
hf_man <- subset(hf, sex=='M')
head(hf_man, 5) #    family father mother sex height nkids
                # 1       1   78.5   67.0   M   73.2     4
                # 5       2   75.5   66.5   M   73.5     4
                # 6       2   75.5   66.5   M   72.5     4
                # 9       3   75.0   64.0   M   71.0     2
                # 11      4   75.0   64.0   M   70.5     5
hf_man <- hf_man[c('father', 'height')]
head(hf_man, 5) #    father height
                # 1    78.5   73.2
                # 5    75.5   73.5
                # 6    75.5   72.5
                # 9    75.0   71.0
                # 11   75.0   
dim(hf_man) # 465   2

cov_xy <- cov(hf_man$father, hf_man$height) # 2.368441 // 공분산 : 관계의 방향을 알 수 있으나 관계의 정도를 정확히 알 수 없음
cov_xy
# 상관계수는 공분산을 각 변수의 표준편차의 곱으로 나눔 
r_xy <- cov_xy / (sd(hf_man$father) * sd(hf_man$height))
r_xy # 0.3913174

cor(hf_man$father, hf_man$height) # 0.3913174 // 아빠 키가 1단위 증가하면 아들 키는 0.3913174 단위 증가함 (양의 상관관계이기 때문에 증가)
cor(hf_man$father, hf_man$height, method='pearson') # 0.3913174
