from itertools import product
import json
import mysql.connector
from datetime import datetime
import os
import logging
import pymysql


# 데이터베이스 연결 정보 설정
db_config = {
    "host": "database-4.cluster-cniyjmhourjo.ap-northeast-2.rds.amazonaws.com",
    "user": "jaehoon",
    "password": "3346639a",
    "database": "django1"
}
firebase_uid = "kakao:3162463219"
# ...

try:
    # MySQL 연결
    connection = pymysql.connect(**db_config)
    cursor = connection.cursor()

    query = f"""
        SELECT result
        FROM SurveyResponses
        WHERE firebase_uid = '{firebase_uid}'
    """
    cursor.execute(query)
    result = cursor.fetchall()
    # cursor.close()
    # connection.close()

    # 결과 출력
    # for row in result:
    #     print(row[0])

except pymysql.Error as e:
    print(f"Error: {e}")

finally:
    pass

# print(result)
#원래 result의 형태는 튜플이기 때문에 다른 리스트를 만들어 보여주자..

replacement_map = {'칼슘': 'calcium', '콜라겐': 'collagen', '엽산': 'folic_acid', '철분': 'iron',
                   '루테인': 'lutein', '마그네슘': 'magnesium', '오메가-3': 'omega_3', '유산균': 'probiotic',
                   '비타민 B': 'Vitamin_B', '비타민 D': 'Vitamin_D'}

# 수정된 결과를 저장할 리스트
modified_result = []

for row in result:
    for element in row:
        for key, value in replacement_map.items():
            element = element.replace(key, value)
        # 쉼표로 문자열을 쪼개어 리스트로 변환
        modified_result.extend(element.split())

# 수정된 결과 출력
print(modified_result)


#각 테이블명에 맞게 이름 수정.
#이제부터 테이블 이름들은 tables
tables = []

for i in modified_result:
    tables.append(f"product_{i}")

# print(tables)
# print(len(tables))
# 각 테이블에서 상위 3개의 제품을 가져오는 쿼리 예시

top_n = 3

result = []

#문자 뒤에 이상하게 쉼표가 붙어 나와서 한참 헤맸다...
# .rstrip(',')을 붙여주면 깔끔하게 나옴
for i in range(len(tables)):
    # print(tables[i].rstrip(','))
    query = f"""
        SELECT Product_Title, Product_Per_Price
        FROM {tables[i].rstrip(',')}
        LIMIT 3
    """
    cursor.execute(query)
    result.append(cursor.fetchall())
print(result)
print()
#리스트에 종류별로 3개씩 묶어 저장됨.


#사용자가 정한 예산 범위

query = f"""
    SELECT investment
    FROM SurveyResponses
    WHERE firebase_uid = '{firebase_uid}'
"""
cursor.execute(query)
investment_result = cursor.fetchall()

if investment_result:
    investment = int(investment_result[0][0])
    print(f"사용자 예산 : {investment}")
else:
    print("해당 firebase_uid의 투자 정보를 찾을 수 없습니다.")
def parse_price(price_str):
    # 쉼표 제거 및 숫자로 변환
    return int(price_str.replace(',', ''))

#품목별로 최저가 찾아서 조합하기



def min_cost_combination():
    global min_list, min_list_with_name, sum_of_cost

    min_list = []
    min_list_with_name = []
    sum_of_cost = 0


    for i in range(len(result)):
        min_val = float('inf')  # 무한대로 초기화
        min_item = None  # 최소 비용을 가지고 있는 아이템 초기화

        for j in range(len(result[i])):
            current_cost = int(str(result[i][j][1]).replace(',', ''))  # 콤마 제거 후 정수로 변환

            if current_cost < min_val:
                min_val = current_cost
                min_item = result[i][j]

        min_list.append(min_val)
        min_list_with_name.append(min_item)

    print("각 종류별로 top3를 뽑은 것 중 최소 비용 조합")
    print(f"min_list: {min_list}")
    print(f"min_list_with_name: {min_list_with_name}")
    sum_of_cost = sum(min_list)
    print(f"sum_of_cost: {sum_of_cost}")

min_cost_combination()
print()


def cost_up():
    global sum_of_cost, cost_up_list,cost_up_list_with_name

    cost_up_list = []
    cost_up_list_with_name = []

    #여기서 포인터의 개념이라는걸 망각하고 계속 원래의 값을 불러올때 min_list를 사용했음. 그러면 안된다...
    cost_up_list = min_list


    for i in range(len(result)):
        max = min_list[i]
        max_item = min_list_with_name[i]

        for j in range(len(result[i])):
            temp = cost_up_list[i]

            if int(str(result[i][j][1]).replace(',', '')) > max:
                max = int(str(result[i][j][1]).replace(',', ''))
                cost_up_list[i]=max
                if sum(cost_up_list) < investment:
                    max_item = result[i][j]

            if sum(cost_up_list) > investment:
                cost_up_list[i] = temp


        cost_up_list_with_name.append(max_item)

    sum_of_cost = sum(cost_up_list)
    print("예산이 남을때 더 비싼 제품 골라주기")
    print(f"cost_up_list : {cost_up_list}")
    print(f"new_sum_of_cost : {sum_of_cost}")
    print(f"cost_up_list_with_name :{cost_up_list_with_name}")







cost_up()
#   if sum_of_cost < investment:
        #def cost_up()








# 가능한 모든 조합을 찾기
# valid_combinations = [list(range(min_price, investment + 1)) for min_price in min_prices.values() if min_price <= investment]
# possible_combinations = list(product(*valid_combinations))
#
# # 가능한 모든 조합 중에서 최저가 찾기
# min_total_price = float('inf')  # 초기값을 무한대로 설정
# best_combination = None
#
# for combination in possible_combinations:
#     total_price = sum(combination)
#     if total_price <= investment and total_price < min_total_price:
#         min_total_price = total_price
#         best_combination = combination
#
#
# # 최저가 조합 출력
# print(f"가능한 모든 조합 중 최저가: {best_combination}, 총 가격: {min_total_price}")
# #
# for table in tables:
#     table_name = table.rstrip(',')
#     query = f"""
#         SELECT Product_Title, Product_Per_Price
#         FROM {table_name}
#         ORDER BY Product_Per_Price
#         LIMIT 1
#     """
#
#     cursor.execute(query)
#     result = cursor.fetchone()
#
#     if result:
#         product_title, product_per_price = result
#         # Product_Per_Price를 숫자로 변환
#         product_per_price = parse_price(str(product_per_price))  # 숫자로 변환하기 전에 문자열로 변환
#         selected_products[table_name] = {'Product_Title': product_title, 'Product_Per_Price': product_per_price}
#
#






# # 예산 설정
# query = f"""
#     SELECT budget
#     FROM survey
#     WHERE user_id = {user_id}
# """
# cursor.execute(query)
# budget = cursor.fetchall()
# print(budget)
#
#
# # 각 테이블에서 하나씩 선택하여 조합 생성
# print(result)
# all_combinations = list(itertools.product(*result))
# print(all_combinations)



# # 최소 가격의 조합 찾기
# min_price_combination = None
# min_price = float('inf')  # Set initial min_price to positive infinity for comparison
#
# for combination in all_combinations:
#     total_price = sum(int(product[1]) if isinstance(product[1], str) else product[1] for product in combination)
#     if total_price <= budget and total_price < min_price:
#         min_price_combination = combination
#         min_price = total_price
# # 최대 가격의 조합 출력
# print("최소 가격의 조합:", min_price_combination)
# print("최소 가격:", min_price)

# 연결 닫기
cursor.close()
connection.close()
