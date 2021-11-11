# Data Frames : 구조화된 데이터 오브젝트다. 
# 데이터베이스의 테이블 구조와 유사, 칼럼 단위로 type이 달라도 됨
# - 가장 많이 사용되는 객체 타입
# - 데이터프레임과 행렬은 모두 2차원 데이터이지만 다음과 같은 점이 다르다.
# 데이터프레임의 각 열은 서로 다른 자료형이 될 수 있다.
# 데이터프레임은 열 이름, 행 이름을 가질 수 있다.
# - 생성 함수 : data.frame(열이름1=요소, 열이름2=요소, …)
# - 처리 함수 : apply(), str(), ncol(), nrow(), summary()

# vector로 데이터프레임 작성
no <- c(1, 2, 3)
name <- c('hong', 'lee', 'kim')
pay <- c(250, 300, 350)
df <- data.frame(bunho=no, irum=name, imkum=pay)
df #   bunho irum imkum
  # 1     1 hong   250
  # 2     2  lee   300
  # 3     3  kim   350
ls(df) # "bunho" "imkum" "irum" 
is(df) # "data.frame" "list"       "oldClass"   "vector" 
mode(df) # "list"
df2 <- data.frame(no, name, pay)
df2 #   no name pay
    # 1  1 hong 250
    # 2  2  lee 300
    # 3  3  kim 350

df <- data.frame(irum=c('james', 'oscar', 'tom'), nai=c(27, 25, 35))
df #    irum nai
  # 1 james  27
  # 2 oscar  25
  # 3   tom  35
df <- data.frame(irum=c('james', 'oscar', 'tom'), nai=c(27, 25, 35), row.names=c('one', 'two', 'three'))
df #        irum nai
  # one   james  27
  # two   oscar  25
  # three   tom  35
head(df, 2) #      irum nai
            # one james  27
            # two oscar  25
nrow(df) # 3
ncol(df) # 2
summary(df) #      irum                nai     ==> 요약 통계
            # Length:3           Min.   :25  
            # Class :character   1st Qu.:26  
            # Mode  :character   Median :27  
            #                    Mean   :29  
            #                    3rd Qu.:31  
            #                    Max.   :35 
rownames(df) # "one"   "two"   "three"
colnames(df) # "irum" "nai"

head(iris, 2) # 기본적으로 제공이 됨 (iris)


# matrix로 데이터프레임 작성
m <- matrix(c(1, 'hong', 150, 2, 'lee', 350, 3, 'kim', 550), 3, by=T) # 3행이고 행부터 채우기
m #      [,1] [,2]   [,3] 
  # [1,] "1"  "hong" "150"
  # [2,] "2"  "lee"  "350"
  # [3,] "3"  "kim"  "550"
mdf <- data.frame(m)
mdf #   X1   X2  X3
    # 1  1 hong 150
    # 2  2  lee 350
    # 3  3  kim 550

m <- matrix(1:6, nrow=3)
m #      [,1] [,2]
  # [1,]    1    4
  # [2,]    2    5
  # [3,]    3    6
mdf <- data.frame(m)
mdf #   X1 X2
    # 1  1  4
    # 2  2  5
    # 3  3  6
colnames(mdf) <- c('c1', 'c2')
mdf #   c1 c2
    # 1  1  4
    # 2  2  5
    # 3  3  6
typeof(mdf) # "list"
mdf$c1 # 1 2 3
mdf['c1'] #   c1
          # 1  1
          # 2  2
          # 3  3
mdf[,2] # 4 5 6 (2번째 열)
mdf[1, 2] # 4 (1행 2열)
mdf[1:2, 1:2] #   c1 c2
              # 1  1  4
              # 2  2  5

# 조건 지정
mdf[mdf$c1 == 2,] #   c1 c2
                  # 2  2  5
subset(mdf, c1 == 2) #   c1 c2
                     # 2  2  5
mdf[mdf$c1 == 2 & mdf$c2 == 5,] #   c1 c2
                                # 2  2  5
subset(mdf, c1 == 2 & c2 == 5) #   c1 c2
                               # 2  2  5
mdf[mdf$c1 == 2, c(1, 2)] #   c1 c2
                          # 2  2  5
subset(mdf, c1 == 2, select = c(1, 2)) #   c1 c2
                                       # 2  2  5
