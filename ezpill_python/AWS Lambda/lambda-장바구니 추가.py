import json
import pymysql

from decouple import config


def lambda_handler(event, context):
    # 데이터베이스 설정
    db_config = {
        "host": config('DB_HOST'),
        "user": config('DB_USER'),
        "password":config('DB_PASSWORD'),
        "database": config('DB_NAME')
    }

    # 데이터베이스 연결
    connection = pymysql.connect(host=db_config['host'],
                                 user=db_config['user'],
                                 password=db_config['password'],
                                 db=db_config['database'],
                                 charset='utf8mb4',
                                 cursorclass=pymysql.cursors.DictCursor)  # DictCursor 사용

    try:
        with connection.cursor() as cursor:
            # event 객체에서 body 추출 및 JSON 파싱
            body = json.loads(event['body'])
            firebase_uid = body['firebase_uid']
            new_product_id = body['product_id']
            new_product_title = body['product_title']
            new_product_per_price = body['product_per_price']

            # 기존 레코드를 가져오는 쿼리 실행
            cursor.execute("""
                SELECT product_id, Product_Title, Product_Per_Price
                FROM basket2
                WHERE firebase_uid = %s
                ORDER BY created_at DESC
                LIMIT 1
            """, (firebase_uid,))
            result = cursor.fetchone()
            
            # 기존 값에 새로운 값을 추가하는 로직
            if result:
                # Ensure new_product_id is converted to string before concatenation
                updated_product_id = result['product_id'] + ',' + str(new_product_id)
                updated_product_title = result['Product_Title'] + ',' + new_product_title
                updated_product_per_price = result['Product_Per_Price'] + ',' + str(new_product_per_price)
            else:
                # 기존 레코드가 없는 경우, 새로운 값만 사용
                updated_product_id = str(new_product_id)  # Convert to string here as well
                updated_product_title = new_product_title
                updated_product_per_price = str(new_product_per_price)

            # 업데이트 쿼리 실행
            cursor.execute("""
                UPDATE basket2 
                SET product_id = %s, Product_Title = %s, Product_Per_Price = %s
                WHERE firebase_uid = %s
                ORDER BY created_at DESC
                LIMIT 1
            """, (updated_product_id, updated_product_title, updated_product_per_price, firebase_uid))

        
        # 변경사항 커밋
        connection.commit()

    finally:
        connection.close()

    return {
        'statusCode': 200,
        'body': json.dumps('Data updated successfully')
    }
