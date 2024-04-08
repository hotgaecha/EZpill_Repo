import xml.etree.ElementTree as ET
import csv

# XML 파일을 읽어와 파싱
xml_file_path = "output.xml"
tree = ET.parse(xml_file_path)
root = tree.getroot()

# CSV 파일로 변환
csv_file_path = "output.csv"
with open(csv_file_path, "w", encoding="utf-8", newline="") as csv_file:
    csv_writer = csv.writer(csv_file)

    # 헤더 작성
    headers = []
    for element in root[0]:
        headers.append(element.tag)
    csv_writer.writerow(headers)

    # 데이터 작성
    for item in root:
        row_data = [item.find(element.tag).text if item.find(element.tag) is not None else "" for element in root[0]]
        csv_writer.writerow(row_data)

print(f"XML file has been successfully converted and saved to {csv_file_path}.")