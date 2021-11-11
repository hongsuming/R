# 자료 구조 :  Vector(1차원), Matrix(2차원), Array(1, 2, 3, 다차원), List(키, 밸류), DataFrame
# Vector : 1차원 배열 형태의 자료구조 (동일한 형태의 자료만 저장됨). 가장 작은 데이터 타입
# - 벡터는 같은 자료형의 데이터를 정해진 갯수만큼 모아놓은 것이다. 
# - 생성 함수 : c(), seq(), rep()
# - 처리 함수 : setdiff(), intersect(), union() ...

year <- 2021
is(year) # "numeric" "vector" 
typeof(year) # "double"
is.vector(year) # TRUE
typeof(as.integer(year)) # "integer"

?seq
seq(from=1, to=5) # 1 2 3 4 5
seq(1, 5) # 1 2 3 4 5
seq(1, 10, 2) # 1 3 5 7 9
seq(1, 10, length.out=4) # 1  4  7 10

rep(1:3, 3) # 1 2 3 1 2 3 1 2 3
rep(1:3, each=3) # 1 1 1 2 2 2 3 3 3

c(1, 2, 3, 5)

vec <- c(10, 20, 30, -10, -20)
vec # 10  20  30 -10 -20
c(1:20) # 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

x <- c(1, 3, 5)
y <- c(1:3, 1:3)
x; y # 1 3 5
     # 1 2 3 1 2 3

c(1, 3, 5.5, 6, F, T, 'abc') # "1"     "3"     "5.5"   "6"     "FALSE" "TRUE"  "abc" (동일한 형태의 데이터만 저장. 정수 < 실수 < 문자)

age <- c(10, 20, 30)
age
names(age) <- c('오공', '피오라', '말파이트') # 벡터에 칼람명 부여
age
age <- c(age, 40)
age

age[1] # 슬라이싱
age[1:3]

age <- NULL
age

# 벡터 연산
a <- 1:3
a+5 # 6 7 8

b <- 4:6
b
a+b
a-b
a*b
a/b

a[4] <- 2
union(a, b) # 1 2 3 4 5 6 (합집합 : 중복 x)
c(a, b) # 1 2 3 2 4 5 6 (합집합 : 중복 o)
b[4] <- 2
b
setdiff(a, b) # 1 3 (차집합)
intersect(a, b) # 2 (교집합)
