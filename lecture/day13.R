install.packages("readxl")
library(readxl)
ck<-read_excel("C:/Rstudy/book/치킨집_가공.xlsx")
addr<-substr(ck$소재지전체주소,11,16)
addr_num <-gsub("[0-9]","",addr)
addr_trim <-gsub(" ","",addr_num)

library(dplyr)
addr_count <- addr_trim %>% table() %>% data.frame()

install.packages("treemap")
library(treemap)
treemap(addr_count, index = "." , vSize = "Freq", title = "서대문구 동별 치킨집 분포")

arrange(addr_count, desc(Freq)) %>% head()

file<-read_excel("C:/Rstudy/book/dustdata.xlsx")
file

dustdata_anal<-file %>% filter(area %in% c("성북구","중구"))

count(dustdata_anal, yyyymmdd) %>% arrange(desc(n))
count(dustdata_anal, area) %>% arrange(desc(n))

dust_anal_area_sb <- subset(dustdata_anal, area == "성북구")
dust_anal_area_jg <- subset(dustdata_anal, area == "중구")

install.packages("psych")
library(psych)

describe(dust_anal_area_sb$finedust)
describe(dust_anal_area_jg$finedust)

#가설 검정

boxplot(dust_anal_area_sb$finedust, dust_anal_area_jg$finedust,
        main = "finedust_compare", xlab = "AREA", names = c("성북구","중구"),
        ylab = "FINEDUST_PM", col = c("blue","green"))
t.test(data = dustdata_anal, finedust ~ area, var.equal = T)

lmLine<-lm(data = dustdata_anal, finedust ~ area)

install.packages("ggplot2")
library(ggplot2)

ggplot(dustdata_anal, aes(x=yyyymmdd, y=finedust)) + geom_point()


# 지하철역 주변 아파트 가격

library(dplyr)
library(ggmap)
register_google(key='AIzaSyD-nx_y7aBlJgfgVZRaIwMbnShQJsxpryY')
# 다음 소스는 참고만 하고 10개행 밑에 있는 load() 함수만 수행시키세용
station_data <- read.csv("book/13._역별_주소_및_전화번호.csv")
str(station_data)
station_code <- as.character(station_data$"구주소")
station_code <- geocode(station_code)
station_code <- as.character(station_data$"구주소") %>% enc2utf8() %>% geocode()
head(station_code)
station_code_final <- cbind(station_data, station_code)
head(station_code_final)
save(station_code_final, file="station.rda")
load(file="station.rda")  # 이것만 수행시키세용

# 다음 소스는 참고만 하고 마지막에 있는 load() 함수만 수행시키세용
apart_data <- read.csv("book/아파트(매매)__실거래가_20180513144733.csv")
head(apart_data)
names(apart_data)
apart_data <- rename(apart_data, "거래금액" = "거래금액.만원.")
apart_data$전용면적 = round(apart_data$전용면적)
head(apart_data)
count(apart_data, 전용면적) %>% arrange(desc(n))
apart_data_85 <- subset(apart_data, 전용면적=="85")
head(apart_data_85)
apart_data_85$거래금액 <- gsub(",", "", apart_data_85$거래금액)
head(apart_data_85)
apart_data_85_cost <- aggregate(as.integer(거래금액)~단지명, apart_data_85, mean)
head(apart_data_85_cost)

apart_data_85 <- apart_data_85[!duplicated(apart_data_85$단지명),]
head(apart_data_85)
apart_data_85 <- left_join(apart_data_85, apart_data_85_cost, by='단지명')
head(apart_data_85)
apart_data_85 <- apart_data_85 %>% select("단지명", "시군구", "번지", "전용면적", "거래금액")

