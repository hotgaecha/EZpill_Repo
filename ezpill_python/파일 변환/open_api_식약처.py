import requests
import json
import csv

# API 호출
response = requests.get("http://openapi.foodsafetykorea.go.kr/api/aa109f715a384284b90a/C003/XML/1/100")

# 응답 데이터 확인
data = response
print(data)

# 데이터를 파일로 저장
output_file_path = "output.xml"
with open(output_file_path, "w", encoding="utf-8") as file:
    json.dump(data, file, ensure_ascii=False, indent=2)


