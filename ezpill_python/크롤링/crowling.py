import requests
from bs4 import BeautifulSoup
import time
import csv
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.keys import Keys
from selenium.common.exceptions import StaleElementReferenceException
from selenium.webdriver.common.action_chains import ActionChains
from selenium.common.exceptions import TimeoutException
from selenium.webdriver.support.ui import Select
import re


def convert_mcg_to_mg(value):
    # 영양 성분 정보 문자열 제거
    value = re.sub(r'영양 성분 정보.*?%$', '', value)

    # 정규표현식을 사용하여 숫자와 단위를 추출

    match = re.search(r'([\d,]+\.?\d*)([a-z A-Z %]+)', value)
    if match:
        numeric_value = float(match.group(1).replace(',', ''))  # 쉼표(,) 제거 후 숫자 값 추출
        unit = match.group(2)  # 단위 추출

        if unit.lower() == 'mcg':
            mg_value = round(numeric_value / 1000, 3)  # mcg를 mg로 변환 (소수점 3자리까지)
            return f"{mg_value}mg"
        elif unit.lower() == 'IU':
            mg_value = round(numeric_value/0.67)
            return  f"{mg_value}mg"

        elif unit.lower() == 'mg':
            return match.group(0)  # mg 단위이면 원래 값 그대로 반환
        elif unit.lower() == '%':
            return match.group(0)  # % 단위이면 원래 값 그대로 반환
    return value


query_txt = input('크롤링할 키워드는 무엇입니까?')

chrome_options = Options()
chrome_options.add_experimental_option("detach", True)
chrome_options.add_experimental_option("excludeSwitches", ["enable-logging"])

# 브라우저 생성
browser = webdriver.Chrome(options=chrome_options)

browser.get("https://kr.iherb.com/")

# 검색창 클릭
search = browser.find_element(By.CSS_SELECTOR, "#txtSearch")
search.click()
time.sleep(2)

# 검색어 입력
search.send_keys(query_txt)

# 검색버튼 클릭
browser.find_element(By.CSS_SELECTOR, ".icon.icon-search").click()

# 페이지 로딩 대기
WebDriverWait(browser, 10).until(EC.presence_of_element_located((By.CSS_SELECTOR, ".absolute-link.product-link")))

# 드롭다운 메뉴 버튼 요소를 찾습니다.
dropdown_menu = WebDriverWait(browser, 10).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, 'div.sort-by-relevance select.panel-form-control.dropdown-sort')))

# 드롭다운 메뉴를 클릭하여 옵션을 펼칩니다.
dropdown_menu.click()

# Select 객체를 생성합니다.
dropdown = Select(dropdown_menu)

# '평가 수가 많은' 옵션을 선택합니다.
dropdown.select_by_value('12')
time.sleep(3)

# 품절상품 숨기기
Out_of_stock_hidden = browser.find_element(By.CSS_SELECTOR, 'label[for="Filterooshideoutofstock"]')
browser.execute_script("arguments[0].click();", Out_of_stock_hidden)
time.sleep(5)

# 별점 5점 영양제 들어가기
ratings_5_filter = browser.find_element(By.CSS_SELECTOR, "#Filterratings5")
browser.execute_script("arguments[0].click();", ratings_5_filter)

# 스크롤 전 높이
before_h = browser.execute_script("return window.scrollY")

# 무한 스크롤
while True:
    browser.find_element(By.CSS_SELECTOR, "body").send_keys(Keys.END)
    time.sleep(1)
    after_h = browser.execute_script("return window.scrollY")
    if after_h == before_h:
        break
    before_h = after_h

items = browser.find_elements(By.CSS_SELECTOR, "a.absolute-link.product-link")
item_links = [item.get_attribute('href') for item in items[:48]]

