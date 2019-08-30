library(rvest)
library(XML)
library(httr)

news <- NULL

newsurl <- GET("https://media.daum.net/ranking/popular/")

newstitle <- html_nodes(read_html(newsurl), 'ul.list_news2 a.link_txt')
newstitle <- html_text(newstitle)

newspapername <- html_nodes(read_html(newsurl), 'ul.list_news2 span.info_news')
newspapername <- html_text(newspapername)

news <- data.frame(newstitle,newspapername)

write.csv(news, "daumnews.csv",row.names = F)