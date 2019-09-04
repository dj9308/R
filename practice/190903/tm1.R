library(tm)
library(proxy)


a1 = c("사과 포도 망고")
a2 = c("포도 자몽 자두")
a3 = c("복숭아 사과 포도")
a4 = c("오렌지 바나나 복숭아")
a5 = c("포도 바나나 망고")
a6 = c("포도 귤 오렌지")
aa = c(a1,a2,a3,a4,a5,a6)

cps <- VCorpus(VectorSource(aa))
tdm <- TermDocumentMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))

m <- as.matrix(tdm)

rowSums(m)




com <- t(m) %*% m
dist(com, method = "cosine") 


1. cosine으로 판단하여 
확인해본 결과 듀크-또치, 듀크-길동이 공동으로 가장 유사하다.

2. rowSums(m)으로 본 결과 포도가 5번으로 제일 많이 선택되고

3. 귤 자몽 포도가 1개로 제일 적게 선택되었다.