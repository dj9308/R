url<- "http://www.saramin.co.kr/zf_user/search?search_area=main&search_done=y&search_optional_item=n&searchType=default_mysearch&searchword=%EC%9E%90%EB%B0%94";

read<-read_html(url, encoding = "UTF-8")

#기술 이름
tech_name<-html_nodes(read, css = ".info_sfilter.smart_filter")
tech_name<-html_nodes(tech_name, css = ".txt")
tech_name<-html_text(tech_name)

#정보 건수
info_count<-html_nodes(read, css = ".info_sfilter.smart_filter")
info_count<- info_count %>% html_nodes('.count') %>% html_text()

#불필요한 내용 제거
tech_name<-gsub("#","",tech_name)
info_count<-gsub("\\(","",info_count)
info_count<-gsub(")","",info_count)

tech_name<-tech_name[-31] # "다른 필터항목" 빼기


frame<-data.frame(info_count,tech_name)
write.csv(frame,"saramin.csv", row.names = FALSE)
