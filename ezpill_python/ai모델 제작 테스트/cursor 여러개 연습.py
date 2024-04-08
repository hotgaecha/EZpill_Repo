import pymysql
# MySQL 연결 정보 설정
db_config = {
    "host": "qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
    "user": "BAEKI",
    "password": "qoqorlxo1!",
    "database": "Ezpill"
}
# MySQL 연결
connection = pymysql.connect(**db_config)
cursor = connection.cursor()

query = f"""
    SELECT result
    FROM survey
"""
cursor.execute(query)
result = cursor.fetchall()
print(result)

query = f"""
    SELECT result
    FROM survey
"""
cursor.execute(query)
result = cursor.fetchall()
print(result)