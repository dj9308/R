library(stringr)
library(ggplot2)

product <- read.table("product_click.log")

#1
png(filename="clicklog1.png", height=600, width=900, bg="white")
plot(product$V2 , col=terrain.colors(15) ,main="세로바 그래프 실습"
     , xlab="상품ID" ,ylab="클릭 수")
dev.off()

#2
clicktime <- str_sub(product$V1,9,10)
timelabel <- as.numeric(sort(unique(clicktime)))

png(filename="clicklog2.png", height=400, width=500, bg="white")
pie(table(clicktime),col=rainbow(18),main="파이그래프 실습",
    labels=paste(timelabel,"~",timelabel+1))
dev.off()
