  #문제 2


m1<-matrix(data=seq(10,38,2),nrow = 3,ncol = 5);m1
m2<-m1+100;m2
m_max_v<-max(m1);m_max_v
m_min_v<-min(m1);m_min_v
row_max<-cbind(max(m1[1,]),max(m1[2,]),max(m1[3,]))
col_max<-cbind(max(m1[,1]),max(m1[,2]),max(m1[,3]))


#문제 6
n1<-c(1,2,3)
n2<-c(4,5,6)
n3<-c(7,8,9)
m1<-cbind(n1,n2,n3)

#문제 7
num<-c(1:10)
m2<-matrix(data=num,nrow = 3, ncol = 3 , byrow = TRUE )

# 문제 8
rownames(m2) <- c("row1","row2","row3")
colnames(m2) <- c("col1","col2","col3")

#문제 9
cc<- letters[1:6]
alpha<-matrix(data=letters[1:6],nrow = 2, ncol = 3)
alpha2<-rbind(alpha,c("x","y","z"))
alpha3<-cbind(alpha,c("s","p"))





