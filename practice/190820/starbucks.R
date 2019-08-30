library(RSelenium)
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")

remDr$open();
site<- paste("https://www.istarbucks.co.kr/store/store_map.do?disp=locale")
remDr$navigate(site)

#서울
fullContentLinkCSS<- "//*[@id=\"container\"]/div/form/fieldset/div/section/article[1]/article/article[2]/div[1]/div[2]/ul/li[1]/a"
fullContentLink<-remDr$findElements(using='xpath',  fullContentLinkCSS)
sapply(fullContentLink,function(x){x$clickElement()})
Sys.sleep(2)

#전체
fullContentLinkCSS<- "//*[@id=\"mCSB_2_container\"]/ul/li[1]/a"
fullContentLink<-remDr$findElements(using='xpath',  fullContentLinkCSS)
sapply(fullContentLink,function(x){x$clickElement()})
Sys.sleep(3)



remDr$executeScript(script = "var su = arguments[0]; var dom = document.querySelectorAll(
                    '#mCSB_3_container > ul >li')[su]; dom.scrollIntoView();",list(3))


a<-1
webElem <- remDr$findElement("css", "body")

market=NULL
juso<-NULL
burnho<-NULL
Lat<-NULL
Lng<-NULL

for(i in 1:498){

    #매장명
  css<- paste0("//*[@id=\"mCSB_3_container\"]/ul/li[",i,"]/strong")
  link<-remDr$findElements(using='xpath',  css)
  repl<-sapply(link,function(x){x$getElementText()})
  market<-c(market,repl)
  
  
  #주소 및 전화번호
  
  
  css<- paste0("//*[@id=\"mCSB_3_container\"]/ul/li[",i,"]/p")
  link<-remDr$findElements(using='xpath',  css)
  repl<-sapply(link,function(x){x$getElementText()})
  repl<-paste0(repl,"")
  repl<-strsplit(repl,"\n")
  juso1<-repl[[1]][1]
  burnho1<-repl[[1]][2]
  
  juso<-c(juso,juso1)
  burnho<-c(burnho,burnho1)
  
  
  #위도 경도
  css<- paste0("//*[@id=\"mCSB_3_container\"]/ul/li[",i,"]")
  link<-remDr$findElements(using='xpath',  css)
  getLat<-sapply(link,function(x){x$getElementAttribute('data-lat')})
  getLng<-sapply(link,function(x){x$getElementAttribute('data-long')})
  
  Lat<-c(Lat,getLat)
  Lng<-c(Lng,getLng)
  
  if(i==498){
    break;
  }if(i==a*3){
    remDr$executeScript(script = "var su = arguments[0]; var dom = document.querySelectorAll(
                    '#mCSB_3_container > ul >li')[su]; dom.scrollIntoView();",list(a*3))
    a<-a+1
    print(a)
  }
}

market<-unlist(market)
Lat<-unlist(Lat)
Lng<-unlist(Lng)

starbucks<-data.frame(market,Lat,Lng,juso,burnho)
write.csv(starbucks,"starbucks.csv", row.names = FALSE)
