# 관계형 데이터베이스 연동
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")
install.packages("RSQLite") # 개인용 데이터베이스

library(rJava)
library(DBI)
library(RJDBC)
library(RSQLite)

# SQLite와 연결
conn <- dbConnect(RSQLite::SQLite(), ":memory:") # memory : 램에서만 연습한다는 뜻
conn
mtcars # 내장된 dataset
head(mtcars, 2)
dbWriteTable(conn, "mytab", mtcars) # 테이블 생성
dbListTables(conn) # "mytab" // 테이블의 목록 확인
dbListFields(conn, "mytab") # 테이블의 칼람(Field) 목록 확인 
query <- "select*from mytab where mpg > 30"
goodAll <- dbGetQuery(conn, query)
goodAll #    mpg cyl disp  hp drat    wt  qsec vs am gear carb
        # 1 32.4   4 78.7  66 4.08 2.200 19.47  1  1    4    1
        # 2 30.4   4 75.7  52 4.93 1.615 18.52  1  1    4    2
        # 3 33.9   4 71.1  65 4.22 1.835 19.90  1  1    4    1
        # 4 30.4   4 95.1 113 3.77 1.513 16.90  1  1    5    2
dbDisconnect(conn) # DB 연결 해제 

# 원격 DB : MariaDB
drv <- JDBC(driverClass = "org.mariadb.jdbc.Driver", classPath="c:/work/mariadb-java-client-2.6.2.jar")
conn <- dbConnect(drv=drv, "jdbc:mysql://127.0.0.1:3306/test", "root", "123")
dbListTables(conn) #  [1] "abc"                        "auth_group"                 "auth_group_permissions"     "auth_permission"           
                   # [5] "auth_user"                  "auth_user_groups"           "auth_user_user_permissions" "board"                     
                   # [9] "buser"                      "django_admin_log"           "django_content_type"        "django_migrations"         
                   # [13] "django_session"             "gogek"                      "jikwon"                     "sangdata" 
sql <- "select*from sangdata"
aaa <- dbGetQuery(conn, sql)
aaa #    code            sang  su    dan
    # 1     1            부츠   5  47000
    # 2     2      벙어리장갑   2  12000
    # 3     3 최고급 가죽장갑  10 500000
    # 4     4        가죽점퍼   5 650000
    # 5     5     할로윈 사탕 100    200
    # 6     6            비니   8  14000
    # 7     7     무지개 우산   5  15000
    # 8     8          머그컵  50  10000f
    # 9     9       크로스 백  12  24000
    # 10   10       폰 케이스   2  35000
    # 11   11   커스텀 키보드   5 120000
class(aaa) # "data.frame"
aaa$sang #  [1] "부츠"            "벙어리장갑"      "최고급 가죽장갑" "가죽점퍼"        "할로윈 사탕"     "비니"           
         #  [7] "무지개 우산"     "머그컵"          "크로스 백"       "폰 케이스"       "커스텀 키보드" 
mean(aaa$su) # 18.54545
plot(aaa$dan)
table(aaa$sang) #        가죽점퍼          머그컵     무지개 우산      벙어리장갑            부츠            비니 최고급 가죽장갑 
                #               1               1               1               1               1               1               1 
                #   커스텀 키보드       크로스 백       폰 케이스     할로윈 사탕 
                #               1               1               1               1 
aaa2 <- dbGetQuery(conn, "select code, sang, su as suryang from sangdata where sang like '%가죽%'")
aaa2 #   code            sang suryang
     # 1    3 최고급 가죽장갑      10
     # 2    4        가죽점퍼      5

# 레코드 추가
sql <- "insert into sangdata values(12, '벽걸이 시계', 3, 48000)"
dbSendUpdate(conn, sql)

df <- data.frame(code=13, sang='안경 케이스', su=7, dan=10000)
df
dbSendUpdate(conn, "insert into sangdata values(?, ?, ?, ?)", df$code, df$sang, df$su, df$dan)
dbGetQuery(conn, "select*from sangdata") #    code            sang  su    dan
                                         # 1     1            부츠   5  47000
                                         # 2     2      벙어리장갑   2  12000
                                         # 3     3 최고급 가죽장갑  10 500000
                                         # 4     4        가죽점퍼   5 650000
                                         # 5     5     할로윈 사탕 100    200
                                         # 6     6            비니   8  14000
                                         # 7     7     무지개 우산   5  15000
                                         # 8     8          머그컵  50  10000
                                         # 9     9       크로스 백  12  24000
                                         # 10   10       폰 케이스   2  35000
                                         # 11   11   커스텀 키보드   5 120000
                                         # 12   12     벽걸이 시계   3  48000
                                         # 13   13     안경 케이스   7  10000

# 레코드 수정
sql <- "update sangdata set sang=? where code=?"
dbSendUpdate(conn, sql, "블루라이트 안경 케이스", 13)
dbGetQuery(conn, "select*from sangdata where code=13") #   code                   sang su   dan
                                                       # 1   13 블루라이트 안경 케이스  7 10000

# 레코드 삭제
dbSendUpdate(conn, "delete from sangdata where code=?", 13)
dbGetQuery(conn, "select*from sangdata") #    code            sang  su    dan
                                         # 1     1            부츠   5  47000
                                         # 2     2      벙어리장갑   2  12000
                                         # 3     3 최고급 가죽장갑  10 500000
                                         # 4     4        가죽점퍼   5 650000
                                         # 5     5     할로윈 사탕 100    200
                                         # 6     6            비니   8  14000
                                         # 7     7     무지개 우산   5  15000
                                         # 8     8          머그컵  50  10000
                                         # 9     9       크로스 백  12  24000
                                         # 10   10       폰 케이스   2  35000
                                         # 11   11   커스텀 키보드   5 120000
                                         # 12   12     벽걸이 시계   3  48000
