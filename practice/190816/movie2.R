# 문제 1

url<- "https://movie.daum.net/moviedb/grade?movieId=121137&type=netizen"
text <- read_html(url , encoding = "UTF-8") 
text

# 영화평점
nodes <- html_nodes(text, ".emph_grade")
point <- html_text(nodes)
title

# 영화리뷰
nodes1 <- html_nodes(text, ".desc_review")
review <- html_text(nodes1, trim = TRUE)
point

movie1<- data.frame(point, review)
write.csv(movie1, "daummovie1.csv", row.names = TRUE, col.names = FALSE)

#문제 2
movie2<-data.frame()

for(i in 1:20){
url<-paste0("https://movie.daum.net/moviedb/grade?movieId=121137&type=netizen&page=",i)

text <- read_html(url, encoding = "UTF-8") 


# 영화평점
nodes <- html_nodes(text, ".emph_grade")
point <- html_text(nodes)


# 영화리뷰
nodes1 <- html_nodes(text, ".desc_review")
review <- html_text(nodes1, trim = TRUE)

movie<-data.frame(point,review)
movie2<- rbind(movie2, movie)
}

write.csv(movie2, "daummovie2.csv", row.names = TRUE)
