import mysql.connector

class Combination_within_budget:

    def db_query(query):
        #mysql연결
        conn = mysql.connector.connect(
         host="qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com",
         user="BAEKI",
         password="qoqorlxo1!",
         database="Ezpill")
        cursor = None
        try:
            # 커서 생성
            cursor = conn.cursor()

            # 쿼리 실행
            cursor.execute(f"{query}")

            # 결과 가져오기
            results = cursor.fetchall()

            # 결과를 변수에 할당
            prices = [row[0] for row in results]

            # 함수에서 반환
            return prices

        except Exception as e:
            # 예외 처리 코드
            print(f"An error occurred: {e}")
            return None

        finally:
            # 연결 및 커서 닫기
            cursor.close()
            conn.close()


























    print(db_query("select Product_Price from product"))