mdf$c2 <- ifelse(mdf$c2 == 4, NA, mdf$c2)  # ifelse(조건, 참일 때, 거짓일 때)
mdf #   c1 c2
    # 1  1 NA
    # 2  2  5
    # 3  3  6
summary(mdf) #        c1            c2      
            # Min.   :1.0   Min.   :5.00  
            # 1st Qu.:1.5   1st Qu.:5.25  
            # Median :2.0   Median :5.50  
            # Mean   :2.0   Mean   :5.50  
            # 3rd Qu.:2.5   3rd Qu.:5.75  
            # Max.   :3.0   Max.   :6.00  
            #               NA's   :1   
mean(mdf$c1) # 2
mean(mdf$c2) # NA
mean(mdf$c2, na.rm=T) # 5.5 (NA를 제외하고 평균 구하기)

# 행 또는 열 추가
mdf #   c1 c2
    # 1  1 NA
    # 2  2  5
    # 3  3  6
mdfr <- rbind(mdf, c(10, 11))
mdfr #   c1 c2
      # 1  1 NA
      # 2  2  5
      # 3  3  6
      # 4 10 11
mdfc <- cbind(mdf, c3=c('a', 'b', 'c'), c4=c('a1', 'b2', 'c3'))
mdfc #   c1 c2 c3 c4
    # 1  1 NA  a a1
    # 2  2  5  b b2
    # 3  3  6  c c3

# 열 삭제
mdfc[, 'c1'] <- NULL
mdfc #   c2 c3 c4
    # 1 NA  a a1
    # 2  5  b b2
    # 3  6  c c3

# 행 삭제
mdfr
mdfr <- mdfr[-1, ]
mdfr #   c1 c2
     # 2  2  5
     # 3  3  6
     # 4 10 11

# txt 파일을 이용하여 data.frame 작성
txtdf <- read.table("https://raw.githubusercontent.com/pykwon/Test-datas-for-R/master/emp.txt") # 외부 파일 url로 읽기
txtdf #     V1   V2   V3
      # 1 사번 이름 급여
      # 2  101 hong  350
      # 3  201  lee  250
      # 4  301  kim  300
csvdf <- read.csv("emp2.csv", header=F, col.names=c('번호', '이름', '월급급')) # 파일 같은 경로에 저장해서 읽기기
csvdf #   번호   이름 월급급
      # 1  101 홍길동    150
      # 2  102 이순신    450
      # 3  103 강감찬    500
      # 4  104 유관순    350
      # 5  105 김유신    400

# data.frame으로 파일 저장
df <- data.frame(eng=c(90, 80, 70), mat=c(50, 60, 70), class=c(1, 2, 3))
df #   eng mat class
   # 1  90  50     1
   # 2  80  60     2
   # 3  70  70     3
getwd()
save(df, file='C:/work/rsou/pro1/df1.rda')
rm(df)
df
load('C:/work/rsou/pro1/df1.rda')
df

install.packages("data.table")
library(data.table)
dt <- as.data.table(csvdf)
dt #    번호   이름 월급급
   # 1:  101 홍길동    150
   # 2:  102 이순신    450
   # 3:  103 강감찬    500
   # 4:  104 유관순    350
   # 5:  105 김유신    400

dt2 <- data.table(bun=c(1, 2), irum=c('tom', 'john'))
dt2 #    bun irum
    # 1:   1  tom
    # 2:   2 john

# dataframe 결합
height <- data.frame(id=c(1, 2, 3), h=c(180, 175, 178))
weight <- data.frame(id=c(1, 2, 3), w=c(80, 75, 88))
height #   id   h
       # 1  1 180
       # 2  2 175
       # 3  3 178
weight #   id  w
       # 1  1 80
       # 2  2 75
       # 3  3 88

merge(height, weight) #   id   h  w
                      # 1  1 180 80
                      # 2  2 175 75
                      # 3  3 178 88
merge(height, weigth, by.x='id', by.y='id')
merge(height, weight, all=TRUE) #   id   h  w
                                # 1  1 180 80
                                # 2  2 175 75
                                # 3  3 178 88

# 참고 : 키보드 자료 입력
n <- scan()
sum(1:n) # 5050

# edit() 함수 사용
df1 <- data.frame()
df1
df1 <- edit(df1)
df1 #   var1 var2 var3 var4 var5 var6
    # 1   10   20   30   40   50   60
