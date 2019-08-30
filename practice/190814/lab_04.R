#문제 26
L1<-list();
L1$name<-"scott";
L1$sal<-3000;
result1<-x$sal*2;

#문제 27
L2<-list("scott",c(100,200,300))

#문제 28
x<-list(c(3,5,7),c("A","B","C"))
x[[2]][1]<-"alpha"


#문제 29
y<-list(alpha=0:4, beta=sqrt(1:5), gamma=log(1:5))
y[[1]]<-y$alpha+10;

#문제 30
x<-list(math=list(95, 90), writing=list(90, 85), reading=list(85, 80))
mean(unlist(x))

#제어문
#문제 1
grade =sample(1:6,1)
ifelse(grade==1 | grade==2| grade==3,paste0(grade,"학년은 저학년입니다."),paste0(grade,"학년은 고학년입니다."))

#문제 2
choice <- sample(1:5,1)
result2 <- switch(EXPR = choice,
                  300+50,300-50,300*50,300/50,300%%50)
cat("결과값 :",result2)
#문제 3

time<- 32150
time<- paste0(time%/%3600,"시간",(time%%3600)%/%60,"분",((time%%3600)%%60),"초")

#문제 4

count<- sample(3:10,1)
deco<- sample(1:3,1)

if(deco==1){
  rep("*",count)
}else if(deco==2){
  rep("$",count)
}else{
  rep("#",count)
}

#문제 5

score <- sample(0:100,1)
score10 <- paste(score%/%10,"",sep="")
level <- paste(switch(EXPR=score10,
                      "10"=,"9"="A","8"="B","7"="C","6"="D","F"))
paste(score,"점은",level,"등급입니다")

#문제 6
alpha<-paste0(LETTERS[1:26],letters[1:26])
alpha
