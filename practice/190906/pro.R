library(rvest)
library(XML)
library(httr)

news <- NULL

newsurl <- GET("https://media.daum.net/ranking/popular/")

newstitle = NULL;
for(i in 1:5){
title <- html_nodes(read_html(newsurl), paste0("#mArticle > div.rank_news > ul.list_news2 > li:nth-child(",i,") > div.cont_thumb > strong > a"))
title <- html_text(title)
newstitle <-c(newstitle,title)
}

newspapername <- html_nodes(read_html(newsurl), 'ul.list_news2 span.info_news')
newspapername <- html_text(newspapername)

data<-data.frame(newstitle,newspapername)

data1