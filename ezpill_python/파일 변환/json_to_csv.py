import json
import csv

# JSON 파일 읽기
json_file_path = "output.json"
with open(json_file_path, "r", encoding="utf-8") as json_file:
    data = json.load(json_file)

# CSV 파일로 변환
csv_file_path = "output2.csv"
with open(csv_file_path, "w", encoding="utf-8", newline="") as csv_file:
    csv_writer = csv.writer(csv_file)

    # 데이터가 있는지 확인 후 헤더 작성
    if data:
        headers = data[0].keys()
        csv_writer.writerow(headers)

        # 데이터 작성
        for row in data:
            csv_writer.writerow(row.values())
    else:
        print("No data found in the JSON file.")

print(f"JSON file has been successfully converted and saved to {csv_file_path}.")
