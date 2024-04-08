import mysql.connector


from decouple import config


class Recommendation:
    def __init__(self, survey_id, user_id, pregnancy_week, age, bmi, medication, sea_food_allergy, probiotic_allergy,
                 collagen_allergy, lutein_allergy, diabetes, high_blood_pressure, heart_disease, liver_cirrhosis,
                 rheumatoid_arthritis, obesity, digestive_issues, muscle_twitching, eye_fatigue, skin_condition,
                 feel_down,  budget,result):
        self.survey_id = survey_id
        self.user_id = user_id
        self.pregnancy_week = pregnancy_week
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
        self.budget = budget
        self.result = result

    def make_recommend_combination(self):
        pill_list = []

        # 1. 임신 주차에 따른 영양제
        if 1 <= self.pregnancy_week <= 13:
            pill_list.extend(["엽산", "비타민 D"])
        elif 14 <= self.pregnancy_week <= 19:
            pill_list.extend(["엽산", "비타민 D", "오메가-3"])
        elif 20 <= self.pregnancy_week:
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
        if self.medication is not None and self.digestive_issues is not None:
            if "유산균" not in self.medication and self.digestive_issues:
                pill_list.append("유산균")

        if self.muscle_twitching:
            pill_list.append("마그네슘")

        if self.eye_fatigue:
            pill_list.append("루테인")

        if self.skin_condition:
            pill_list.append("콜라겐")

        if self.feel_down:
            pill_list.append("비타민 B")


        # 4. 복용 중인 영양제 처리
        if self.medication is not None:
            if "엽산" in self.medication:
                pill_list.append("엽산")
            if "비타민 D" in self.medication:
                pill_list.append("비타민 D")
            if "오메가-3" in self.medication:
                pill_list.append("오메가-3")
            if "철분" in self.medication:
                pill_list.append("철분")
            if "칼슘" in self.medication:
                pill_list.append("칼슘")
            if "마그네슘" in self.medication:
                pill_list.append("마그네슘")

        # 중복 제거
        pill_list = list(set(pill_list))

        # 4. 복용 중인 약 처리
        if self.medication is not None:
            if "혈액 희석제" in self.medication:
                try:
                    pill_list.remove("오메가-3")
                except ValueError:
                    pass
            if "항경련제" in self.medication:
                try:
                    pill_list.remove("엽산")
                except ValueError:
                    pass
            if "항생제" in self.medication:
                try:
                    pill_list.remove("철분")
                except ValueError:
                    pass
                try:
                    pill_list.remove("칼슘")
                except ValueError:
                    pass
                try:
                    pill_list.remove("유산균")
                except ValueError:
                    pass
                try:
                    pill_list.remove("마그네슘")
                except ValueError:
                    pass
            if "디곡신" in self.medication:
                try:
                    pill_list.remove("비타민 D")
                except ValueError:
                    pass
            if "비스포스포네이트" in self.medication:
                try:
                    pill_list.remove("칼슘")
                except ValueError:
                    pass

            if "이뇨제" in self.medication:
                try:
                    pill_list.remove("마그네슘")
                except ValueError:
                    pass
            if "골다공증 치료제" in self.medication:
                try:
                    pill_list.remove("마그네슘")
                except ValueError:
                    pass
            if "비타민 D" in self.medication and "칼슘" in self.medication:
                print("비타민 D와 칼슘을 같이 섭취할 경우 권장 섭취량에 주의하세요")


        # 5. 알러지 처리
        if "오메가-3" in pill_list and self.sea_food_allergy:
            try:
                pill_list.remove("오메가-3")
            except ValueError:
                pass
        if "유산균" in pill_list and self.probiotic_allergy:
            try:
                pill_list.remove("유산균")
            except ValueError:
                pass
        if "콜라겐" in pill_list and self.collagen_allergy:
            try:
                pill_list.remove("콜라겐")
            except ValueError:
                pass
        if "루테인" in pill_list and self.lutein_allergy:
            try:
                pill_list.remove("루테인")
            except ValueError:
                pass

        #6. 만성질환 처리
        if self.diabetes == 1:
            try:
                pill_list.remove("오메가-3")
            except ValueError:
                pass
        if self.high_blood_pressure == 1:
            try:
                pill_list.remove("비타민 D")
            except ValueError:
                pass
            try:
                pill_list.remove("칼슘")
            except ValueError:
                pass
        if self.heart_disease == 1:
            try:
                pill_list.remove("오메가-3")
            except ValueError:
                pass
        if self.liver_cirrhosis == 1:
            try:
                pill_list.remove("철분")
            except ValueError:
                pass
        if self.rheumatoid_arthritis == 1:
            try:
                pill_list.remove("철분")
            except ValueError:
                pass
        if self.obesity == 1:
            try:
                pill_list.remove("비타민 D")
            except ValueError:
                pass



        return pill_list

    @staticmethod
    def get_survey_data():
        # 데이터베이스 연결 정보
        db_config = {
            "host": "qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
            "user": "BAEKI",
            "password": "qoqorlxo1!",
            "database": "Ezpill"
        }

        # 데이터베이스 연결
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # 설문 데이터 조회
        cursor.execute("SELECT * FROM survey")
        survey_data = cursor.fetchall()

        # 연결 종료
        cursor.close()
        conn.close()

        return survey_data

    def save_recommendation_to_database(self, result):
        # 데이터베이스 연결 정보
        db_config = {
            "host": config('DB_HOST'),
            "user": config('DB_USER'),
            "password": config('DB_PASSWORD'),
            "database": config('DB_NAME')
        }

        # 데이터베이스 연결
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        # 결과 값을 데이터베이스에 업데이트
        update_query = "UPDATE survey SET result = %s WHERE survey_id = %s"
        cursor.execute(update_query, (', '.join(result), self.survey_id))

        # 변경사항을 커밋
        conn.commit()

        # 연결 종료
        cursor.close()
        conn.close()


if __name__ == "__main__":
    # 설문 데이터 가져오기
    survey_data = Recommendation.get_survey_data()


    # Recommendation 인스턴스 생성 및 결과 출력
    survey_list = [Recommendation(*data[:-1], data[-1]) for data in survey_data]
    for survey_instance in survey_list:
        result = survey_instance.make_recommend_combination()
        print(f"User ID {survey_instance.user_id}: {result}")


        # 결과를 데이터베이스에 저장
        survey_instance.save_recommendation_to_database(result)