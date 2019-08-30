# 정규표현식 사용

word <- "JAVA javascript Aa 가나다 AAaAaA123 %^&*"
gsub("[^A]", "", word) #A 삭제
gsub("a", "", word) #a 삭제
gsub("Aa", "", word)  #Aa 삭제
gsub("(Aa){2}", "", word) #두번 반복일 때만 없애줌.{}쓰려면 반드시 앞에 ()를 붙여야함
gsub("[Aa]", "", word)    #대문자 A 또는 소문자 a (or)
gsub("[가-힣]", "", word)  #한글 삭제
gsub("[^가-힣]", "", word) # 한글만 남김 ^ = not
gsub("[&^%*]", "", word)  # 특수기호 대괄호 [] 이므로 or
gsub("[[:punct:]]", "", word) # 특수기호 없애기 띄어쓰기 포함 x
gsub("[[:alnum:]]", "", word) # 특수기호만 남기기
gsub("[1234567890]", "", word) #[0-9] 범위로도 가능
gsub("[[:digit:]]", "", word)  # 숫자 없애기
gsub("[^[:alnum:]]", "", word) # 띄어쓰기 및 특수기호 없애기 ^없애면 특수기호만 남음
gsub("[[:space:]]", "", word)  # 띄어쓰기 없애기
?gsub


