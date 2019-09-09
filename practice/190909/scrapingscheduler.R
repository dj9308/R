
library(rvest)
url<-"http://media.daum.net/ranking/popular/"
htxt <- read_html(url)

newstitle = html_nodes(htxt, '.list_news2 .tit_thumb a')
newstitle<-html_text(newstitle)
newstitle <- gsub("[[:punct:][:cntrl:]]", "", newstitle[1:5])
newspapername =html_nodes(htxt, '.info_news')
newspapername <- html_text(newspapername)[1:5]

news<-data.frame(newstitle, newspapername, stringsAsFactors = F)
news