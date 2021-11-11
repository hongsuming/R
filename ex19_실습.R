# MariaDB의 jikwon 테이블을 사용해서 근무년수에 대한 연봉을 이용하여 회귀분석 모델 작성
library(rJava)
library(DBI)
library(RJDBC)

drive <- JDBC(driverClass = "org.mariadb.jdbc.Driver", classPath = "c:/work/mariadb-java-client-2.6.2.jar")
conn <- dbConnect(drive, "jdbc:mysql://127.0.0.1:3306/test", "root", "123")
conn

query <- "select substr(jikwon_ibsail, 1, 4) from jikwon"
jik_ibsail <- dbGetQuery(conn, query)
jik_ibsail # 1                         2008
           # 2                         2010
           # 3                         2010
           # 4                         2014
           # 5                         2017
           # 6                         2019
           # 7                         2009
           # 8                         2011
           # 9                         2013
           # 10                        2016
           # 11                        2016
           # 12                        2011
           # 13                        2013
           # 14                        2016
           # 15                        2016
           # 16                        2016
           # 17                        2006
           # 18                        2011
           # 19                        2014
           # 20                        2019
           # 21                        2019
           # 22                        2013
           # 23                        2015
           # 24                        2014
           # 25                        2016
           # 26                        2016
           # 27                        2012
           # 28                        2013
           # 29                        2016
           # 30                        2015
typeof(jik_ibsail) # "list"
jik_ibsail <- as.numeric(unlist(jik_ibsail))
typeof(jik_ibsail) # "double"

install.packages("lubridate")
library(lubridate)
now_year <- year(Sys.time()) # 시스템이 가진 년도도
now_year # 2021
jik_workyear <- now_year - jik_ibsail
cat('근무 년수 : ', jik_workyear) # 근무 년수 :  13 11 11 7 4 2 12 10 8 5 5 10 8 5 5 5 15 10 7 2 2 8 6 7 5 5 9 8 5 6

query <- "select jikwon_pay from jikwon"
jik_pay <- dbGetQuery(conn, query)
jik_pay #    jikwon_pay
        # 1        9900
        # 2        8800
        # 3        7900
        # 4        4500
        # 5        3000
        # 6        2950
        # 7        8600
        # 8        7800
        # 9        5000
        # 10       3700
        # 11       3900
        # 12       7200
        # 13       4900
        # 14       3400
        # 15       4000
        # 16       3000
        # 17       8000
        # 18       7800
        # 19       5500
        # 20       2900
        # 21       2950
        # 22       5850
        # 23       6600
        # 24       4500
        # 25       3800
        # 26       3500
        # 27       5900
        # 28       5200
        # 29       4100
        # 30       4000
typeof(jik_pay) # "list"
jik_pay <- as.numeric(unlist(jik_pay))
typeof(jik_pay) # "double"

jik_data <- data.frame(jik_workyear, jik_pay)
head(jik_data, 5) #   jik_workyear jik_pay
                  # 1           13    9900
                  # 2           11    8800
                  # 3           11    7900
                  # 4            7    4500
                  # 5            4    3000
cor(jik_data$jik_workyear, jik_data$jik_pay) # 0.9196725 // 상관관계가 있음
model <- lm(formula = jik_pay ~ jik_workyear, data=jik_data)
model # Call:
      # lm(formula = jik_pay ~ jik_workyear, data = jik_data)
      # 
      # Coefficients:
      #   (Intercept)  jik_workyear  
      #        1105.3         583.3
summary(model) # Call:
               # lm(formula = jik_pay ~ jik_workyear, data = jik_data)
               # 
               # Residuals:
               #   Min       1Q   Median       3Q      Max 
               # -1854.66  -596.70   -71.76   594.88  1994.95 
               # 
               # Coefficients:
               #   Estimate Std. Error t value Pr(>|t|)    
               # (Intercept)   1105.31     371.01   2.979  0.00591 ** 
               #   jik_workyear   583.29      47.07  12.393 6.94e-13 ***
               #   ---
               #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
               # 
               # Residual standard error: 827.1 on 28 degrees of freedom
               # Multiple R-squared:  0.8458,	Adjusted R-squared:  0.8403 
               # F-statistic: 153.6 on 1 and 28 DF,  p-value: 6.943e-13 // 0.05보다 작으므로 의미있는 모델 (유의한 모델)
cat('R-squared : ', summary(model)$r.squared) # R-squared :  0.8457975
cat('model p-value : ', anova(model)$'Pr(>F)'[1]) # model p-value :  6.942657e-13

plot(jik_data$jik_workyear, jik_data$jik_pay, xlim=c(0, 20), ylim=c(1000, 15000))
abline(model, col='blue', lwd=2)

jik_pay_pred_func <- function(){
  cat('근무년수 입력 : ')
  work_year = scan()
  predPay = predict(model, data.frame(jik_workyear = work_year))
  cat('근무년수 : ', work_year, '\n')
  cat('예상년봉 : ', predPay, '\n')
  
  plot(jik_data$jik_workyear, jik_data$jik_pay, xlim=c(0, 20), ylim=c(1000, 15000))
  abline(model, col='blue', lwd=2)
  points(work_year, round(predPay), col='red', lwd=5, pch=23)
}
jik_pay_pred_func() # 근무년수 :  4 
                    # 예상년봉 :  3438.472 
