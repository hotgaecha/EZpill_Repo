import re
text = '''
영양 성분 정보
1회 제공량: 사탕 정제 1정
1회 제공량당	%하루 영양소 기준치
비타민B12(메틸코발라민)	500mcg	20833%'''
def convert_mcg_to_mg(value):
    # 영양 성분 정보 문자열 제거
    value = re.sub(r'영양 성분 정보.*?%$', '', value)

    # 정규표현식을 사용하여 숫자와 단위를 추출

    match = re.search(r'([\d,]+\.?\d*)([a-z]+)', value)
    if match:
        numeric_value = float(match.group(1).replace(',', ''))  # 쉼표(,) 제거 후 숫자 값 추출
        unit = match.group(2)  # 단위 추출

        if unit.lower() == 'mcg':
            mg_value = round(numeric_value / 1000, 3)  # mcg를 mg로 변환 (소수점 3자리까지)
            return f"{mg_value}mg"
        elif unit.lower() == 'mg':
            return match.group(0)  # mg 단위이면 원래 값 그대로 반환
        elif unit.lower() == '%':
            return match.group(0)  # % 단위이면 원래 값 그대로 반환
    return value
print(convert_mcg_to_mg(text))