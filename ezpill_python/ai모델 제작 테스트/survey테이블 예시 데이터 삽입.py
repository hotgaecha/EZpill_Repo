import mysql.connector
import random


def choose_one_of_three():
    numbers = [1500, 2500, 4500]
    chosen_number = random.choice(numbers)
    return chosen_number

# MySQL 연결 설정
conn = mysql.connector.connect(
    host="qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
    user="BAEKI",
    password="qoqorlxo1!",
    database="Ezpill"
)

# 커서 생성
cursor = conn.cursor()
sql_query = """
    INSERT INTO survey (pk_survey_id, user_id, preg_weak, age, bmi, medication, sea_food_allergy, probiotic_allergy, 
    diabetes, `High blood pressure`, `heart disease`, `liver cirrhosis`, `rheumatoid arthritis`, obesity, 
    digestive_issues, muscle_twitching, eye_fatigue, skin_condition, feel_down, pill_preference, budget)
    SELECT pk_user_id, pk_user_id, 12, 30, 25, '비타민 C', 'No', 'Yes', 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, '상관없음', {0}
    FROM user WHERE pk_user_id = 1
    UNION ALL
    SELECT pk_user_id, pk_user_id, 8, 28, 22, NULL, 'Yes', 'No', 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, '알약', {1}
    FROM user WHERE pk_user_id = 2
    UNION ALL
    SELECT pk_user_id, pk_user_id, 10, 35, 28, '비타민 C', 'No', 'No', 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, '액상', {2}
    FROM user WHERE pk_user_id = 3
    UNION ALL
    SELECT pk_user_id, pk_user_id, 6, 32, 26, NULL, 'Yes', 'Yes', 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, '알약', {3}
    FROM user WHERE pk_user_id = 4
    UNION ALL
    SELECT pk_user_id, pk_user_id, 15, 40, 30, '비타민 C', 'No', 'No', 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 0, '액상', {4}
    FROM user WHERE pk_user_id = 5
    UNION ALL
    SELECT pk_user_id, pk_user_id, 9, 25, 21, '비타민 C', 'No', 'Yes', 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, '상관없음', {5}
    FROM user WHERE pk_user_id = 6
    UNION ALL
    SELECT pk_user_id, pk_user_id, 11, 38, 29, NULL, 'Yes', 'No', 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, '상관없음', {6}
    FROM user WHERE pk_user_id = 7
    UNION ALL
    SELECT pk_user_id, pk_user_id, 7, 27, 23, '비타민 C', 'No', 'No', 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, '액상', {7}
    FROM user WHERE pk_user_id = 8
    UNION ALL
    SELECT pk_user_id, pk_user_id, 13, 42, 32, NULL, 'Yes', 'Yes', 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, '액상', {8}
    FROM user WHERE pk_user_id = 9
    UNION ALL
    SELECT pk_user_id, pk_user_id, 10, 33, 27, '비타민 C', 'No', 'No', 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, '알약', {9}
    FROM user WHERE pk_user_id = 10;
""".format(*[choose_one_of_three() for _ in range(10)])
# 예제 쿼리 실행
cursor.execute(sql_query)
conn.commit()

# 결과 가져오기
results = cursor.fetchall()
for row in results:
    print(row)

# 연결 및 커서 닫기
cursor.close()
conn.close()
