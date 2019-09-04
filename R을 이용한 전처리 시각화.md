# R을 이용한 수집 및 시각화



- 크롤링: 데이터를 받아옴
- 웹 스크래핑 : 받아온 데이터에서 필요한 자료를 추출하는 것.





- rvest = 데이터 크롤링하는데 도움을 주는 함수들을 제공해주는 패키지.

- rvest 라이브러리의 주요 함수

  - html_nodes(x,css,xpath) , html_node(x,css,xpath)		=> dom 객체를 찾아오는 메서드

    css : 

  - html_text(x, trim = FALSE)            // 시작태그 종료태그 사이의 컨텐츠에 블랭크가 있을시 trim= TRUE를 줌

  - html_attrs(x)                                 //  태그 속성 정보 추출 

  - html_attr(x,name,default=" ")



## Dplyr

dplyr 패키지는 파이프 기법을 사용했다.

#cat readme.txt
#cat readme.txt > output.txt #덮어쓰기
#cat readme.txt >> output.txt  # 기존에 있던 내용에 oppend 하는 것. 
#cat readme.txt | wc -l
#ls -al | more # more라는 명령어에게 ls -al 을 줌.

#v1<- 함수1()
#v2<- 함수2()
#v3<- 함수3(v2)
||
#v3<- 함수3(함수2(함수1()))

#dplyr은 이렇게.
v3<- 함수1() %>% 함수2() %>% 함수3()

ctrl + shift + m => %>% 저절로 만들어줌


%%: 나머지	%/% : 몫		%*% : 행렬 곱

