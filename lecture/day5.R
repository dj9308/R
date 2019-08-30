installed.packages()
search()


# 단일 페이지(rvest 패키지 사용)

install.packages("rvest");
library(rvest)
url<- "https://movie.daum.net/moviedb/grade?movieId=121137&type=netizen"
text <- read_html(url , encoding = "UTF-8") # CP949 = MS949
text

# 영화제목
nodes <- html_nodes(text, ".emph_grade")
point <- html_text(nodes)
title

# 영화평점
nodes1 <- html_nodes(text, ".desc_review")
review <- html_text(nodes1, trim = TRUE)
point

movie1<- data.frame(point, review)

# 영화리뷰
nodes <- html_nodes(text, ".title")
review <- html_text(nodes, trim=TRUE)
review
review <- gsub("\t", "", review)
review <- gsub("\r\n", "", review)
review <- gsub("신고", "", review)
review
page <- cbind(title, point)
page <- cbind(page, review)
write.csv(page, "movie_reviews.csv")

# 여러 페이지
site<- "http://movie.naver.com/movie/point/af/list.nhn?page="
movie.review <- NULL
for(i in 1: 100) {
  url <- paste(site, i, sep="")
  text <- read_html(url,  encoding="CP949")
  nodes <- html_nodes(text, ".movie")
  title <- html_text(nodes)
  nodes <- html_nodes(text, ".point")
  point <- html_text(nodes)
  nodes <- html_nodes(text, ".title")
  review <- html_text(nodes, trim=TRUE)
  review <- gsub("\t", "", review);  review <- gsub("\r\n", "", review)
  review <- gsub("신고", "", review)
  page <- cbind(title, point)
  page <- cbind(page, review)
  movie.review <- rbind(movie.review, page)
}
write.csv(movie.review, "movie_reviews2.csv")

# 한국일보 페이지(XML 패키지 사용)
install.packages("XML")
library(XML)
ismi <- read_html("http://hankookilbo.com")
t <- htmlParse(ismi)  #read_html 과 같은 역할
content<- xpathSApply(t,"//p[@class='title']", xmlValue)
# xmlvalue
# 행단위로 합 구하기 등 1: 행 2: 열
# apply(매트릭스,1 or 2, FUN)
content
content <- gsub("[[:punct:][:cntrl:]]", "", content) #블랭크, 백슬래시 없애기
content
content <- trimws(content)
content

# httr 패키지 사용 - GET 방식 요청
install.packages("httr")
library(httr)
http.standard <- GET('http://www.w3.org/Protocols/rfc2616/rfc2616.html')
title2 = html_nodes(read_html(http.standard), 'div.toc h2')
title2 = html_text(title2)
title2

# httr 패키지 사용 - POST 방식 요청
library(httr)
# POST 함수를 이용해 모바일 게임 랭킹 10월 29일 주  모바일 게임 랭킹을 찾는다
#(http://www.gevolution.co.kr/score/gamescore.asp?t=3&m=0&d=week) 
game = POST('http://www.gevolution.co.kr/score/gamescore.asp?t=3&m=0&d=week',
            encode = 'form', body=list(txtPeriodW = '2018-12-03'))
title2 = html_nodes(read_html(game), 'a.tracktitle')
title2 = html_text(title2)
title2[1:10]


# 뉴스, 게시판 등 글 목록에서 글의 URL만 뽑아내기 
res = GET('https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001')
htxt = read_html(res)
link = html_nodes(htxt, 'div.list_body a')
article.href = unique(html_attr(link, 'href'))    # 중복된 것은 하나로 표현
article.href                 #원하는 속성값만 표현

# 이미지, 첨부파일 다운 받기   정적 크롤링 
# pdf
res = GET('http://cran.r-project.org/web/packages/httr/httr.pdf')
writeBin(content(res, 'raw'), 'c:/Temp/httr.pdf')

# jpg
h = read_html('http://unico2013.dothome.co.kr/productlog.html')
imgs = html_nodes(h, 'img')   #img 태그 찾고
img.src = html_attr(imgs, 'src')   # img 태그중 src 속성을 가지고
for(i in 1:length(img.src)){
  res = GET(paste('http://unico2013.dothome.co.kr/',img.src[i], sep="")) 
  #이미지 요청후 끌어온다음
  writeBin(content(res, 'raw'), paste('c:/Temp/', img.src[i], sep=""))
  # 그대로 있는 주소에 저장하는 것.
} 

# 네이버 블로그 연동 : Rcurl 패키지 사용 
install.packages("RCurl")
library(RCurl)
library(XML)
searchUrl<- "https://openapi.naver.com/v1/search/blog.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode(iconv("여름추천요리","euc-kr","UTF-8"))
url<- paste(searchUrl, "?query=", query, "&display=20", sep="")
doc<- getURL(url, httpheader = c('Content-Type' = "application/xml",
                                 'X-Naver-Client-Id' = Client_ID,'X-Naver-Client-Secret' = Client_Secret))
# 블로그 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue)
text

# 네이버 뉴스 연동 : Rcurl 패키지 사용 
library(RCurl)
library(XML)
searchUrl<- "https://openapi.naver.com/v1/search/news.xml"
Client_ID <- "izGsqP2exeThwwEUVU3x"
Client_Secret <- "WrwbQ1l6ZI"
query <- URLencode(iconv("미세먼지","euc-kr","UTF-8"))
url<- paste(searchUrl, "?query=", query, "&display=20", sep="")
doc<- getURL(url, httpheader = c('Content-Type' = "application/xml",
                                 'X-Naver-Client-Id' = Client_ID,'X-Naver-Client-Secret' = Client_Secret))
