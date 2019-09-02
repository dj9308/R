# R 지도 구현

## ggmap

- library(ggmap)

1. register_google(key='키값') : 키 등록으로 구글지도 접속

2. geocode('지역 이름', source = 'google') : 지역 이름에 따른 위도 및 경도를 반환.
   geocode(enc2utf8('서울'), source = 'google') : enc2utf8는 UTF-8의 한글로 지역을 지정할때 쓰임
   한글로 하려면 이것이 꼭 필요.

3. mutate_geocode(데이터프레임, 지역을 표현하는 열, source = 'google')
   mutate_geocode : 데이터 프레임에 위도 경도 열을 추가.

4. qmap('지역', zoom = 11, maptype = 'roadmap') : 지도 표현
   maptype 종류 : bw, roadmap, satellite, hybrid
   qmap('seoul', zoom = 11, source = 'stamen', maptype = 'watercolor')
   source = 'stamen' 을 이용한 maptype 설정 종류 : watercolor, toner 	: 지도의 png를 여러개 불러와서 표현시키는 방법.

5. ggmap(map)+geom_point(data=df, aes(x=LON, y=LAT), alpha=0.5, size=2, color="red")+
   geom_text(data = df, aes(x=LON, y=LAT, label=paste0(도서관명,전화번호), vjust=0, hjust=0))

   geom_point : 특정 장소 표현 
   geom_text : 지도에 text 넣기.

## reflet

- library(leaflet)

1. seoul_lonlat <- geocode("seoul") : ggmap의 geocode로 위도 경도 불러오기.
   mk <- geocode(enc2utf8('서울특별시 강남구 역삼동 테헤란로 212')) : 한글로 표현 가능
2. map0 <- leaflet() %>% setView(lng = seoul_lonlat$lon, lat = seoul_lonlat$lat, zoom = 16) %>% addTiles()  
   : 위치 정보 필수  addTiles() 를 붙여야함.
3. msg <- '<strong><a href="http://www.multicampus.co.kr" style="text-decoration:none" >멀티캠퍼스</a></strong><hr>우리가 공부하는 곳 ㅎㅎ' : html 태그로 팝업에 하이퍼링크 붙이기.
4. map2 <- leaflet() %>% setView(lng = mk$lon, lat = mk$lat, zoom = 16) %>% addTiles() %>% addCircles(lng = lan, lat = lat, color='green', popup = msg )
   : addCircles로 팝업할 원표시 구현. / 틀 : addCircles(lng = , lat = , color= , popup = ) 
   주의할 점 : addCircle의 lng와 lat는 데이터프레임 변수명으로 설정하면 읽지 못함. => 변수를 따로 설정해야함.

### Kormaps를 이용한 지도의 분포 표현

- library(Kormaps)

  map7<-leaflet(korpopmap3) %>% 
    addTiles() %>% 																			: 지도 표현
    setView(lat=37.52711, lng=126.987517, zoom=12) %>%			: 처음 지도 위치 표현
    addPolygons(stroke =FALSE,
                smoothFactor = 0.2,
                fillOpacity = .9,
                popup = mypopup,
                color = ~mypalette(mymap$일인가구)) %>% 					: 동마다의 다각형 경계선 표현
    addLegend( values = ~mymap$일인가구,										: 인구수의 분포에 따른 색깔 표현
               pal =mypalette ,
               title = '인구수',
               opacity = 1)

- 맵 구현 구조 :
  1. leaflet()															: 리플렛 시작
  2. setView(lng = , lat = , zoom =)                        : 지도 위치 및 zoom 설정
  3. addTiles()                                                        : 지도 구현 
     - addCircles(lng = , lat = , color = , popup = )    : 팝업 위치 및 내용, 색 설정
     - addPolygons(stroke = , smoothFactor = , fillOpacity = , popup = , color = ~ 숫자형의 데이터프레임)