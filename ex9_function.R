# 내장함수
seq(0, 5, by=1.5) # 0.0 1.5 3.0 4.5

# set.seed(123) 난수 값을 고정하고 싶으면 set.seed로 고정시키면 됨
aa <- rnorm(1000, mean=0, sd=1) # rnorm : 정규분포를 따른 난수 발생시키는 함수 / sd : 표준편차
print(aa)
hist(aa) # 히스토그램 그래프
print(mean(aa)) # 0.01099074 // 데이터가 늘어나면 더 0에 가까워짐

bb <- runif(1000, min=0, max=100) # runif : 균등분포를 따른 난수 발생시키는 함수
print(bb)
hist(bb)

sample(0:100, 10) # 0에서 100 사이의 10개의 숫자 랜덤으로 뽑음

vec <- 1:10
min(vec) # 1
mean(vec) # 5.5 
median(vec) # 표준편차 5.5
quantile(vec) # 사분수    0%   25%   50%   75%  100% 
                      # 1.00  3.25  5.50  7.75 10.00
table(vec) # 빈도수  1  2  3  4  5  6  7  8  9 10 
                   # 1  1  1  1  1  1  1  1  1  1 

# 사용자 정의 함수
func1 <- function(){
  print('사용자 정의 함수')
}
func1() # "사용자 정의 함수"

func2 <- function(a){
  cat('arg : ', a) # print로는 출력 안 됨 (문자열 + 변수)
  print('\n매개변수 사용')
  return(a+10)
}
func2(5) # arg :  5[1] "\n매개변수 사용"
         # [1] 15

# 윤년 체크 : 년도가 4의 배수이고 100의 배수가 아니거나 400의 배수
yun_check <- function(y){
  if(y %% 4 == 0 & y %% 100 != 0 | y %% 400 == 0){
    paste(y, '년은 윤년입니다.')
  } else{
    paste(y, '년은 평년입니다.')
  }
}
yun_check(2020) # "2020 년은 윤년입니다."
yun_check(2022) # "2022 년은 평년입니다."
