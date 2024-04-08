from konlpy.tag import Okt
okt = Okt()
#형태소 분석기를 써보자!!

#정규화 예시
text = '안녕하세욬ㅋㅋㅋ 반가워요 샤릉해'
print(okt.normalize(text))

text_edit = okt.normalize(text)
print(okt.phrases(text_edit))


#어구 추출 예시
text = "장중 큰 변동 폭을 보이던 코스피가 사흘 만에 소폭 반등했다."
print(okt.phrases(text))


#형태소 분석(morphs)
#형태소를 분리만 해줌
text = '안녕하세요. 오래간만이네요~~. 어제 재미있었어요.'
print (okt.morphs(text))

#형태소 분석(Pos Tagger)
#형태소의 품사까지 리스트 안 튜플 형태로 결과가 제공됨.
#join = True를 넣을 경우 튜플없이 문자열안에 '/' 구분자로 리턴함.
text = '안녕하세요. 오래간만이네요~~. 어제 재미있었어요.'
print (okt.pos(text))
print (okt.pos(text, join = True))



#명사 추출
#데이터를 리스트로 제공받기 원한다면 nouns 기능을 호출하자!!
#명사의 경우 행동값이 포함도는 경우가 많음  ex) 공부하다 -> 공부 + 하다 -----> 명사의 의미만으로 판단가능.
text = "장중 큰 변동 폭을 보이던 코스피가 사흘 만에 소폭 반등했다."
print(okt.nouns(text))


