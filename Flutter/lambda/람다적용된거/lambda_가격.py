import json
import pymysql
import os

def lambda_handler(event, context):
    # 환경 변수에서 데이터베이스 설정 읽기
    db_config = {
        "host": "database-4.cluster-cniyjmhourjo.ap-northeast-2.rds.amazonaws.com",
        "user": "jaehoon",
        "password": "3346639a",
        "database": "django1"
    }

    # 로그로 이벤트와 컨텍스트 출력
    print("Received event: ", json.dumps(event))
    print("Context: ", context)

    # body를 JSON으로 파싱
    body = event.get('body', '{}')
    if body:
        try:
            body = json.loads(body)
        except json.JSONDecodeError:
            return {
                'statusCode': 400,
                'body': json.dumps({'error': 'Invalid JSON format'})
            }
    else:
        # body가 없는 경우 적절한 처리
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'No data provided'})
        }

    # Firebase UID 추출
    firebase_uid = body.get('firebase_uid')
    print("firebase_uid: ", firebase_uid)

    if not firebase_uid:
        return {
            'statusCode': 400,
            'body': json.dumps({'error': 'firebase_uid not provided'})
        }

    connection = None
    cursor = None

    try:
        # 데이터베이스 연결 및 쿼리 수행
        connection = pymysql.connect(**db_config)
        cursor = connection.cursor()
        
        # 사용자의 결과 가져오기
        query = f"SELECT result FROM SurveyResponses WHERE firebase_uid = '{firebase_uid}'"
        cursor.execute(query)
        result = cursor.fetchall()

        # 결과 처리 로직
        if not result:
            return {
                'statusCode': 404,
                'body': json.dumps({'error': 'Result not found'})
            }

        # 결과를 수정하기 위한 매핑
        replacement_map = {'칼슘': 'calcium', '콜라겐': 'collagen', '엽산': 'folic_acid', '철분': 'iron',
                           '루테인': 'lutein', '마그네슘': 'magnesium', '오메가-3': 'omega_3', '유산균': 'probiotic',
                           '비타민 B': 'Vitamin_B', '비타민 D': 'Vitamin_D'}

        modified_result = []
        for row in result:
            for element in row:
                for key, value in replacement_map.items():
                    element = element.replace(key, value)
                modified_result.extend(element.split(','))

        # 제품 테이블 이름 생성
        tables = [f"product_{item.strip()}" for item in modified_result]

        # 각 제품 카테고리에서 상위 3개 제품의 Product_Title과 Product_Per_Price를 가져오기
        top_products_info = {}
        for table in tables:
            query = f"SELECT Product_Title, Product_Per_Price FROM {table} LIMIT 3"
            cursor.execute(query)
            top_products_info[table] = [{'Product_Title': item[0], 'Product_Per_Price': item[1]} for item in cursor.fetchall()]

        # 각 제품 정보에 해당하는 product_id 가져오기
        top_products = {}
        for category, products_info in top_products_info.items():
            top_products[category] = []
            for info in products_info:
                title = info['Product_Title']
                price = info['Product_Per_Price']
                query = f"SELECT product_id FROM product WHERE Product_Title = '{title}' AND Product_Per_Price = '{price}'"
                cursor.execute(query)
                product_id = cursor.fetchone()
                if product_id:
                    top_products[category].append({
                        'Product_Title': title,
                        'Product_Per_Price': price,
                        'product_id': product_id[0]
                    })
        # 사용자의 예산 가져오기
        query = f"SELECT investment FROM SurveyResponses WHERE firebase_uid = '{firebase_uid}'"
        cursor.execute(query)
        investment_result = cursor.fetchone()
        if not investment_result or not str(investment_result[0]).isdigit():
            return {
                'statusCode': 404,
                'body': json.dumps({'error': 'Investment information not found or invalid'})
            }

        investment = int(investment_result[0])

        # 최소 비용 조합 계산
        min_cost_combination, total_cost_min = calculate_min_cost_combination(top_products)
        # 추가 비용 포함 조합 계산
        cost_up_combination, total_cost_up = calculate_cost_up_combination(top_products, investment, min_cost_combination)

        # 결과 반환 (JSON 형식으로)
        final_result = {
            'min_cost_combination': min_cost_combination,
            'cost_up_combination': cost_up_combination
        }
        return {
            'statusCode': 200,
            'body': json.dumps(final_result)
        }

    except pymysql.Error as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

    finally:
        # cursor와 connection이 초기화되었는지 확인 후 닫기
        if cursor:
            cursor.close()
        if connection:
            connection.close()

def calculate_min_cost_combination(top_products):
    min_cost_combination = {}
    total_cost = 0

    for category, products in top_products.items():
        min_product = min(products, key=lambda x: x['Product_Per_Price'])  # 가장 저렴한 제품 선택
        min_cost_combination[category] = {
            'Product_Title': min_product['Product_Title'],
            'Product_Per_Price': min_product['Product_Per_Price'],
            'product_id': min_product['product_id']
        }
        
        # min_product['Product_Per_Price']이 문자열인 경우에만 쉼표 제거
        if isinstance(min_product['Product_Per_Price'], str):
            price_without_comma = min_product['Product_Per_Price'].replace(',', '')
        else:
            price_without_comma = min_product['Product_Per_Price']

        total_cost += int(price_without_comma)

    return min_cost_combination, total_cost

def calculate_cost_up_combination(top_products, investment, min_cost_combination):
    cost_up_combination = min_cost_combination.copy()
    
    # total_cost 계산 시 문자열의 쉼표를 제거하고 정수로 변환
    total_cost = sum(int(product['Product_Per_Price'].replace(',', '')) if isinstance(product['Product_Per_Price'], str) else product['Product_Per_Price'] for product in cost_up_combination.values())

    for category, products in top_products.items():
        if total_cost > investment:
            break

        for product in products:
            product_price = int(product['Product_Per_Price'].replace(',', '')) if isinstance(product['Product_Per_Price'], str) else product['Product_Per_Price']  # 쉼표 제거 및 정수 변환
            current_price = int(cost_up_combination[category]['Product_Per_Price'].replace(',', '')) if isinstance(cost_up_combination[category]['Product_Per_Price'], str) else cost_up_combination[category]['Product_Per_Price']

            if product_price > current_price and (total_cost - current_price + product_price) <= investment:
                total_cost = total_cost - current_price + product_price
                cost_up_combination[category] = {
                    'Product_Title': product['Product_Title'],
                    'Product_Per_Price': product_price,
                    'product_id': product['product_id']
                }

    return cost_up_combination, total_cost
