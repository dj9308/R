
library(ggplot2)
library(dplyr)


#Q1
ggplot(mpg, aes(x = cty, y = hwy)) + geom_point()


#Q2 
ggplot(mpg, aes(x=class)) + geom_bar()

#Q3.

point<-midwest %>% filter(poptotal<500000 & popasian)
ggplot(point, aes(x=poptotal, y = popasian)) + geom_point()

#Q4 

x<- mpg$class[which(mpg$class=='compact' | mpg$class=='subcompact' | mpg$class=='suv')]
y<- mpg$cty[which(mpg$class=='compact' | mpg$class=='subcompact' | mpg$class=='suv')]

frame<-data.frame(x,y)

ggplot(data=frame, aes(x= x, y=y)) + geom_boxplot()

#Q5 

file<-read.table("product_click.log")

ggplot(file, aes(x=V2)) + geom_bar()

#Q6 

file$V1<-substr(file$V1, 1,8)
day <- weekdays(as.Date(file$V1, "%Y%m%d"))

data<- data.frame(day, file$V2)
ggplot(data = data, aes(x = day)) + geom_bar()
