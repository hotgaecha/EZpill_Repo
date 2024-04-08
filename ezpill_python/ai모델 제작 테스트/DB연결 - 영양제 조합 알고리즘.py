import pymysql.cursors
import mysql.connector

#1. 사용자 설문을 바탕으로 영양제를 더하고 뺴기 (중복 상관없이)
#마지막에 중복제거 pill_list = pill_list(set(pill_list))

#2. 예산 내에서 조합하기 (뺄거 빼기 혹은 사용자가 추가가능)
# 이때 영양제 종류 별로 테이블에서 상위 3개의 항목만 가져와서 조합이 가능하도록 한다.



class Recommendation:
    def __init__(self, survey_id, user_id, preg_week, age, bmi, medication, sea_food_allergy, probiotic_allergy,
                 collagen_allergy, lutein_allergy, diabetes, high_blood_pressure, heart_disease, liver_cirrhosis,
                 rheumatoid_arthritis, obesity, digestive_issues, muscle_twitching, eye_fatigue, skin_condition,
                 feel_down, pill_preference, budget):
        self.survey_id = survey_id
        self.user_id = user_id
        self.preg_week = preg_week
        self.age = age
        self.bmi = bmi
        self.medication = medication
        self.sea_food_allergy = sea_food_allergy
        self.probiotic_allergy = probiotic_allergy
        self.collagen_allergy = collagen_allergy
        self.lutein_allergy = lutein_allergy
        self.diabetes = diabetes
        self.high_blood_pressure = high_blood_pressure
        self.heart_disease = heart_disease
        self.liver_cirrhosis = liver_cirrhosis
        self.rheumatoid_arthritis = rheumatoid_arthritis
        self.obesity = obesity
        self.digestive_issues = digestive_issues
        self.muscle_twitching = muscle_twitching
        self.eye_fatigue = eye_fatigue
        self.skin_condition = skin_condition
        self.feel_down = feel_down
        self.pill_preference = pill_preference
        self.budget = budget


    def make_recommend_combination(self):
        #사용자의 설문을 바탕으로 리스트에 항목들을 넣어보자
        #중복은 나중에 처리
        pill_list = []

        # 1. 임신 주차에 따른 영양제
        if 1 <= self.preg_week <= 13:
            pill_list.extend(["엽산", "비타민 D"])
        elif 14 <= self.preg_week <= 19:
            pill_list.extend(["엽산", "비타민 D", "오메가-3"])
        elif 20 <= self.preg_week:
            pill_list.extend(["엽산", "비타민 D", "오메가-3", "칼슘"])

        # 2. 나이에 따른 영양제
        if self.age <= 19:
            pill_list.extend(["엽산", "비타민 D"])
        elif 20 <= self.age <= 35:
            pill_list.extend(["마그네슘"])
        elif self.age > 35:
            pill_list.extend(["철분", "칼슘", "오메가-3"])

        # 3. BMI에 따른 영양제
        if self.bmi < 18.5:
            pill_list.extend(["칼슘", "비타민 B"])
        elif self.bmi >= 25:
            pill_list.extend(["마그네슘", "오메가-3", "비타민 D"])

        # 추가적인 조건에 따른 영양제

        # 6. 장 건강에 문제를 겪고 있나요?
        # 현재 복용 중이지 않으면서 장 건강에 문제가 있는 경우 유산균 추가
        if "유산균" not in self.medication and self.digestive_issues:
            pill_list.append("유산균")

        # 7. 근육 경련이나 떨림을 자주 경험합니까?
        # 마그네슘 추가
        if self.muscle_twitching:
            pill_list.append("마그네슘")

        # 8. 눈이 자주 피로하거나 붉어지나요?
        # 루테인 추가
        if self.eye_fatigue:
            pill_list.append("루테인")

        # 9. 피부의 수분감이나 탄력이 떨어짐을 느끼나요?
        # 콜라겐을 추가
        if self.skin_condition:
            pill_list.append("콜라겐")

        # 10. 몸에 기운이 없거나 신진대사가 떨어짐을 느끼나요?
        if self.feel_down:
            pill_list.append("비타민 B")

        # 11. 선호하는 알약 제형
        if self.pill_preference == "상관없음":
            pass  # 아무 제약이나 사용 가능
        elif self.pill_preference == "캡슐":
            pill_list = [pill + " 캡슐" for pill in pill_list]
        elif self.pill_preference == "액상":
            pill_list = [pill + " 액상" for pill in pill_list]

        # 11.예산 내에서 최대한 다양한 영양제 선택

        # 나머지 코드는 동일합니다.
            # 4. 평소 드시는 약?
            # 먹고 있다면 그대로 넣어주자
            # 복용중인 영양제와 같이 먹으면 안되는 영양제는 추천리스트에서 빼자.
            # 1 혈액 희석제 -> 오메가3(-)
            # 2 항경련제 -> 엽산(-)
            # 3 항생제(테트라사이클린, 퀴놀론) -> 철분(-), 칼슘(-)
            # 4 디곡신 -> 비타민 D(-)
            # 5 비스포스포네이트 -> 칼슘(-)
            # 6 항생제 -> 유산균(-), 마그네슘(-리)
            # 7 이뇨제, 골다공증 치료제 -> 마그네슘(-)
            if "엽산" in self.medication:
                pill_list.append("엽산")
            elif "비타민 D" in self.medication:
                pill_list.append("비타민 D")
            elif "오메가-3" in self.medication:
                pill_list.append("오메가-3")
            elif "철분" in self.medication:
                pill_list.append("철분")
            elif "칼슘" in self.medication:
                pill_list.append("칼슘")
            elif "혈액 희석제" in self.medication:
                pill_list.remove("오메가-3")
            elif "항경련제" in self.medication:
                pill_list.remove("엽산")
            elif "항생제(테트라사이클린, 퀴놀론)" in self.medication:
                pill_list.remove("철분")
                pill_list.remove("칼슘")
            elif "디곡신" in self.medication:
                pill_list.remove("비타민 D")
            elif "비스포스포네이트" in self.medication:
                pill_list.remove("칼슘")
            elif "항생제" in self.medication:
                pill_list.remove("마그네슘")
            elif "항생제" in self.medication:
                pill_list.remove("유산균")
            elif "이뇨제" in self.medication:
                pill_list.remove("마그네슘")
            elif "골다공증 치료제" in self.medication:
                pill_list.remove("마그네슘")
            elif "비타민 D" in self.medication and "칼슘" in self.medication:
                print("비타민 D와 칼슘을 같이 섭취할 경우 권장 섭취량에 주의하세요")
            else:
                pill_list.append(self.medication)

            # 5. 알러지가 있나요?
            # 선택지는 4개
            # 1)해산물 알러지 -> 오메가 3 제외
            # 2)콜라겐 알러지 -> 콜라겐 제외
            # 3)유산균 알러지 -> 유산균 제외
            # 4)캐로티노이드 알러지 -> 루테인 제외

            if self.Sea_food_allergy:
                pill_list.remove("오메가-3")
            if self.Probiotic_allergy:
                pill_list.remove("유산균")
            if self.Collagen_allergy:
                pill_list.remove("콜라겐")
            if self.lutein_allergy:
                pill_list.remove("루테인")

            # 중복되는 항목들을 제거해주자
            pill_list = list(set(pill_list))
        return pill_list


    #DB연결
    conn = mysql.connector.connect(
        host="qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
        user="BAEKI",
        password="qoqorlxo1!",
        database="Ezpill"
    )
    cursor = conn.cursor()
    cursor.execute("select * FROM survey")
    survey_data = cursor.fetchall()

    cursor.close()
    conn.close()

    print(survey_data)

    survey_list = []
    for data in survey_data:
        recommendation_instance = Recommendation(*data)
        survey_list.append(recommendation_instance)

    # make_recommend_combination 메서드 호출
    for survey_instance in survey_list:
        result = survey_instance.make_recommend_combination()
        print(f"User ID {survey_instance.user_id}: {result}")

# def print_pill_list(pill_list):
   #      for pill in pill_list:
   #          cost = #pill_list에 들어있는 약들의 product)id를 통해 cost를 알아주자,
   #          print(f"{pill}: ${cost}")




