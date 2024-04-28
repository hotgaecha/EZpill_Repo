# EZpill_Repo
# <img src = 'https://github.com/hotgaecha/EZpill/assets/100944467/0e5aee4d-be79-4f65-9fa0-1d80c9d524ff' width = '50px'> EZpill 

### EZpill은 영양제를 사용자에 맞게 조합하고, 약국에서 주는 약봉지처럼 소분합니다.
### 또한 사용자가 쉽게 영양제를 섭취할 수 있도록 정기배송해 주는 서비스입니다.
### 타깃층을 좁히기 위해 임산부에 맞게 설계되었으며, 추후에 모든 사람을 고려하여 개발될 예정입니다.

🔗 Link
- EZpill.apk 👉🏻 https://drive.google.com/file/d/15kgZZmHJlFffYjFFtgmqhTuqsAx9Pu8e/view?usp=sharing
  (서버는 TABA에서 대여 후 반납했기 때문에 일부 기능 사용 불가합니다.)
- 간단한 시연 영상 👉🏻 https://youtu.be/0BropSjA5XM?si=loT6W1mMBZjElhI8

<br>

## TEAM

| 이름 | 담당 업무 |
| --- | --- |
| 이재훈 | 백엔드, AI |
| 배기태(팀장) | 추천 알고리즘 및 DB 테이블 구성 |
| 심의진 | 프론트엔드 |
| 김해찬 | 자료조사, 프론트엔드 |
| 김보명 | 백엔드,크롤링 |

<br>

## 1. 서비스 소개
<img src = 'https://github.com/hotgaecha/EZpill/assets/100944467/d5cc561a-d6ae-40a3-8107-cfda832110de'>

### 💡 기획 배경



  

