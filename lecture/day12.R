install.packages("ggplot2")
install.packages("dplyr")
install.packages("KoNLP")
install.packages("ggmap")
install.packages("leaflet")
install.packages("stringr")
install.packages("wordcloud")
install.packages("wordcloud2")
install.packages("rvest")
install.packages("XML")
install.packages("httr")

library(dplyr)
library(ggmap)
library(ggplot2)

register_google(key='AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY')

geocode('Seoul', source = 'google')
geocode('Seoul', source = 'google', output = 'latlona')
geocode(enc2utf8('서울'), source = 'google')
geocode(enc2utf8('서울'), source = 'google', output = 'latlona')
geocode(enc2utf8('서울&language=ko'), source = 'google', output = 'latlona')

#mutate_geocode(data.frame, address_column_name, source = 'google')
station_list = c('시청역', '을지로입구역', '을지로3가역', '을지로4가역', 
                 '동대문역사문화공원역', '신당역', '상왕십리역', '왕십리역', '한양대역', 
                 '뚝섬역', '성수역', '건대입구역', '구의역', '강변역', '잠실나루역', 
                 '잠실역', '신천역', '종합운동장역', '삼성역', '선릉역', '역삼역', 
                 '강남역', '2호선 교대역', '서초역', '방배역', '사당역', '낙성대역', 
                 '서울대입구역', '봉천역', '신림역', '신대방역', '구로디지털단지역', 
                 '대림역', '신도림역', '문래역', '영등포구청역', '당산역', '합정역', 
                 '홍대입구역', '신촌역', '이대역', '아현역', '충정로역')
station_df = data.frame(station_list, stringsAsFactors = FALSE)
station_df$station_list = enc2utf8(station_df$station_list)
station_lonlat = mutate_geocode(station_df, station_list, source = 'google')
station_lonlat

qmap('seoul', zoom = 11)
qmap('seoul', zoom = 11, color = 'bw')
qmap('seoul', zoom = 11, maptype = 'roadmap')
qmap('seoul', zoom = 11, maptype = 'satellite')
qmap('seoul', zoom = 11, maptype = 'hybrid')

qmap('seoul', zoom = 11, source = 'stamen', maptype = 'watercolor')
qmap('seoul', zoom = 11, source = 'stamen', maptype = 'toner')

seoul_lonlat = unlist(geocode('seoul', source = 'google'))
qmap(seoul_lonlat, zoom = 11, source = 'stamen', maptype = 'toner')

seoul_map <- qmap('Seoul', zoom = 11, source = 'stamen', maptype = 'toner')
seoul_map + geom_point(data = station_lonlat, aes(x = lon, y = lat), colour = 'green',
                       size = 4)

wifi_data = read.csv('wifi_data.csv', encoding = 'utf-8', stringsAsFactors = FALSE)
seoul_map + geom_point(data = wifi_data, aes(x = lon, y = lat)) + facet_wrap(~div)
seoul_map + 
  geom_polygon(data = wifi_data, aes(x = lon, y = lat, fill = ..level..), 
               stat = 'density2d', alpha = 0.3) + 
  scale_fill_gradient(low = '#C6DBEF', high = '#08306B') + 
  facet_wrap(~div)

head(wifi_data) 

# 지도 응용


df <- read.csv("전국전기차충전소표준데이터.csv", stringsAsFactors=F)       
str(df) 
head(df)
df_add <- as.data.frame(df[,14])
df_add
names(df_add) <- c("address")
head(df_add)
df_add <- df_add %>% filter(address != "")  
str(df_add)    

df_add$address <- as.character(df_add$address)    #factor를 character로 변환
df_add$address <- iconv(df_add$address, from="cp949", to="UTF-8") #UTF-8로 지정해주지 않으면 주소가 모두 NA가 된다.
head(df_add)

#mut_df_add <- mutate_geocode(df_add, address, source="google")
# 서버에 여러번 신청하게 되어서 과금이 걸릴 수있음.

#save(mut_df_add, file="전기차.rda")
load(file = "전기차.rda")
head(mut_df_add)
map_korea <- get_map(location="southKorea", zoom=7, maptype="roadmap") 
ggmap(map_korea)

ggmap(map_korea)+geom_point(data=mut_df_add, aes(x=lon, y=lat), alpha=0.5, size=2, color="red")


map_seoul <- get_map(location="seoul", zoom=11, maptype="roadmap")       
ggmap(map_seoul)+geom_point(data=mut_df_add, aes(x=lon, y=lat), alpha=0.5, size=5, color="blue")

#leaflet 그리기

install.packages("leaflet")
install.packages("dplyr")
install.packages("ggmap")
library(leaflet)
library(dplyr)
library(ggmap)

seoul_lonlat <- geocode("seoul")

map0 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16)  # 위치 정보 필수
map0

map1 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16) %>% addTiles() 
map1

mk <- geocode(enc2utf8('서울특별시 강남구 역삼동 테헤란로 212'))
lan <- mk$lon
lat <- mk$lat
msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none" >멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ'
map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% addTiles() %>% addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 18) %>% addTiles() %>% addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 5) %>% addTiles() %>% addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2

map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 1) %>% addTiles() %>% addCircles(lng = lan, lat = lat, color='green', popup = msg )
map2


