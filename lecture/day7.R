install.packages("dplyr")
install.packages("ggplot2")
library(dplyr)
exam<-read.csv("csv_exam.csv")
dim(exam) # 행 열 확인
head(exam); tail(exam); 
exam %>% filter(class==1)
exam %>% filter(math>=90 | english>=90)
exam %>% filter(class %in% c(1,3,5))
exam %>% group_by(class) %>% summarise(mean_math = mean(math),
                                       sum_math=sum(math),
                                       median_math = median(math),
                                       n=n() ) # n() =빈도
