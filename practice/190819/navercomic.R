
navercomic<-data.frame()

for(i in 1:114){
  url<-paste0("https://comic.naver.com/genre/bestChallenge.nhn?&page=",i)
  
  text <- read_html(url, encoding = "UTF-8") 
  
  #제목
  comicName <- html_nodes(read, xpath = "//h6[@class='challengeTitle']/a/text()")
  comicName<-gsub("\r\n","",comicName)
  comicName<-trimws(x=comicName)
  
  #요약
  nodes <- html_nodes(read,"div.weekchallengeBox div.summary")
  nodes <- html_nodes(read,xpath = "//div[@class='summary']/")
  comicSummary <- html_text(nodes)
  comicSummary
  
  #평점
  commicGrade <- html_nodes(read, xpath = "//div[@class='rating_type']/strong/text()")
  commicGrade<-trimws(x=commicGrade)
  
  navercomic1<-data.frame(comicName,comicSummary,commicGrade)
  navercomic<- rbind(navercomic, navercomic1)
}
write.csv(navercomic, "navercomic.csv", row.names = FALSE)

