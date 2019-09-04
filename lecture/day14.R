install.packages("DBI")
install.packages("RJDBC")
library(DBI)
library(RJDBC)

#DB서버 접속
drv<-JDBC("oracle.jdbc.driver.OracleDriver","C:/seol/ojdbc6.jar")
conn<-dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe","jdbctest","jdbctest")
conn #<JDBCConnection>
dbListTables(conn)

result<- dbReadTable(conn, "VISITOR")  # 데이터프레임으로 저장
class(result)

result2<- dbGetQuery(conn,"SELECT * FROM VISITOR")
class(result2)

rs<- dbSendQuery(conn, "SELECT * FROM VISITOR") #jdbc result 셋 으로 반환시켜줘서 이것만 실행하면 결과값이 안나옴.
class(rs)
ret1<-dbFetch(rs,1)   # 첫째 행 출력
ret1
ret2<-dbFetch(rs,2)   # 둘째 행 출력
ret2

#테이블에 데이터 저장하기

#무조건 새로만드는 테이블

#방법 1
dbWriteTable(conn, "book",data.frame(bookname=c("자바의 정석","하둡 완벽 입문","이것이 리눅스다"),
                                     price=c(30000,25000,32000)))
#방법2
dbWriteTable(conn,"cars",head(cars,3))

#테이블 데이터 삽입
dbSendUpdate(conn,"INSERT INTO VISITOR VALUES('R언어',sysdate,'R 언어로 데이터를 입력해요'
             ,visitor_seq.nextval)")

dbSendUpdate(conn,"INSERT INTO VISITOR VALUES('하둡',sysdate,'대용량 데이터 분산저장 & 처리기술'
             ,visitor_seq.nextval)")

#데이터 수정
dbSendUpdate(conn, "INSERT INTO cars(speed,dist) VALUES(1,1)")
dbSendUpdate(conn, "INSERT INTO cars(speed,dist) VALUES(2,2)")
dbReadTable(conn,"CARS")
dbSendUpdate(conn, "UPDATE CARS SET DIST = DIST *100 WHERE SPEED =1")
dbReadTable(conn,"CARS")
dbSendUpdate(conn,"UPDATE CARS SET DIST =DIST*3 WHERE SPEED =1")
dbReadTable(conn,"CARS")

#테이블 삭제
dbRemoveTable(conn, "CARS")

## DB연동 예제
# 예제1
df<-read.table("product_click.log", stringsAsFactors = F)
names(df)<-c("click_time","pid")
df$click_time = as.character(df$click_time)
dbWriteTable(conn, "productlog", df)
result4 = dbReadTable(conn,"PRODUCTLOG")
result4

#예제2
dbWriteTable(conn,"mtcars",mtcars)
rs<- dbSendQuery(conn,"SELECT * FROM mtcars WHERE cyl=4")
rs
dbFetch(rs)
dbClearResult(rs)

rs<-dbSendQuery(conn, "SELECT*FROM mtcars")
ret1<-dbFetch(rs,10)
ret2<-dbFetch(rs)
dbClearResult(rs)

nrow(ret1)
nrow(ret2)

#JAVA 와 R 연동
install.packages("Rserve")
