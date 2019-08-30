#break 와 next
#next는 java에서 continue와 비슷하다.
sum <-0
for(i in 5:15){
  if(i%%2==0) {
    next;
  }
  #if(i%%10==0){
  #  break;
  #}
  sum <- sum + i
  print(paste(i,":",sum))
}



# 함수 정의와 활용

func1 <- function() {
  xx <- 10
  yy <- 20
  return(xx*yy)
}

func1()
result <- func1()
result
xx

func2 <- function(x,y) {
  xx <- x
  yy <- y
  return(sum(xx, yy))
}

func2()
func2(5,6)

func3 <- function(x,y) {
  x3 <- x+1
  y3 <- y+1
  x4 <- func2(x3, y3)
  return(x4)
}

func3(9, 19)  # 30

func4 <- function(x=100, y=200, z) {
  return(x+y+z)
}
func4()
func4(10,20,30)
func4(x=1,y=2,z=3)
func4(y=11,z=22,x=33)
func4(z=1000)  

# 쉬트에 있는 함수 코드
f1 <- function() print("TEST")

f2 <- function(num) {print("TEST"); print(num) }

f3<- function (p="R") print(p)

f4<- function (p1="ㅋㅋㅋ",p2) for(i in 1:p2) print(p1)

f5<- function(...) { print("TEST"); data <- c(...); print(length(data))}

f6<- function(...) {
  print("수행시작")
  data <- c(...)
  for(item in data) {
    print(item)
  }
  return(length(data))
}

f7<- function(...) {
  data <- c(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
}

f8<- function(...) {
  data <- list(...)
  sum <- 0;
  for(item in data) {
    if(is.numeric(item))
      sum <- sum + item
    else
      print(item)
  }
  return(sum)
}

fx <- 70
func5 <- function() {
  x <- 10
  y <- 20
  x <<- 40  # 외부 변수 x 를 수정
  return (x+y)
}
func5()  
x  

#전역변수/지역변수
a<-3;b<-7;c<-11 
ft<-function(a){
  b<-a+10     
  c<<-a+10    
  d<-a
  print(a);print(b);print(c);print(d)
}
ft(100)
print(a);print(b);print(c);print(d) 

#invisible()함수 

ft.1 <- function(x) return()
ft.2 <- function(x) return(x+10)
ft.3 <- function(x) invisible(x+10)  
#리턴 결과를 변수에 담거나 또다른 식에 사용하는 것에 쓰임

ft.1(100)
ft.2(100)
ft.3(100)

r1 <- ft.1(1000);r1
r2 <- ft.2(1000);r2
r3 <- ft.3(1000);r3


testParamType <- function(x){
  if(is.vector(x)) print("벡터를 전달했군요!")
  if(is.data.frame(x)) print("데이터프레임을 전달했군요!")
  if(is.list(x)) print("리스트를 전달했군요!")
  if(is.matrix(x)) print("매트릭스를 전달했군요!")
  if(is.array(x)) print("배열을 전달했군요!")
  if(is.function(x)) print("함수를 전달했군요!")
}

#dataframe이 list에, list는 vector에 포함 됨 
#list는 원소 1개 짜리 1차원 배열과 같다.

testParamType(100)
testParamType(LETTERS)
testParamType(data.frame())
testParamType(matrix())
testParamType(list())
testParamType(array())
testParamType(function(){})


#testParamType
testParamType1 <- function(x){
  result <- NULL
  if(is.vector(x)  && !is.list(x)) result <-"벡터를 전달했군요!"
  else if(is.data.frame(x)) result <- "데이터프레임을 전달했군요!"
  else if(is.list(x)) result <- "리스트를 전달했군요!"
  else if(is.matrix(x)) result <- "매트릭스를 전달했군요!"
  else if(is.array(x)) result <- "배열을 전달했군요!"
  else if(is.function(x)) result <- "함수를 전달했군요!"
  return(result)
}

#dataframe이 list에, list는 vector에 포함 됨 #list는 원소 1개 짜리 1차원 배열과 같다.....?

testParamType1(100)
testParamType1(LETTERS)
testParamType1(data.frame())
testParamType1(matrix())
testParamType1(list())
testParamType1(array())
testParamType1(function(){})

#stop() 함수
testError1 <- function(x){
  if(x<=0)
    stop("양의 값만 전달 하숑!! 더 이상 수행 안할거임..")
  return(rep("테스트",x))
}

testError1(5)
testError1(0)



#warning() 함수
testWarn <- function(x){
  if(x<=0)
    stop("양의 값만 전달 하숑!! 더 이상 수행 안할거임..")
  if(x>5){
    x<-5
    warning("5보다 크면 안됨!! 하여 5로 처리했삼...!!")
  }
  return(rep("테스트",x))
}


testWarn(-1)
testWarn(10)

test1 <-function(p){
  cat("난 수행함\n")
  testError(-1)
  cat("나 수행할 까요? \n")
}
test1()

#try()
test2 <- function(p){
  cat("난 수행함\n")
  try(testError(-1))
  cat("나 수행할 까요? \n")
}
test2()

testAll <-function(p){
  tryCatch({
    if(p=="오류테스트"){
      testError(-1)
    }else if (p =="경고테스트"){
      testWarn(6)
    }else{
      cat("정상 수행..\n")
      print(testError(2))
      print(testWarn(3))
    }
  },warning = function(w){  # catch 구문이라고 생각.
    print(w)
    cat("-.-;;\n")
  }, error = function(e){
    print(e)
    cat("ㅠㅠ \n")
  },finally ={  ## 무조건 출력되는 구문
    cat("오류, 경고 발생 여부를 따라서 반드시 수행되는 부분입니다요..\n")
  })
}

testAll("오류테스트")
testAll("경고테스트")
testAll("아무거나")

carDetainInfo <- carInfos %>% html_nodes('.sub_01') %>% html_text()
