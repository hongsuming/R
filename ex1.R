kbs <- 9
print(kbs)
KBS <- 7
print(KBS)
kb_s <- 5
print(kb_s)

a <- 10
b <- 20
(c <- a+b) # print() 처리 됨

# Ctrl + Shift + C 주석 처리 됨

# 데이터 유형 : numeric(integer, double), character, logical, complex, NA, NaN, factor, closure ...
mbc <- 11
object.size(mbc)
typeof(mbc)
typeof(3)
typeof(3.14)
is(mbc) # 데이터 유형
mbc2 <- as.integer(mbc) # 형 변환
typeof(mbc2)
is(mbc2)
mbc3 <- 11L # 정수화(숫자+L)
is(mbc3)

ss <- '홍길동'
is(ss)
print(ss)
cat(ss)
cat(ss[0])
cat(ss[1]) # 인덱스 1부터 시작작

b <- TRUE # T로 줄여써도 됨
is(b)
is.logical(b)

z <- 5.3 - 3i # 실수와 허수 
is(z)

aa <- NA # 결측값(값이 입력되지 않은 상태)
is(aa)
is.na(aa)
is.na(z)
typeof(aa)

Inf # 무한대
bb <- NaN
is(bb)
0 / 0
0 * Inf
Inf + -Inf
Inf - Inf

NULL # 값이 없음

sum(2, 3, NULL) # NULL은 값으로 인식하지 않음. 무시 됨
sum(2, 3, NA) # NA는 값으로 인식함. NaN
sum(2, 3, NA, na.rm = T) # 5
sum(2, 3, NaN) # NaN 값으로 인식함.

sbs <- c('second', 'first', 'third', 'second')
sbs
cat('sbs은 ', sbs)
print('sbs는 ', sbs) # 에러 : 인수는 한 개만. 주로 함수 내에서 사용
typeof(sbs)
sbs2 <- as.factor(sbs)
sbs2
levels(sbs2)
is(sbs2)
typeof(sbs2)

summary(sbs2) # first 1 second 2 third 1 레벨 빈도수를 나타내줌
plot(sbs2)

f <- function(){
  return('good')
}
f
f()
typeof(f)
cat(mode(f), class(f), typeof(f)) # function function closure

# 자료형, 자료구조 확인 함수
# mode :  데이터 성격격
# class : 데이터 자료구조 성격
# typeof : 자료형

a <- 5
cat(mode(a), class(a), typeof(a)) # numeric numeric double

a <- '5'
cat(mode(a), class(a), typeof(a)) # character character character

ls() # 현재 사용 중인 변수 객체 목록 확인인
ls.str()

a # "5"
rm(a) # 변수 삭제
a # Error: object 'a' not found
rm(list=ls()) # 현재 사용 중인 변수 모두 삭제
ls() # 아무것도 남아있지 않음
a <- 1
rm(a)
a
gc() # 사용이 종료된 객체가 점유한 메모리를 해제함

getwd() # 현재 작업 경로(디렉토리) 확인 "C:/work/rsou/pro1"


# package(데이타 + 함수 + 알고리즘 꾸러미, R 지원 객체, 메소드, 함수들을 모아놓은 컬렉션) 사용
available.packages()
dim(available.packages()) # 18286개의 package 지원

# plyr 라이브러리 사용
install.packages("plyr")
library('plyr')

help('plyr')

base::cat('abc')

remove.packages('plyr')

# 기본 database 제공
data()
Nile # 나일강 범람 시계열 데이터
head(Nile, 5)
tail(Nile, 5)

hist(Nile, freq = F)
lines(density(Nile))

# 도움말
help(mean)
x <- c(0:10, 50)
xm <- mean(x)
c(xm, mean(x, trim = 0.10))

? mean
