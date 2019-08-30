library(RSelenium)
remDr<-remoteDriver(remoteServerAddr = "localhost", port=4445, browserName="chrome")

remDr$open();
site<- paste("http://www.yes24.com/24/goods/40936880")
remDr$navigate(site)
webElem<- remDr$findElement("css", "body")
#remDr$executeScript("scrollTo(0, document.body.scrollHeight-200)", args = list(webElem))

fullContentLinkCSS<- "//*[@id=\"yDetailTabNavWrap\"]/div/div/ul/li[2]/a"
fullContentLink<-remDr$findElements(using='xpath',  fullContentLinkCSS)
sapply(fullContentLink,function(x){x$clickElement()})
Sys.sleep(1)

repl_v = NULL

repeat{
  for(a in 3:12){ #1~10페이지
    
    #펼쳐보기
    for(i in 2:6){
      path<-paste0("//*[@id=\"infoset_reviewContentList\"]/div[",i,"]/div[5]/a");
      full<-remDr$findElements(using='xpath', value=path)
      if(length(full)==0){
        break
      }else{
        sapply(full,function(x){x$clickElement()})
        Sys.sleep(1)
      }
    }  
    
    
    #내용 넣기
    for(i in 2:6){
      fullContentCSS<- paste0("//*[@id=\"infoset_reviewContentList\"]/div[",i,"]/div[3]/div[2]")
      #fullContentCSS<- paste0("//*[@id=\"infoset_reviewContentList\"]/div[2]/div[3]/div[2]")
      fullContent<-remDr$findElements(using='xpath', fullContentCSS)
      print(fullContent)
      repl<-sapply(fullContent,function(x){x$getElementText()})
      if(length(repl)==0){
        break
      }else{
        repl<-gsub("\n\n","",repl)    #줄바꿈 하는 방법 알아내기
        repl<-gsub("\n","",repl)
        
        print(repl)
        repl_v<- c(repl_v, unlist(repl))
        Sys.sleep(1)
      }
    }
    if(a!=12){
      # 리뷰/한줄평 클릭
      fullContentLinkCSS<- paste0("//*[@id=\"yDetailTabNavWrap\"]/div/div/ul/li[2]/a")
      fullContentLink<-remDr$findElements(using='xpath',  fullContentLinkCSS)
      sapply(fullContentLink,function(x){x$clickElement()})
      Sys.sleep(1)
      
      #페이지 이동
      fullContentLinkCSS<- paste0("//*[@id=\"infoset_reviewContentList\"]/div[1]/div[1]/div/a[",a,"]")
      fullContentLink<-remDr$findElements(using='xpath',  fullContentLinkCSS)
      sapply(fullContentLink,function(x){x$clickElement()})
      Sys.sleep(2)
    }else{
      # 리뷰/한줄평 클릭
      fullContentLinkCSS<- paste0("//*[@id=\"yDetailTabNavWrap\"]/div/div/ul/li[2]/a")
      fullContentLink<-remDr$findElements(using='xpath',  fullContentLinkCSS)
      sapply(fullContentLink,function(x){x$clickElement()})
      Sys.sleep(1)
      
      # 화살표로 페이지 이동
      css1<- paste0("#infoset_reviewContentList > div.review_sort.sortTop > div.review_sortLft > div > a.bgYUI.next")
      link<-remDr$findElements(using='css',  css1)
      sapply(link,function(x){x$clickElement()})
      Sys.sleep(2)
      
      fullContentCSS<- "//*[@id=\"infoset_reviewContentList\"]/div[2]/div[3]/div[2]"
      fullContent<-remDr$findElements(using='xpath', fullContentCSS)
      repl<-sapply(fullContent,function(x){x$getElementText()})
      Sys.sleep(1)
      
      repl<-unlist(repl)
    }
  }
  #repeat문 탈출 조건문
  if (repl!="") {  #20이 되어 안넘어가지면 계속 펼쳐보기가 되어있을 것이므로 내용이 저장 될 것.
    print("hello!")
    break
  }
}

write(repl_v, "yes24.txt")