- 코로나 이후 증가하는 영양제 시장과 관심<br>
  🖇️[관련기사](https://www.sisaweek.com/news/articleView.html?idxno=203609)
- 영양제에 대해 잘 모르고 남용하거나 복용하지 않거나, 부작용이 있는 영양제를 섭취하는 경우가 아주 많음<br>
  🖇️[관련기사](https://cbiz.chosun.com/svc/bulletin/bulletin_art.html?contid=2022090200348)
- 영양제(건강기능식품)에 대한 가격적인 부담<br>
  🖇️[관련기사](https://www.thinkfood.co.kr/news/articleView.html?idxno=68778)
- 영양제에 대한 임산부들의 높은 관심과 맞춤형 영양제에 대한 기대감<br>
  🖇️[관련기사](https://m.medicaltimes.com/News/NewsView.html?ID=43830)
- 임산부의 부족한 영양 섭취<br>
  🖇️[관련기사](https://mobile.newsis.com/view.html?ar_id=NISX20170118_0014648382)
- 영양제 하나하나 챙겨 먹기 귀찮은 우리 젊은 팀원들..<br>

  <br>

### 🙋🏼 잠재 유저 인터뷰
영양제에 관심이 있는 사람 중 영양제를 복용 중인 인원 5명, 복용 중이지 않은 인원 3명을 대상으로 정성조사를 진행했습니다.
<details>

<summary> 복용중인 인원 </summary>

### 질문 리스트

1. 영양제를 복용하기 시작한 계기가 무엇인가요?

2. 영양제 구매할 때 어떤 경로로 구입하셨나요?

3. 지금 먹고 있는 영양제 종류가 무엇인가요?

4. 영양제를 선택하실 때 어떤 정보를 가장 중요하게 생각하시나요? (예: 성분, 가격, 브랜드, 리뷰 등)

5. 혹시 여러 개의 영양제를 먹는 것에 대한 우려나 걱정이 있었던 적이 있나요?

6. 영양제 소분 서비스에 대해서 긍정적인 생각을 가지고 있나요?

7. 추천 서비스를 이용할 때 가장 중요하게 생각하는 기능은 무엇인가요?

8. 준비하고 있는 서비스가 출시가 된다면 사용할 의향이 있으신가요?

### 답변 요약

1.  가격이 부담스러워요
2.  부작용 걱정은 있지만 그냐 복용 중이에요
3.  그런 서비스가 있다면 도움이 될 것 같아요

</details>

<details>
  <summary> 비복용중인 인원 </summary>

  ### 질문 리스트
1. 안 먹는 이유

2. 영양제에 대한 정보가 충분하신 가요?

3. 평소에 건강관리를 하는지?

4. 특정 영양소가 부족하다고 느낀 적이 있나요? 있다면, 어떻게 해결하고 계신 가요?

5. 추후에 영양제가 필요하다면 먹을 생각이 있나요?

6. 영양제 소분 서비스에 대한 어떤 기대와 우려가 있나요?

7. 준비하고 있는 서비스가 출시가 된다면 사용할 의향이 있으신 가요?

### 답변 요약
1. 영양제 종류가 너무 많아서 손댈 엄두가 안 나요

2. 믿을만한 제품인지 의심돼요

3. 가격만 괜찮으면 한 번 써보고 싶어요

</details>


<br>

## 2. 목적 및 필요성
### 🎯 기존 서비스에 대한 분석
<img src= 'https://github.com/hotgaecha/EZpill/assets/100944467/0bd71d76-15f5-4690-a073-f2aa6fb01f1a'>


우리 프로젝트는 위 3가지 기존 서비스에서 단점을 보완하고 장점만을 흡수한 아키텍처를 고안했습니다.

<br>

### 🔑 주요 키워드



###   1. 가격
<img src = 'https://github.com/hotgaecha/EZpill/assets/100944467/5603f185-2b4c-4f53-80b3-f80bd6dff0f2'>

러프하게 계산했을 때 경쟁사 대비 가격적인 우위를 가져갈 수 있을 것으로 예상됩니다.
영양성분 함량에서 대부분 경쟁사 보다 높은 함량을 제공하며, 과다 섭취 시 부작용이 있는 영양성분의 경우 제한적으로 제공합니다.
사용자의 편의를 위해 한 봉지에 모든 영양제를 소분할 것인지, 아침/점심/저녁 따로 소분할 것인지 선택지 제공합니다.
<br>


###   2. 리뷰
<img src = 'https://github.com/hotgaecha/EZpill/assets/100944467/b6876b0f-6928-4a54-85fb-64874249a9d3'>

자체 개발한 영양제를 사용하여 리뷰가 거의 없고 효과를 입증할 수 없는 경쟁사와 달리,<br>
세계적으로 인지도가 있는 '아이허브'에 등록되어 있는 물건을 소분 배송하며, 그에 따라 수많은 리뷰가 신뢰성을 높입니다.


## 3. 서비스 기능

---


<img src= 'https://github.com/hotgaecha/EZpill/assets/100944467/199da052-fbc2-4afb-9335-aaeffb767023'>

### 1. 메인 기능 ( 영양제 조합 추천 )
 ( gif 만들어서 넣을 자리) <br>
 사용자의 설문을 기반으로 영양제 추천 알고리즘을 통해 맞춤 영양제 조합을 제공합니다.
 조합과 함께 얼만큼의 영양성분을 섭취할 수 있게 되는지와, 정기 배송의 기간에 대한 선택지를 제공합니다.

### 2. 서브 기능 ( AI 챗봇 고민 상담 )
  (gif 만들어서 넣을 자리) <br>
  랭체인(LangChain) 기술을 활용하여 논문을 다수 학습시킨 AI가 사용자의 질문에 답변합니다.
  답변에서 추천하는 영양제에 대한 카테고리 바로가기를 제공합니다.

### 3. 부가 기능 ( 주변 제휴 약국 찾기 )
  (gif 만들어서 넣을 자리)
  구현 예정으로, 약국과 제휴하여 약사에게 고객에 대한 정보, 설문 리스트, 추천 영양제 조합을 제공하며 수수료를 받는 수익 모델입니다.
  인터넷으로 영양제를 구매하는데 거부감이 있는 유저를 위한 부가 기능입니다.

___


## 4. 기술 스택

-   Server
    -   `AWS(EC2,Lambda)`
-   Back
    -   `Django`,`python`
-   Front
    -   `Flutter`
-   DB
    -   `AWS RDS(Mysql)`
 
## 5. 프로젝트 설계


<details>
  <summary> Server </summary> 
  
  ### 설명
      설명
</details>


<details>
  <summary> Back </summary> 
  
  ### 크롤링
      모든 제품은 아이허브에 등록된 제품으로 제품에 대한 정보를 주기적으로 크롤링하여 상품에 반영합니다.
      크롤링은 파이썬의 '셀리니움' 라이브러리를 사용합니다.
</details>

<details>
  <summary> Front </summary> 
  
  ### 설명
      설명
</details>

<details>
  <summary> DB </summary> 
  
  ### 설명
      설명
</details>

<br>


### 아키텍쳐
<img width="1002" alt="image" src="https://github.com/hotgaecha/EZpill/assets/100944467/50b27381-64da-4f1a-98e3-84d1bcff7681">

<br>



### 유저 플로우
<img width="948" alt="image" src="https://github.com/hotgaecha/EZpill/assets/100944467/2c190ae9-d3a6-4339-992e-cdf69d05aed4">
