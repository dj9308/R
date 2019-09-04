register_google(key='비밀~')

map<-get_map(location = 'seoul', zoom = 11, maptype = 'roadmap')

df <- read.csv("지역별장애인도서관정보.csv", stringsAsFactors=F)

ggmap(map)+geom_point(data=df, aes(x=LON, y=LAT), alpha=0.5, size=2, color="red")+
geom_text(data = df, aes(x=LON, y=LAT, label=paste0(도서관명,전화번호), vjust=0, hjust=0))
