# 벡터 실습
x <- c(10,2,7,4,15)
x
print(x)
class(x)
rev(x)
range(x)
sort(x)
sort(x, decreasing = TRUE)
sort(x, decreasing = T)
length(x)
help(sort)
?length
x <- c(1,4,6,8,9); x
x[2]
x[6]
x[-2] # 빼고
x[c(2,4)];x[c(-2,-4)]
x[3] <- 20
x
x + 1
x <- x + 1
max(x);min(x);mean(x);sum(x)
summary(x)
x > 5
x[c(2,4)]
x[c(F,T,F,T,F)] # x[c(T,T)]
x[x > 5] # x[c(F,F,T,T,T)]
x[x > 5 & x < 10]
c(10, 20, "A")
c(10, 20, TRUE, FALSE)
c(10, 20, TRUE, FALSE, "A")


# 매트릭스 실습
vec1 <- c(1,2,3)
vec2 <- c(4,5,6)
vec3 <- c(7,8,9)
mat1 <- rbind(vec1,vec2,vec3); mat1 #행 순서대로 입력
mat2 <- cbind(vec1,vec2,vec3); mat2 #열 순서대로 입력
mat1[1,1]
mat1[2,];mat1[,3]
mat1[1,1,drop=F]
mat1[2,,drop=F];mat1[,3,drop=F]

rownames(mat1) <- NULL
colnames(mat2) <- NULL
mat1;mat2
rownames(mat1) <- c("row1","row2","row3")
colnames(mat1) <- c("col1","col2","col3")

chars <- letters[1:10]

mat1 <-matrix(chars) #열부터 추가함
mat1; dim(mat1)  #dim 함숫 수행하면 행열 출력 가능
mat2 <-matrix(chars, nrow=1)
mat2
mat3 <-matrix(chars, nrow=5)
mat3
mat4 <-matrix(chars, nrow=5, byrow=T)
mat4
mat5 <- matrix(chars, ncol=5)
mat5
mat6 <- matrix(chars, ncol=5, byrow=T)
mat6
mat7 <- matrix(chars, nrow=3, ncol=5)
mat7
mat8 <- matrix(chars, nrow=3)
mat8

x1 <-matrix(1:8, nrow = 2)
x1
x1<-x1*3;x1

sum(x1); min(x1);max(x1);mean(x1)

x2 <-matrix(1:8, nrow =3)
x2

mat1;max(mat1);min(mat1);sum(mat1);mean(mat1);median(mat1)

mean(x2); sum(x2)
mean(x2[2,])
sum(x2[2,])
rowSums(x2); colSums(x2)
apply(x2, 1, sum); apply(x2, 2, sum)  
?apply
apply(x2, 1, max)
apply(x2, 1, min)
apply(x2, 1, mean)

apply(x2, 2, max)
apply(x2, 2, min)
apply(x2, 2, mean)


#배열
a1 <- array(1:30, dim=c(2,3,5))
a1

a1[1,3,4]

a1[,,3]

a1[,2,]

a1[1,,]
















