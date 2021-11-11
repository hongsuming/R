# 시각화 : 이산변수와 연속변수들을 그래프로 표시
# 이산변수 : 막대, 점, 원형, 선 등 그래프
# 연속변수 : 상자박스, 히스토그램, 산점도 등 


# 막대 그래프
stu <- read.csv("testdata/ex_studentlist.csv")
class(stu) # "data.frame"
head(stu, n=3) #     name gender age grade absence bloodtype height weight
               # 1 김길동     남  23     3      유         O  175.3   68.2
               # 2 이미린     여  NA     2      무        AB  170.1   53.0
               # 3 홍길동     남  24     4      무         B  175.0   80.1
barplot(stu$grade)
table(stu$grade) # 1 2 3 4 
                 # 4 5 4 2
barplot(stu$grade, xlab='학생', ylab='학년', main='제목', col=rainbow(4), horiz=T) # horiz=T : 가로막대 그래프
barplot(stu$grade, xlab='학생', ylab='학년', main='제목', col=rainbow(4), space=T) # space=T : 간격

par(mfrow=c(1, 2)) # 그래프 영역을 1행 2열로 변경
barplot(stu$grade, xlab='학생', ylab='학년', main='제목', col=rainbow(4), horiz=T)
barplot(stu$grade, xlab='학생', ylab='학년', main='제목', col=rainbow(4), space=T)

# 점 그래프
par(mfrow=c(1, 1))
dotchart(stu$grade)
dotchart(stu$grade, color=2:5, lcolor='black', pch=1.2, cex=2) # pch : 점의 모양, cex : 점의 크기

# 원 그래프
df <- na.omit(stu) # NA 값을 포함한 데이터는 제외
df
pie(df$age, labels=df$age, lty=2) # lty : 라인 스타일 
title('원 그래프')

# 연속형 데이터를 시각화
# boxplot
mean(stu$height); median(stu$height); quantile(stu$height) # 평균, 중앙값, 사분위 [1] 172.72
                                                           # [1] 175.3
                                                           # 0%    25%    50%    75%   100% 
                                                           # 155.20 167.55 175.30 177.55 188.00 
boxplot(stu$height, range=1) # range=1 : 최대 최소 값 선으로 연결해줌
boxplot(stu$height, range=1, notch=T)
abline(h=170, lty=3, col='blue') # 기준선 긋기

# 히스토그램
hist(stu$height)
hist(stu$height, breaks=5) # 막대의 간격 조절
hist(stu$height, breaks=5, prob=T) # prob : 밀도로 표시 
lines(density(stu$height)) # line 표시

# scatter plot
plot(stu$height)

# 시각화 지원 라이브러리
install.packages("ggplot2")
library(ggplot2)

data(mpg) # 자동차 정보 데이터 셀
mpg

ggplot(data=mpg, aes(x=displ))
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() # x축 : 배기량 y축 : 연비
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_boxplot()
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_line()
