remDr$open()
remDr$navigate("https://www.agoda.com/ko-kr/shilla-stay-seocho/hotel/seoul-kr.html?cid=-204")
more<-remDr$findElements(using='css','#SearchBoxContainer > div > div > div.Popup__container.Popup__container--garage-door > div > div > div.AlertMessage.CalendarAlertMessage > a')
sapply(more,function(x){x$clickElement()})
doms <- remDr$findElements(using = "css selector", ".Review-comment-bodyText")
repl_v<-sapply(doms, function (x) {x$getElementText()})

reple<- NULL
for(i in 1:14){
  doms <- remDr$findElements(using="css selector",".Review-comment-bodyText")
  reple_v <- sapply(doms,function(x){x$getElementText()})
  reple <- c(reple, unlist(reple_v))
  
  more<-remDr$findElements(using='css selector',"#reviewSection > div:nth-child(4) > div > span:nth-child(3)")
  reple1<-sapply(more,function(x){x$clickElement()})
  reple<-c(reple,unlist(reple1))
  
  Sys.sleep(5)
}
write.table(reple,"C:/Rstudy/hotel.txt")
  