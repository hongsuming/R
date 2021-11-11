# List : 서로 다른 타입의 데이터를 기억할 수 있다.
# - 성격이 다른 데이터(벡터, 행렬, 데이터프레임 등 모든 데이터)의 기억이 가능,
# c의 구조체, java의 레코드형 기억장소와 유사
# - 생성 함수 : list()
# - 처리 함수 : unlist(), lapply(), sapply()

li <- list("1", "tom", 95, "2", "james", 85)
li # [[1]] (키, 밸류로 이루어짐)
  # [1] "1"
  # 
  # [[2]]
  # [1] "tom"
  # 
  # [[3]]
  # [1] 95
  # 
  # [[4]]
  # [1] "2"
  # 
  # [[5]]
  # [1] "james"
  # 
  # [[6]]
  # [1] 85
class(li) # "list"
unli <- unlist(li)
unli # "1"     "tom"   "95"    "2"     "james" "85" 

num <- list(c(1:5), c(6:10), c("a", "b", "c"))
num # [[1]]
    # [1] 1 2 3 4 5
    # 
    # [[2]]
    # [1]  6  7  8  9 10
    # 
    # [[3]]
    # [1] "a" "b" "c"
num[1] # [[1]]
      # [1] 1 2 3 4 5
num[[1]] # 1 2 3 4 5
class(num[1]) # "list"
class(num[[1]]) # "integer"
num[[1]][2] # 2

member <- list(name="hong", age=24)
member # $name
      # [1] "hong"
      # 
      # $age
      # [1] 24
member$name # "hong"
