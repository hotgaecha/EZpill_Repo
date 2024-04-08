import os
import requests
from PIL import Image
import mysql.connector

from decouple import config

# MySQL 연결 설정
db_config = {
    "host": config('DB_HOST'),
    "user": config('DB_USER'),
    "password": config('DB_PASSWORD'),
    "database": config('DB_NAME')
}

conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()

# MySQL에서 이미지 URL 가져오기
cursor.execute("""
SELECT Product_Title
FROM product
LIMIT 3
""")

result = cursor.fetchall()
print(result)

# # 이미지 다운로드 및 저장
# for idx, (image_url,) in enumerate(result, start=1):
#     response = requests.get(image_url)
#
#     # 이미지를 저장할 디렉토리 생성
#     directory = "/Users/baeki/Desktop/Ezpill_prac/assets"
#     if not os.path.exists(directory):
#         os.makedirs(directory)
#
#     # 이미지 저장
#     image_path = os.path.join(directory, f"{idx}.jpg")
#     with open(image_path, "wb") as f:
#         f.write(response.content)
#
#     print(f"Downloaded and saved: {image_path}")

# 연결 및 커서 닫기
cursor.close()
conn.close()