head(apart_data_85)
apart_address <- paste(apart_data_85$"시군구", apart_data_85$번지)
head(apart_address)
apart_address <- paste(apart_data_85$"시군구", apart_data_85$번지) %>% data.frame()
head(apart_address)
apart_address <- rename(apart_address, "주소"=".")
head(apart_address)
apart_address_code <- as.character(apart_address$"주소") %>% enc2utf8() %>% geocode()
apart_code_final <- cbind(apart_data_85, apart_address, apart_address_code) %>% select("단지명", "전용면적", "거래금액", "주소", lon, lat)
head(apart_code_final)
save(apart_code_final, file="apart.rda")
load(file="apart.rda")  # 이것만 수행시키세용

# 마포구 지도 표시
mapo_map <- get_googlemap("mapogu", maptype="roadmap", zoom=12)
ggmap(mapo_map)

# 지하철역 위치 및 아파트 가격 정보 표시
install.packages("ggplot2")
library(ggplot2)
#산점도로 위치 및 역명 표시
ggmap(mapo_map) + geom_point(data=station_code_final, aes(x=lon, y=lat),
                             colour="red", size=3) +
  geom_text(data=station_code_final, aes(label=역명, vjust=-1))

# 아파트 정보 표시. 수가 많아 홍대입구역쪽을 세밀히 표현
hongdae_map <- get_googlemap("hongdae station", maptype="roadmap", zoom=15)
ggmap(hongdae_map) + geom_point(data=station_code_final, aes(x=lon, y=lat),
                                colour="red", size=3) +
  geom_text(data=station_code_final, aes(label=역명, vjust=-1)) +
  geom_point(data=apart_code_final, aes(x=lon, y=lat)) +
  geom_text(data=apart_code_final, aes(label=단지명, vjust=-1)) +
  geom_text(data=apart_code_final, aes(label=거래금액, vjust=1))




#텍스트 마이닝
install.packages("tm")
library(tm)

lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
           "커피 우동 소고기김밥 귤",
           "참치김밥 커피 오뎅",
           "샐러드 피자 파스타 콜라",
           "티라무슈 햄버거 콜라",
           "파스타 샐러드 커피"
)

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps)
tdm

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))
# 글자가 두글자 이하인것까지 다 표현하기.

tdm
(m <- as.matrix(tdm))

rowSums(m)
colSums(m)

com <- m %*% t(m)


install.packages("tm")
library(tm)

lunch <- c("커피 파스타 치킨 샐러드 아이스크림",
           "커피 우동 소고기김밥 귤",
           "참치김밥 커피 오뎅",
           "샐러드 피자 파스타 콜라",
           "티라무슈 햄버거 콜라",
           "파스타 샐러드 커피"
)

cps <- VCorpus(VectorSource(lunch))
tdm <- TermDocumentMatrix(cps)
tdm
as.matrix(tdm)

cps <- VCorpus(VectorSource(lunch)) 
tdm <- TermDocumentMatrix(cps, 
                          control=list(wordLengths = c(1, Inf)))
tdm
(m <- as.matrix(tdm))   # 행렬로 나타냄.

rowSums(m)  
colSums(m)   #각 글자의 총 갯수를 세어줌

com <- m %*% t(m)  #글자의 총 행렬을 나타내줌.
com

install.packages("qgraph")  # 동시출현 시각화
library(qgraph)

qgraph(com, labels=rownames(com), diag=F, 
       layout='spring',  edge.color='blue', 
       vsize=log(diag(com)*800))


install.packages("proxy")
library(proxy)
dd <- NULL
d1 <- c("aaa bbb ccc")
d2 <- c("aaa bbb ddd")
d3 <- c("aaa bbb ccc")
d4 <- c("xxx yyy zzz")
dd <- c(d1, d2, d3, d4)
cps <- Corpus(VectorSource(dd))
dtm <- DocumentTermMatrix(cps)
as.matrix(dtm)
inspect(dtm)
m <- as.matrix(dtm)
colSums(m)
com <- m %*% t(m)


dist(com, method = "cosine")    # 코사인 (간격) -> 90도면 1
dist(com, method = "Euclidean")  

