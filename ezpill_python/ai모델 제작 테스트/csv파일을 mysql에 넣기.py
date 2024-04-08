import pandas as pd
from sqlalchemy import create_engine

# RDS 연결 정보
host = "qqrx224.cgidx97t8k8h.ap-northeast-2.rds.amazonaws.com"
user = "BAEKI"
password = "qoqorlxo1!"
database = "Ezpill"

# CSV 파일 경로 및 파일명
csv_file_path = "/Users/baeki/Desktop/ezpill/크롤링 데이터/iherb_product.csv"

# MySQL 연결 문자열 생성
engine = create_engine(f"mysql+mysqldb://{user}:{password}@{host}/{database}", echo=True)

# CSV 파일을 데이터프레임으로 읽기
df = pd.read_csv(csv_file_path)

# 데이터프레임을 MySQL 테이블에 쓰기
df.to_sql('product', con=engine, if_exists='replace', index=False)

print("데이터가 성공적으로 로드되었습니다.")

