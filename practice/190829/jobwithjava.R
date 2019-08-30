library(RSelenium)
library(KoNLP)

remDr<-remoteDriver(remoteServerAddr="localhost", port = 4445, browserName="chrome")
remDr$open()
remDr$navigate("http://www.jobkorea.co.kr/")

#검색+6
more<-remDr$findElements(using = 'css', '#stext')
sapply(more,function(x){x$setElementAttribute("value","자바")})

search<-remDr$findElements(using = 'css', '#common_search_btn')
sapply(search,function(x){x$clickElement()})

#태그 추출

reple=NULL
reple

a<-2

for(i in 2:20){
  
  for(j in 1:30){
    selector<-paste0("#smGiList > div.list > ul > li:nth-child(",j,") > span.detailInfo > p.gibInfo > a")
    tag<-remDr$findElements(using = 'css', selector)
    reple_v <- sapply(tag,function(x){x$getElementText()})
    reple <- c(reple, unlist(reple_v))
  }
  #페이지 넘기기
  if(i<11){
    tag<-remDr$findElements(using = 'css', paste0("#smGiList > div.tplPagination > ul > li:nth-child(",i,") > a"))
    sapply(tag,function(x){x$clickElement()})
  }else if(i==11){
    tag<-remDr$findElements(using = 'css', "#smGiList > div.tplPagination > p > a")
    sapply(tag,function(x){x$clickElement()})
  }else{
    tag<-remDr$findElements(using = 'css', paste0("#smGiList > div.tplPagination > ul > li:nth-child(",a,") > a"))
    sapply(tag,function(x){x$clickElement()})
    a<-a+1
  }
  Sys.sleep(1)
  
  
}

write.table(reple, "C:/Rstudy/jobwithjava.txt")

text<- read.table("jobwitjava.txt", header = T)

reple2<-sapply(reple, extractNoun, USE.NAMES = F)
reple3<-unlist(reple2)
table<-table(reple3)

table1<-sort(table, decreasing = T)
table1<-head(table1,n=15)
table1

write.csv(table1, file = "jobwithjava.csv", row.names = FALSE)

wordcloud2(table1)

