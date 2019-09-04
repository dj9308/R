# R과 오라클 연동하기

### 패키지

install.packages("DBI")
install.packages("RJDBC")
library(DBI)
library(RJDBC)

### DB서버 접속

drv<-JDBC("oracle.jdbc.driver.OracleDriver","C:/seol/ojdbc6.jar")
conn<-dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe","jdbctest","jdbctest")

### 테이블 생성

dbWriteTable(conn, "IRIS",data.frame(SLENGTH=iris$Sepal.Length,SWIDTH=iris$Sepal.Width,
                                     PLENGTH=iris$Petal.Length, PWIDTH=iris$Petal.Width,SPECIES=iris$Species))

dbWriteTable(conn,"cars",head(cars,3))

### 테이블 출력

data<-dbReadTable(conn,"IRIS")

### 데이터 수정

dbSendUpdate(conn, "INSERT INTO cars(speed,dist) VALUES(1,1)")

### 테이블 삭제

dbRemoveTable(conn, "CARS")

# R 과 JAVA 연동하기

## 설정 방법

- spring 프로젝트를 만들고 pom.xml 에

  <dependency>
  		<groupId>com.github.lucarosellini.rJava</groupId>
  		<artifactId>JRIEngine</artifactId>
  		<version>0.9-7</version>
  		</dependency>
  		<dependency>
  		<groupId>net.rforge</groupId>
  		<artifactId>Rserve</artifactId>
  		<version>0.6-8.1</version>
  		</dependency>

  을 추가. java 1.8, spirng 5.0.2 버전 확인.

- C:\Program Files\R\R-3.6.1\library\Rserve\libs\x64의 파일들을
  C:\Program Files\R\R-3.6.1\bin\x64로 옮기고
  cmd 에 위 주소로 가서 Rserve --RS-encoding utf8 입력하면 실행.

## 주요 함수

- RConnection : R에 접속하여 핵심적인 역할을 수행하는 클래스. R에 접속, 인증, 세션 종료, 파일 생성, 파일 읽기,
  자료 전송, 자료 조회 등을 처리.
- eval() : R에 직접적인 명령을 내리고 REXP 타입으로 데이터를 반환 받는다.
- assign() : R의 변수에 REXP 또는 String 형태로 데이터를 지정하여 설정한다.

### REXP 타입

- asBytes : Byte 일차원 배열형으로 반환하여 준다.
- asDouble : double 형 반환
- asDoubleMatrix : double 이차원 배열 형.
- asDoubles : double 일차원 배열형
- asList : RList 형으로 반환.
- asString : String형
- asStrings : String 일차원 배열형
- length : 데이터 갯수

``` java
RConnection rc = new RConnection();
      double[] dataX = {1,2,3,4,5,6,7,8,9,10};
      rc.assign("x", dataX);
      rc.eval("y <- x+10");
int[] resultX = rc.eval("y").asIntegers();
```

