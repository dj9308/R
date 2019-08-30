library(ggplot2)
library(dplyr)

#7
data(mpg)
mpg<-as.data.frame(mpg)

#7-1
mpg<-mpg %>% mutate(`연산 합비`=(hwy+cty))

#7-2
mpg<-mpg %>% mutate(`평균 연비`=(`연산 합비`/2))

#7-3
top<-mpg %>% group_by(class) %>% summarise(max = max(`평균 연비`))
top<- top %>% arrange(desc(max))
top<-top[1:3,]

#7-4
mpg %>% mutate(`연산 합비`=(hwy+cty)) %>% mutate(`평균 연비`=(`연산 합비`/2)) %>% group_by(class) %>% summarise(max = max(`평균 연비`)) %>% arrange(desc(max)) %>%head(3)
  

#8

#8-1
mpg1<-mpg %>% group_by(class) %>% summarise(mean = mean(cty))

#8-2
top<- mpg1 %>% arrange(desc(mean))

#8-3
mpg2<-mpg %>% group_by(class) %>% summarise(mean = mean(hwy))
top<- mpg2 %>% arrange(desc(mean)) %>% head(3)

#8-4
count<- mpg %>% group_by(manufacturer) %>% count(check =(class=="compact"))
count<-count[-c(which(count$check==FALSE)),]
count<-subset(count,select = -check)
count<-count %>% arrange(desc(n))

#9
fuel<-data.frame(fl = c("c","d","e","p","r"),
                 price_fl = c(2.35,2.38,2.11,2.76,2.22)
                 ,stringsAsFactors = F)

#9-1
mpg<-left_join(mpg,fuel,by="fl")

#9-2
mpg %>% head(5)

#10 
data(midwest)
midwest<-as.data.frame(midwest)

#10-1
midwest<- midwest %>% mutate("Totalperc"=((poptotal-popadults)/poptotal)*100)

#10-2
midwest1 <- midwest %>% group_by(county) %>% arrange(desc(Totalperc)) %>% head(5)
midwest1 = data.frame(midwest$county, midwest$Totalperc)

#10-3

count<-midwest %>% mutate("size" = ifelse(Totalperc>=40,"large",ifelse(Totalperc>=30,"middle","small")))
count<- count %>% count(size)

#10-4
midwest<- midwest %>% mutate("asian100"=((poptotal-popasian)/poptotal)*100) %>% arrange(asian100) %>% head()
frame<-data.frame(midwest$state,midwest$county,midwest$asian100)

#11

#11-1
mpg<-as.data.frame(ggplot2::mpg)
mpg[c(65,124,131,153,212),"hwy"]<-NA

table(is.na(mpg$hwy))
table(is.na(mpg$drv))

#11-2
mpg %>% filter(!is.na(hwy)) %>% group_by(drv) %>%  summarise("mean"=mean(hwy)) %>% arrange(desc(mean))


#12
mpg<-as.data.frame(ggplot2::mpg)
mpg[c(10,14,58,93),"drv"]<-"k"
mpg[c(29,43,129,203),"cty"]<-c(3,4,39,42)


#12-1
outlier1 = boxplot(mpg$cty)$stats[1,]
outlier2 = boxplot(mpg$cty)$stats[5,]
mpg<- mpg %>% filter(drv!="k") %>% filter(cty>outlier1 & cty<outlier2)

#12-2
boxplot(mpg$cty)
boxplot(mpg$cty)$stats

#12-3
mpg %>% group_by(drv) %>% summarise("mean"=mean(cty))

