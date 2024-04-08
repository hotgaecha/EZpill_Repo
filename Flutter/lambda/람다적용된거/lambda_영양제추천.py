import json
import mysql.connector
from datetime import datetime
import os
import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG)



class Recommendation:
    def __init__(self, firebase_uid, name, birth_date, height, weight, pregnancy_week, supplements, medications, allergies, chronic_diseases, health_concerns, investment, created_at, result):
        self.firebase_uid = firebase_uid
        self.name = name
        self.birth_date = birth_date
        self.height = height
        self.weight = weight
        self.pregnancy_week = pregnancy_week
        self.supplements = supplements.split(', ') if supplements else []
        self.medications = medications.split(', ') if medications else []
        self.allergies = allergies.split(', ') if allergies else []
        self.chronic_diseases = chronic_diseases.split(', ') if chronic_diseases else []
        self.health_concerns = health_concerns.split(', ') if health_concerns else []
        self.investment = investment
        self.created_at = created_at
        self.result = result

        # 나이 및 BMI 계산 (옵션에 따라 필요한 경우에만 추가)
        self.age = self.calculate_age(birth_date)
        self.bmi = self.calculate_bmi(height, weight)

    # 나이 계산 메서드 (옵션)
    def calculate_age(self, birth_date):
        today = datetime.today()
        return today.year - birth_date.year - ((today.month, today.day) < (birth_date.month, birth_date.day))

    # BMI 계산 메서드 (옵션)
    def calculate_bmi(self, height, weight):
        if height > 0:
            return weight / ((height / 100) ** 2)
        return 0



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
    # 건강 고민에 따른 영양제 추천
        if "장 건강" in self.health_concerns:
            pill_list.append("유산균") # 장 건강을 위한 유산균 추천

        if "근육 경련" in self.health_concerns:
            pill_list.append("마그네슘") # 근육 경련을 위한 마그네슘 추천

        if "눈 건강" in self.health_concerns:
            pill_list.append("루테인") # 눈 건강을 위한 루테인 추천

        if "피부" in self.health_concerns:
            pill_list.append("콜라겐") # 피부 건강을 위한 콜라겐 추천

        if "피로감" in self.health_concerns:
            pill_list.append("비타민 B") # 피로감 해소를 위한 비타민 B 추천



        # 복용 중인 영양제 처리
        if self.supplements:
            if "엽산" in self.supplements:
                pill_list.append("엽산")
            if "비타민 D" in self.supplements:
                pill_list.append("비타민 D")
            if "오메가-3" in self.supplements:
                pill_list.append("오메가-3")
            if "철분" in self.supplements:
                pill_list.append("철분")
            if "칼슘" in self.supplements:
                pill_list.append("칼슘")
            if "마그네슘" in self.supplements:
                pill_list.append("마그네슘")

    # 중복 제거
        pill_list = list(set(pill_list))

        # 4. 복용 중인 약 처리
        if self.medications is not None:
            if "혈액 희석제" in self.medications:
                try:
                    pill_list.remove("오메가-3")
                except ValueError:
                    pass
            if "항경련제" in self.medications:
                try:
                    pill_list.remove("엽산")
                except ValueError:
                    pass
            if "항생제" in self.medications:
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
            if "디곡신" in self.medications:
                try:
                    pill_list.remove("비타민 D")
                except ValueError:
                    pass
            if "비스포스포네이트" in self.medications:
                try:
                    pill_list.remove("칼슘")
                except ValueError:
                    pass

            if "이뇨제" in self.medications:
                try:
                    pill_list.remove("마그네슘")
                except ValueError:
                    pass
            if "골다공증 치료제" in self.medications:
                try:
                    pill_list.remove("마그네슘")
                except ValueError:
                    pass
            if "비타민 D" in self.medications and "칼슘" in self.medications:
                print("비타민 D와 칼슘을 같이 섭취할 경우 권장 섭취량에 주의하세요")


        # 알러지 처리
        if "오메가-3" in pill_list and "어류" in self.allergies:
            try:
                pill_list.remove("오메가-3")
            except ValueError:
                pass
        if "유산균" in pill_list and "유제품" in self.allergies:
            try:
                pill_list.remove("유산균")
            except ValueError:
                pass
        if "콜라겐" in pill_list and "콜라겐" in self.allergies:
            try:
                pill_list.remove("콜라겐")
            except ValueError:
                pass
        if "루테인" in pill_list and "루테인" in self.allergies:
            try:
                pill_list.remove("루테인")
            except ValueError:
                pass
        # 만성질환 처리
        if "당뇨" in self.chronic_diseases:
            try:
                pill_list.remove("오메가-3")
            except ValueError:
                pass
        if "고혈압" in self.chronic_diseases:
            try:
                pill_list.remove("비타민 D")
            except ValueError:
                pass
            try:
                pill_list.remove("칼슘")
            except ValueError:
                pass
        if "심장병" in self.chronic_diseases:
            try:
                pill_list.remove("오메가-3")
            except ValueError:
                pass
        if "간경화" in self.chronic_diseases:
            try:
                pill_list.remove("철분")
            except ValueError:
                pass
        if "류마티스 관절염" in self.chronic_diseases:
            try:
                pill_list.remove("철분")
            except ValueError:
                pass
        if "비만" in self.chronic_diseases:
            try:
                pill_list.remove("비타민 D")
            except ValueError:
                pass


        return pill_list
    def save_recommendation_to_database(self, result):
        # 환경 변수에서 데이터베이스 설정 읽기
        db_config = {
            "host": os.environ.get('DB_HOST', 'database-4.cluster-cniyjmhourjo.ap-northeast-2.rds.amazonaws.com'),
            "user": os.environ.get('DB_USER', 'jaehoon'),
            "password": os.environ.get('DB_PASSWORD', '3346639a'),
            "database": os.environ.get('DB_NAME', 'django1')
        }
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()

        update_query = "UPDATE SurveyResponses SET result = %s WHERE firebase_uid = %s"
        cursor.execute(update_query, (', '.join(result), self.firebase_uid))

        conn.commit()
        cursor.close()
        conn.close()
