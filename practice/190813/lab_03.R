

  #문제 10
  
a<-array(1:24,dim=c(2,3,4))
a[2,,]
a[,1,]
a[,,3]
a<-a+100
a[,,4]<-a[,,4]*100
a<-a*10
rm(a)

#문제 11

x<-c(1:5); y<-c(seq(2,10,2))
df1<-data.frame(x,y);

#문제 12

col1<-x; col2<-(letters[1:5]) ; col3<-y;
df2<-data.frame(col1,col2,col3)

#문제 13

가격<-c(1800,1500,3000)
판매량<-c(24,38,13)
df3<- data.frame(가격,판매량);df3
rownames(df3)<-c("사과","딸기","수박")
names(df3)<-제품명
df3
# 문제 14

mean(df3[,2])
mean(df3[,3])

# 문제 15
name <- c("Potter", "Elsa", "Gates", "Wendy", "Ben")
gender <- factor(c("M", "F", "M", "F", "M"))
math <- c(85, 76, 99, 88, 40)
df4<- data.frame(name,gender,math, stringsAsFactors = FALSE);df4
str(df4)

df4$stat<-c(76, 73, 95, 82, 35)
score<- df4$math+df4$stat
grade<-ifelse(score>=150,"A",ifelse(score>=100,"B",ifelse(score>=70,"C","D")))

#문제 16
str(emp)
emp
#문제 17
emp[c(3,4,5),];

# 문제 18
emp[,"ename"]

# 문제 19
emp[,c("sal","ename")]

# 문제 20
subset(emp, select=c("ename","sal","job"), subset= emp$job== "SALESMAN")

# 문제 21
subset(emp, select=c("ename","sal","deptno"), subset= emp$sal>=1000 & emp$sal<=3000)

# 문제 22
subset(emp, select=c("ename","job","sal"), subset= emp$job!="ANALYST")

# 문제 23
subset(emp, select=c("ename","job"), subset= emp$job=="ANALYST" |emp$job=="SALESMAN")

# 문제 24

subset(emp, select=c("ename","comm"), subset= is.na(emp$comm))

# 문제 25
emp<-emp[c(order(emp$sal)),]
emp



