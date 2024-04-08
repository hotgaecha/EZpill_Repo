import pymysql
import os
import json

from decouple import config

def lambda_handler(event, context):
    # 환경 변수에서 데이터베이스 설정 읽기
    db_config = {
        "host": config('DB_HOST'),
        "user": config('DB_USER'),
        "password":config('DB_PASSWORD'),
        "database": config('DB_NAME')
    }


    # 클라이언트로부터 받은 데이터 처리
    body = json.loads(event['body'])
    firebase_uid = body['firebase_uid']
    products = body['products']

    # 데이터베이스 연결
    connection = pymysql.connect(**db_config)
    cursor = connection.cursor()

    # 제품 정보 추가
    new_product_ids = ','.join([str(p['product_id']) for p in products])
    new_titles = ','.join([p['Product_Title'] for p in products])
    new_prices = ','.join([str(p['Product_Per_Price']) for p in products])
    cursor.execute("INSERT INTO basket2 (firebase_uid, product_id, Product_Title, Product_Per_Price) VALUES (%s, %s, %s, %s)", (firebase_uid, new_product_ids, new_titles, new_prices))

    # 데이터베이스 커밋 및 연결 종료
    connection.commit()
    cursor.close()
    connection.close()

    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Basket updated successfully'})
    }