def lambda_handler(event, context):
    # Log the received event
    logging.debug(f"Received event: {event}")

    # Check if event['body'] is not None and is a valid JSON string
    if event.get('body') is None:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Missing or invalid input'})
        }

    try:
        body = json.loads(event['body'])
    except json.JSONDecodeError:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'Invalid JSON format in body'})
        }

    firebase_uid = body.get('firebase_uid')
    if not firebase_uid:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'firebase_uid not provided'})
        }

    # Environment variable configuration with default values
    db_config = {
        "host": os.environ.get('DB_HOST', 'database-4.cluster-cniyjmhourjo.ap-northeast-2.rds.amazonaws.com'),
        "user": os.environ.get('DB_USER', 'jaehoon'),
        "password": os.environ.get('DB_PASSWORD', '3346639a'),
        "database": os.environ.get('DB_NAME', 'django1')
    }

    # Database connection
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    # Fetch survey data using the firebase_uid
    query = "SELECT * FROM SurveyResponses WHERE firebase_uid = %s"
    cursor.execute(query, (firebase_uid,))
    survey_data = cursor.fetchone()

    if survey_data:
        survey_instance = Recommendation(*survey_data)
        result = survey_instance.make_recommend_combination()
        survey_instance.save_recommendation_to_database(result)

        # Return user name and result
        return {
            'statusCode': 200,
            'body': json.dumps({'name': survey_instance.name, 'result': ', '.join(result)})
        }
    else:
        # Handle user not found scenario
        logging.error(f"User with firebase_uid {firebase_uid} not found")
        return {
            'statusCode': 404,
            'body': json.dumps({'error': 'User not found'})
        }