# 블로그 내용에 대한 리스트 만들기		
doc2 <- htmlParse(doc, encoding="UTF-8")
text<- xpathSApply(doc2, "//item/description", xmlValue); 
text

# 트위터 글 읽어오기
install.packages("twitteR")
library(twitteR) 
api_key <- "gjUkHgO8bFmNobRk4g0Jas8xb"
api_secret <- "loF0mtnzLhtQDFjahdRHox6wcR1fiD6Fw95DP5QCSy3rLTTP1K"
access_token <- "607145164-8L5HtzopZzhjuBCgusUGKE3MHOa9P4RbmhUrM0E1"
access_token_secret <- "2wn2bsCA7JIH5DZ5Ss1deS5BNLabzaX2xSpM2ZLMIqwQf"
setup_twitter_oauth(api_key,api_secret, access_token,access_token_secret)
# oauth 정보 저장 확인
key <- "취업"
key <- enc2utf8(key)
result <- searchTwitter(key, n=100)
DF <- twListToDF(result)
str(DF)
content <- DF$text
content <- gsub("[[:lower:][:upper:][:digit:][:punct:][:cntrl:]]", "", content)   
content

install.packages("XML")
library(XML)
API_key  <- "%2BjzsSyNtwmcqxUsGnflvs3rW2oceFvhHR8AFkM3ao%2Fw50hwHXgGyPVutXw04uAXvrkoWgkoScvvhlH7jgD4%2FRQ%3D%3D"
bus_No <- "402"
url <- paste("http://ws.bus.go.kr/api/rest/busRouteInfo/getBusRouteList?ServiceKey=", API_key, "&strSrch=", bus_No, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc)
top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df
str(df)
busRouteId <- df$busRouteId
busRouteId
url <- paste("http://ws.bus.go.kr/api/rest/buspos/getBusPosByRtid?ServiceKey=", API_key, "&busRouteId=", busRouteId, sep="")
doc <- xmlParse(url)
top <- xmlRoot(doc); top
df <- xmlToDataFrame(getNodeSet(doc, "//itemList"))
df


# 정규표현식 사용

word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub("A", "", word) 
gsub("a", "", word) 
gsub("Aa", "", word) 
gsub("(Aa){2}", "", word) 
gsub("[Aa]", "", word) 
gsub("[가-힣]", "", word) 
gsub("[^가-힣]", "", word) 
gsub("[&^%*]", "", word) 
gsub("[[:punct:]]", "", word) 
gsub("[[:alnum:]]", "", word) 
gsub("[1234567890]", "", word) 
gsub("[[:digit:]]", "", word) 
gsub("[^[:alnum:]]", "", word) 
gsub("[[:space:]]", "", word) 





url<-"http://media.daum.net/ranking/popular/"
info<-read_html(url)
newsread<- html_nodes(use, css = ".list_news2")



# 아고다 호텔 댓글

remDr$navigate("https://www.agoda.com/ko-kr/shilla-stay-seocho/hotel/seoul-kr.html?cid=-204")
more<-remDr$findElements(using='css','#SearchBoxContainer > div > div > div.Popup__container.Popup__container--garage-door > div > div > div.AlertMessage.CalendarAlertMessage > a')
sapply(more,function(x){x$clickElement()})
doms <- remDr$findElements(using = "css selector", ".Review-comment-bodyText")
sapply(doms, function (x) {x$getElementText()}) # 돔객체가 하나가 찾아지면 한번 수행

# 웹툰 댓글

repl_v = NULL;
url<-'http://comic.naver.com/comment/comment.nhn?titleId=570503&no=135'
remDr<-remoteDriver(remoteServerAddr="localhost",port=4445L,browserName="chrome")
remDr$open()
remDr$navigate(url)
doms1<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
p_repl <- sapply(doms1,function(x){x$getElementText()})
p_repl_v <- unlist(p_repl)
more<-remDr$findElements(using='css','span.u_cbox_in_view_comment')
sapply(more,function(x){x$clickElement()})
doms2<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
repl <-sapply(doms2,function(x){x$getElementText()})
repl_v <- c(repl_v, unlist(repl))


repeat {
  for (i in 4:12) {               
    nextCss <- paste("#cbox_module>div>div.u_cbox_paginate>div> a:nth-child(",i,") > span", sep="")                
    try(nextPage<-remDr$findElements(using='css',nextCss)) # try = find 못찾으면 죽어버려서 넣음
    if(length(nextPage) == 0)   break;  # 실행에러가 떠도 넘어가라.
    sapply(nextPage,function(x){x$clickElement()})
    Sys.sleep(1)  # 1초간 쉬었다가 계속하기.
    doms3<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
    repl <-sapply(doms3,function(x){x$getElementText()})
    repl_v <- c(repl_v, unlist(repl))                
  }
  try(nextPage<-remDr$findElements(using='css',
                                   "#cbox_module > div > div.u_cbox_paginate > div > a:nth-child(13) > span.u_cbox_cnt_page"))
  if(length(nextPage) == 0)  break;
  sapply(nextPage,function(x){x$clickElement()})
  Sys.sleep(1)
  doms2<-remDr$findElements(using ="css selector","ul.u_cbox_list span.u_cbox_contents")
  repl <-sapply(doms2,function(x){x$getElementText()})
  repl_v <- c(repl_v, unlist(repl))        
}
print(repl_v)
write(repl_v, "webtoon.txt")