content1 <- paste(sep = '<br/>',"<b><a href='https://www.seoul.go.kr/main/index.jsp'>서울시청</a></b>",'아름다운 서울','박원순 시장님 화이팅!!')
map3<-leaflet() %>% addTiles() %>%  addPopups(126.97797, 37.56654, content1, options = popupOptions() )
map3

content2 <- paste(sep = '<br/>',"<b><a href='http://www.snmb.mil.kr/mbshome/mbs/snmb/'>국립서울현충원</a></b>",'1955년에 개장', '2013년 ‘서울 미래유산’으로 등재')
map3<-leaflet() %>% addTiles() %>%  addPopups(c(126.97797, 126.97797),  c(37.56654, 37.50124) , c(content1, content2), options = popupOptions(closeButton = FALSE) )
map3

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], 
          lat = seoul_lonlat[2], 
          zoom = 11) %>% 
  addTiles() %>% 
  addCircles(lng = ~lon, lat = ~lat)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat)
leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('CartoDB.Positron') %>% 
  addCircles(lng = ~lon, lat = ~lat)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat = ~lat, popup = ~div)

telecom_color = colorFactor('Set1', wifi_data$div)

leaflet(wifi_data) %>% 
  setView(lng = seoul_lonlat[1], lat = seoul_lonlat[2], zoom = 11) %>% 
  addProviderTiles('Stamen.Toner') %>% 
  addCircles(lng = ~lon, lat=~lat, popup = ~div, color = ~telecom_color(div))


# leaflet과 우리나라 행정구역 지도 활용

install.packages("devtools") 
devtools::install_github("cardiomoon/Kormaps")
library(Kormaps)

names(korpopmap1)
names(korpopmap2)
names(korpopmap3)

head(korpopmap1)
head(korpopmap2)
head(korpopmap3)

crime <- read.csv('2017crime.csv')

Encoding(names(korpopmap2))<-'UTF-8'
Encoding(korpopmap2@data$name)<-'UTF-8'
Encoding(korpopmap2@data$행정구역별_읍면동)<-'UTF-8' #인코딩으로 한글 깨짐 문제 해결
korpopmap2@data <- korpopmap2@data[-26:-251,]     #서울 지역 정보만 추출
korpopmap2@polygons<-korpopmap2@polygons[-26:-251] # 다각형 추출
mymap <- korpopmap2@data
head(mymap)

palette1<-colorNumeric(palette= 'Oranges', domain = crime$살인_발생)
popup1 <- paste0(mymap$name,'<br> 살인 : ',crime$살인_발생, '건')
map4<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup1, color=~palette1(crime$살인_발생), group='살인')
# 리플렛 함수 추가 setview 호출 및 addpolygon에서 color를 palette1의 살인발생 숫자 만큼 출력
map4


palette2<-colorNumeric(palette = 'Blues', domain = crime$폭력_발생)
popup2 <- paste0(mymap$name,'<br> 폭력 : ',crime$폭력_발생, '건')
map5<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup2, color=~palette2(crime$폭력_발생), group='폭력')
map5


palette3<-colorNumeric(palette = 'Reds', domain = crime$범죄_발생_총합)
popup3 <- paste0(mymap$name,'<br> 폭력 : ',crime$범죄_발생_총합, '건')
map6<-leaflet(korpopmap2) %>% addTiles() %>% setView(lat=37.559957 ,lng=126.975302 , zoom=11)%>%
  addPolygons(stroke=FALSE,smoothFactor=0.2,fillOpacity=.5, popup=popup3, color=~palette3(crime$범죄_발생_총합),group='총 범죄')
map6



DONG<-read.csv('c:/RStudy/one.csv')
head(DONG)
data(korpopmap3)
Encoding(names(korpopmap3))<-'UTF-8'
Encoding(korpopmap3@data$name_eng)<-'UTF-8'
Encoding(korpopmap3@data$name)<-'UTF-8'
Encoding(korpopmap3@data$행정구역별_읍면동)<-'UTF-8'

korpopmap3@data<-korpopmap3@data[c(67:81),] 
korpopmap3@polygons<-korpopmap3@polygons[c(67:81)] 

korpopmap3@data$name<-gsub('·','',korpopmap3@data$name) 
colnames(DONG)<-c('구별','name','일인가구')
dong<- DONG %>%filter(구별=='광진구')

korpopmap3@data<-merge(korpopmap3@data,dong,by.x='name',sort=FALSE)
mymap <- korpopmap3@data
mypalette <- colorNumeric(palette ='RdYlBu' , domain = mymap$'일인가구')
mypopup <- paste0(mymap$name,'<br> 1인가구: ',mymap$'일인가구')

map7 <- NULL
map7<-leaflet(korpopmap3) %>% 
  addTiles() %>% 
  setView(lat=37.52711, lng=126.987517, zoom=12) %>%
  addPolygons(stroke =FALSE,
              smoothFactor = 0.2,
              fillOpacity = .9,
              popup = mypopup,
              color = ~mypalette(mymap$일인가구)) %>% 
  addLegend( values = ~mymap$일인가구,
             pal =mypalette ,
             title = '인구수',
             opacity = 1)
map7	

install.packages("RColorBrewer")
library(RColorBrewer)

for(col_i in c('YlGn','RdPu', 'PuRd', 'BrBG', 'RdBu', 'RdYlBu', 'Set3', 'Set1')){
  print(col_i)
  print(brewer.pal(n = 5, name = col_i))
}

install.packages("htmlwidgets")
library(htmlwidgets)


saveWidget(map7, file="m.html")
