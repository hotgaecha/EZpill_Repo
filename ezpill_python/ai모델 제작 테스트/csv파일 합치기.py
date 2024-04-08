import pandas as pd
import glob

# CSV 파일들의 경로를 가져오기
file_paths = glob.glob('/Users/baeki/Desktop/ezpill/크롤링 데이터/*.csv')

# 각 CSV 파일을 읽어서 DataFrame으로 변환하고 리스트에 저장
dfs = [pd.read_csv(file) for file in file_paths]

# 리스트에 저장된 DataFrame을 합치기
merged_df = pd.concat(dfs, ignore_index=True)

# 합쳐진 DataFrame을 CSV 파일로 저장
merged_df.to_csv('/Users/baeki/Desktop/ezpill/ai모델 제작 테스트/iherb_product.csv', index=False)
