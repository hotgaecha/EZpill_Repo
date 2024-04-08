import mysql.connector

# MySQL 연결 설정
# 'user', 'password', 'host', 'database'를 실제 사용 중인 정보로 대체
conn = mysql.connector.connect(
    user='root',
    password='qoqorlxo1!',
    host='localhost',
    database='ezpill'
)

# 커서 생성
cursor = conn.cursor()

# 간단한 SELECT 쿼리 실행 예시
query = "SELECT * FROM product;"
cursor.execute(query)

# 결과 가져오기
result = cursor.fetchall()
for row in result:
    print(row)

# 연결 종료
cursor.close()
conn.close()
