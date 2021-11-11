# 산술, 관계, 논리 연산
no <- 7
no >= 2+2*2 | no < 5%%2 # True
no >= 5 & no <= 10 # True
no != 5 # True

# if
x <- 10; y <- 5
if(x+y >= 10){
  cat("결과는 ", x+y)
  cat("\n참일 때 수행")
} else{
  print("거짓일 때 처리리")
} # 결과는  15
  # 참일 때 수행

ifelse(x >= 5, 'good', 'bad') # "good"

# switch
?switch
switch('age', id='hong', age=33, name='홍수민') # 33 // 'age' : 비교구문 / id, age, name : 실행구문

a <- 1
switch(a, mean(1:10), sd(a:10)) # 5.5

# for 
i <- 1:10
for(n in i){
  print(n)
} # [1] 1
  # [1] 2
  # [1] 3
  # [1] 4
  # [1] 5
  # [1] 6
  # [1] 7
  # [1] 8
  # [1] 9
  # [1] 10

for(n in i){
  if(n %% 2 == 0){
    next # 파이썬의 pass
  } else{
    print(n)
  }
} # [1] 1
  # [1] 3
  # [1] 5
  # [1] 7
  # [1] 9

# while
i <- 0
while(i < 10){
  i = i + 1
  print(i)
} # [1] 1
  # [1] 2
  # [1] 3
  # [1] 4
  # [1] 5
  # [1] 6
  # [1] 7
  # [1] 8
  # [1] 9
  # [1] 10
cat('while 수행 후 i : ', i) # while 수행 후 i :  10

i <- 0
while(T){
  i = i + 1
  print(i)
  if(i == 3) break
} # [1] 1
  # [1] 2
  # [1] 3
cat('while 수행 후 : ', i) # while 수행 후 :  3

# repeat
cnt <- 1
repeat{
  print(cnt)
  cnt = cnt + 2
  if(cnt > 10) break
} # [1] 1
  # [1] 3
  # [1] 5
  # [1] 7
  # [1] 9
