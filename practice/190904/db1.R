library(ggplot2)

data("iris")

#DB서버 접속
drv<-JDBC("oracle.jdbc.driver.OracleDriver","C:/seol/ojdbc6.jar")
conn<-dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe","jdbctest","jdbctest")
conn
dbListTables(conn)

#1. 테이블 생성
dbWriteTable(conn, "IRIS",data.frame(SLENGTH=iris$Sepal.Length,SWIDTH=iris$Sepal.Width,
                                     PLENGTH=iris$Petal.Length, PWIDTH=iris$Petal.Width,SPECIES=iris$Species))
#2. 테이블 출력
data<-dbReadTable(conn,"IRIS")

#3. ggplot()으로 시각화 구현

#db1
ggplot(data,aes(x=SLENGTH,y=SWIDTH))+geom_point(aes(group=SPECIES,colour=SPECIES))
#db2
ggplot(data,aes(x=PLENGTH,y=PWIDTH))+geom_point(aes(group=SPECIES,colour=SPECIES))

map7 <- NULL
map7<-leaflet(korpopmap3) %>% setView(lat=37.52711, lng=126.987517, zoom=12) %>% addTiles() 
