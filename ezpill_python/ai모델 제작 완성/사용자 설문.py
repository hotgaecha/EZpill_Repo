import mysql.connector

def get_survey():
    # 데이터베이스 연결 정보
    db_config = {
        "host": "qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
        "user": "BAEKI",
        "password": "qoqorlxo1!",
        "database": "Ezpill"
    }
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()

    #여기서 대답에 관한 코드를 프런트와 연결할것.

    preg_week = int(input("임신 주차를 입력하세요: "))
    age = int(input("나이를 입력하세요: "))
    height = int(input("키를 입력하세요: ")) / 100
    weight = int(input("임신 전 몸무게를 입력하세요: "))
    bmi = int(weight / (height ** 2))

    #나눠줘야함 5가지 필수영야제
    medication = input("현재 복용 중인 영양제 또는 약이 있나요? (모른다면 엔터 예시 ->오메가-3, 엽산, 철분, 비타민D, 칼슘, 유산균, 마그네슘, 혈액 희석제, 항경련제, 항생제, 디곡신,비스포스포네이트,이뇨제, 골다공증 치료제  ): ")

    sea_food_allergy = int(input("해산물 알러지가 있나요? (없음:0 , 있음:1): "))
    probiotic_allergy = int(input("유산균 알러지가 있나요? (없음:0 , 있음:1): "))
    collagen_allergy = int(input("콜라겐 알러지가 있나요? (없음:0 , 있음:1): "))
    lutein_allergy = int(input("루테인 알러지가 있나요? (없음:0 , 있음:1): "))

    diabetes = int(input("당뇨가 있나요? (없음:0 , 있음:1): "))
    high_blood_pressure = int(input("고혈압이 있나요? (없음:0 , 있음:1): "))
    heart_disease = int(input("심장질환이 있나요? (없음:0 , 있음:1): "))
    liver_cirrhosis = int(input("간경화가 있나요? (없음:0 , 있음:1): "))
    rheumatoid_arthritis = int(input("휴마티스 관절염이 있나요? (없음:0 , 있음:1): "))
    obesity = int(input("비만이 있나요? (없음:0 , 있음:1): "))

    digestive_issues = int(input("장 건강에 문제가 있나요? ( 없음:0 , 있음:1): "))
    muscle_twitching = int(input("근육 경련이나 떨림을 자주 경험하나요? ( 없음:0 , 있음:1): "))
    eye_fatigue = int(input("눈이 자주 피로하거나 붉어지나요? ( 없음:0 , 있음:1): "))
    skin_condition = int(input("피부의 수분감이나 탄력이 떨어짐을 느끼나요? ( 없음:0 , 있음:1): "))
    feel_down = int(input("몸에 기운이 없거나 신진대사가 떨어짐을 느끼나요? ( 없음:0 , 있음:1): "))

    budget = int(input("하루 투자 가능 금액을 입력하세요(1000, 2000, 3000): "))

    user_id = 27  # 이 값은 프런트에서 받아와야함.
    # 설문 데이터를 DB에 저장
    cursor.execute("""
        UPDATE survey 
        SET 
            preg_week = %s,
            age = %s,
            bmi = %s,
            medication = %s,
            sea_food_allergy = %s,
            probiotic_allergy = %s,
            collagen_allergy = %s,
            lutein_allergy = %s,
            diabetes = %s,
            high_blood_pressure = %s,
            heart_disease = %s,
            liver_cirrhosis = %s,
            rheumatoid_arthritis = %s,
            obesity = %s,
            digestive_issues = %s,
            muscle_twitching = %s,
            eye_fatigue = %s,
            skin_condition = %s,
            feel_down = %s,
            budget = %s
        WHERE user_id = %s;
    """, (
        preg_week,
        age,
        bmi,
        medication,
        sea_food_allergy,
        probiotic_allergy,
        collagen_allergy,
        lutein_allergy,
        diabetes,
        high_blood_pressure,
        heart_disease,
        liver_cirrhosis,
        rheumatoid_arthritis,
        obesity,
        digestive_issues,
        muscle_twitching,
        eye_fatigue,
        skin_condition,
        feel_down,
        budget,
        user_id
    ))

    # 연결 종료
    conn.commit()
    cursor.close()
    conn.close()



get_survey()

