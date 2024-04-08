import pandas as pd

# CSV 파일을 데이터 프레임으로 읽어오기
csv_file_path = "output2.csv"
df = pd.read_csv(csv_file_path)

# 데이터 프레임 살펴보기
print("데이터 프레임 내용:\n", df.head(100))

# 원하는 가공 작업 수행
# 예를 들어, 특정 열의 값을 변경하거나, 새로운 열을 추가하거나, 특정 행을 선택하는 등의 작업을 수행할 수 있습니다.


print(df)