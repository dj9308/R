mpg<-as.data.frame(ggplot2::mpg)
#1
plot(mpg$cty,mpg$hwy,pch=3,xlab="도시연비", ylab="고속도로연비")

#2
drv_cnt<-table(mpg$drv)
barplot(drv_cnt, col=rainbow(length(drv_cnt)))

#3
boxplot(hwy~manufacturer,data=mpg,las = 2,xlab="",ylab="고속도로 연비",
        main="*제조사별 고속도로 연비*", col.main="hotpink",col=heat.colors(length(unique(mpg$manufacturer))),
        ylim=c(5,40))