# CSV 파일 열기
with open('iherb_products.csv', 'w', newline='', encoding='utf-8-sig') as csvfile:
    fieldnames = ['Image_URL', 'Product_Title', 'Product_Manufacture', 'Product_Price', 'Product_Per_Price',
                  'Product_Usage', 'Product_Precautions', 'Product_Ingredient_Information', 'Review']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    # 헤더 작성
    writer.writeheader()

    for link in item_links:
        try:
            browser.get(link)

            # 페이지 로딩 대기
            WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.CSS_SELECTOR, ".product-title")))

            # 크롤링 로직
            product_image = browser.find_element(By.CSS_SELECTOR, "#iherb-product-image").get_attribute("src")
            product_title = browser.find_element(By.CSS_SELECTOR, "h1#name").text
            product_manufacture = browser.find_element(By.CSS_SELECTOR, 'span[itemprop="name"] > bdi').text
            product_price = browser.find_element(By.CSS_SELECTOR, ".price-inner-text p").text.strip()
            product_per_price = browser.find_element(By.CSS_SELECTOR, ".small.price-per-unit").text.strip()
            product_description = browser.find_element(By.CSS_SELECTOR,
                                                       'div.row.item-row div[itemprop="description"]').text
            product_usage = browser.find_element(By.CSS_SELECTOR, '.col-xs-24 > .prodOverviewDetail p').text
            product_precautions = browser.find_element(By.CSS_SELECTOR,
                                                       'div.row.item-row:nth-child(4) > div.col-xs-24 > div.prodOverviewDetail').text

            product_ingredient_information = browser.find_element(By.CSS_SELECTOR,
                                                                  '.col-xs-24.col-md-10 .supplement-facts-container table').text

            # 제품 설명이 5줄을 초과하는지 확인 후 처리
            if len(product_ingredient_information.split('\n')) > 5:
                # 제품 설명이 5줄 초과하는 경우, 다음 제품으로 넘어감
                continue

            # 변환된 영양 성분 정보 생성
            converted_ingredient_info = convert_mcg_to_mg(product_ingredient_information)

            review_link = browser.find_element(By.CSS_SELECTOR,
                                               'ugc-read-more[data-testid="pdp-qna-see-all-review"] > a')
            browser.execute_script("arguments[0].scrollIntoView();", review_link)
            browser.execute_script("arguments[0].click();", review_link)

            current_url = browser.current_url

            # 현재 페이지 URL에서 'sort=6'을 'sort=1'로 변경
            review_link = current_url.replace('sort=6', 'sort=1')

            browser.get(review_link)

            box_list = []

            boxes = browser.find_elements(By.CSS_SELECTOR, '.MuiBox-root.css-1v71s4n')

            for box in boxes:
                # 자세히 보기 버튼 클릭
                try:
                    more_btn = box.find_element(By.CSS_SELECTOR, '.MuiTypography-root.MuiTypography-body2.css-ptz5k')
                    browser.execute_script("arguments[0].click();", more_btn)
                    time.sleep(3)
                except:
                    continue

                try:
                    review = box.find_element(By.CSS_SELECTOR, '.MuiBox-root.css-0[data-testid="review-text"] a').text
                except:
                    review = "리뷰없음"

                box_item = {'Review': review}
                box_list.append(box_item)

            print("이미지 URL:", product_image)
            print("상품 제목:", product_title)
            print("제조사:", product_manufacture)
            print("상품 가격:", product_price)
            print("상품 개별가격:", product_per_price)
            print("상품 사용방법:", product_usage)
            print("상품 주의사항:", product_precautions)
            print("영양 성분정보:", converted_ingredient_info)
            for item in box_list:
                print("리뷰:", item['Review'])
                print("=" * 200)

            # 각 제품의 리뷰를 줄 바꿈으로 연결하여 하나의 문자열로 변환
            reviews_str = "\n".join([item['Review'] for item in box_list])

            # CSV 파일에 쓰기 (리뷰 정보)

            writer.writerow({
                'Image_URL': product_image,
                'Product_Title': product_title,
                'Product_Manufacture': product_manufacture,
                'Product_Price': product_price,
                'Product_Per_Price': product_per_price,
                'Product_Usage': product_usage,
                'Product_Precautions': product_precautions,
                'Product_Ingredient_Information': converted_ingredient_info,
                'Review': reviews_str
            })

            time.sleep(2)  # 페이지 이동 후 대기
        except StaleElementReferenceException:
            print("StaleElementReferenceException 발생. 다음 항목으로 계속 진행합니다.")
            continue

# 브라우저 종료
browser.quit()