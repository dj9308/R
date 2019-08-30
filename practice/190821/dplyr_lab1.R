install.packages("ggplot2")
install.packages("dplyr")

library(ggplot2)
library(dplyr)
data(mpg)
mpg<-as.data.frame(mpg)

dim(mpg)
head(mpg)
tail(mpg)
view(mpg)
summary(mpg)
str(ggplot2::mpg)

#2
mpg = mpg %>% rename("city"="cty")      #2-1
mpg = mpg %>% rename("highway"="hwy")   
mpg                                     #2-2


#3
data("midwest")
midwest<-as.data.frame(midwest)
summary(midwest)

#3-1
str(ggplot2::mpg)

#3-2
midwest = midwest %>% rename("total"="poptotal")
midwest = midwest %>% rename("asian"="popasian")
mean(midwest$percasian)

#3-3
midwest<-midwest %>% mutate`전체 인구 대비 아시아 인구 백분율`= ifelse(percasian>mean(percasian),"large","small"))

#3-4
check = c(length(which(midwest$MeanCheck=="large")), length(which(midwest$MeanCheck=="small")))
names(check)<-c("large","small")

barplot(check)

#4
data(mpg)
mpg
mpg<-as.data.frame(mpg)

#4-1
mpg %>% group_by(displ<=4) %>% summarise(mean(hwy)) # 26.0
mpg %>% group_by(displ>5) %>% summarise(mean(hwy))  #18.1
# 배기량이 4 이하인 자동차가 연비가 더 높다.

#4-2
mpg %>% group_by(manufacturer=="audi") %>% summarise(mean(cty))   #17.6
mpg %>% group_by(manufacturer=="toyota") %>% summarise(mean(cty)) #18.5
#toyota의 도시연비가 더 높음

#4-3
mpg %>% group_by(manufacturer=="chevrolet" | manufacturer=="honda" | manufacturer =="ford") %>% summarise(mean(hwy))

#5
#5-1
mpg1<-data.frame(mpg$class,mpg$cty)

#5-2
a<-mpg %>% group_by(class=="suv") %>% summarise(mean(hwy))
b<-mpg %>% group_by(class=="compact") %>% summarise(mean(hwy))
a<-a[2,2]
b<-b[2,2]
ifelse(a>b,"suv 의 도시연비가 더 큽니다",
       "compact의 도시연비가 더 큽니다")

#6-1
audi<- mpg %>% group_by(manufacturer=="audi") %>% group_by(class) %>% summarise(mean=mean(hwy))
audi<-as.data.frame(audi)
audi<-audi %>% arrange(desc(mean))
audi<-audi[1:5,]
