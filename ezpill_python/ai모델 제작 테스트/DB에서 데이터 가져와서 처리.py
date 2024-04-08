import mysql.connector

# MySQL 연결 설정
conn = mysql.connector.connect(
    host="qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
    user="BAEKI",
    password="qoqorlxo1!",
    database="Ezpill"
)

# 커서 생성
cursor = conn.cursor()

# 예제 쿼리 실행
cursor.execute("SELECT * FROM product")

# 결과 가져오기
results = cursor.fetchall()
for row in results:
    print(row)

# 연결 및 커서 닫기
cursor.close()
conn.close()
