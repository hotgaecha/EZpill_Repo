import requests
import os
from xml.etree import ElementTree as ET

def get_data_from_api(api_url):
    response = requests.get(api_url)
    if response.status_code == 200:
        return response.content
    else:
        print(f"Failed to retrieve data from API. Status code: {response.status_code}")
        return None

def save_xml_to_file(xml_data, file_path):
    with open(file_path, 'wb') as file:
        file.write(xml_data)
    print(f"XML data has been saved to {file_path}")

def main():
    api_url = "http://openapi.foodsafetykorea.go.kr/api/aa109f715a384284b90a/C003/XML/1/100"
    xml_data = get_data_from_api(api_url)

    if xml_data:
        directory = "/Users/baeki/Desktop/ezpill/ai모델 제작 테스트"
        if not os.path.exists(directory):
            os.makedirs(directory)

        file_path = os.path.join(directory, "output.xml")
        save_xml_to_file(xml_data, file_path)

if __name__ == "__main__":
    main()