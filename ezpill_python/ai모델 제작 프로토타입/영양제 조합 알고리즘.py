class Recommendation:

    def __init__(self, weeks, age, bmi, medication, current_supplements, allergies, chronic_disease,
                 digestive_issues, muscle_twitching, eye_fatigue, skin_condition, feel_down, pill_preference, budget):
        self.weeks = weeks
        self.age = age
        self.bmi = bmi
        self.medication = medication
        self.current_supplements = current_supplements
        self.allergies = allergies
        self.chronic_disease = chronic_disease
        self.digestive_issues = digestive_issues
        self.muscle_twitching = muscle_twitching
        self.eye_fatigue = eye_fatigue
        self.skin_condition = skin_condition
        self.feel_down = feel_down
        self.pill_preference = pill_preference
        self.budget = budget

    def recommend_supplements(self):
        supplements = []

        # 1. 임신 주차에 따른 영양제
        if 1 <= self.weeks <= 13:
            supplements.extend(["엽산", "비타민 D"])

        elif self.weeks == 14:
            supplements.extend(["엽산", "비타민 D", "오메가-3"])

        elif 15 <= self.weeks <= 19:
            supplements.extend(["철분", "비타민 D", "오메가-3"])

        elif 20 <= self.weeks:
            supplements.extend(["철분", "비타민 D", "오메가-3", "칼슘"])

        elif 36 <= self.weeks:
            supplements.extend(["철분", "비타민 D", "칼슘"])

        # 2. 나이에 따른 영양제
        if self.age <= 19:
            supplements.extend(["엽산", "비타민 D"])
        elif 20 <= self.age <= 35:
            supplements.extend(["마그네슘"])
        elif self.age > 35:
            supplements.extend(["철분", "칼슘", "오메가-3"])

        # 3. BMI에 따른 영양제
        if self.bmi < 18.5:
            supplements.extend(["칼슘", "비타민 B"])
        elif self.bmi >= 25:
            supplements.extend(["마그네슘", "오메가-3", "비타민 D"])

        # 추가적인 조건에 따른 영양제


        # 6. 장 건강에 문제를 겪고 있나요?
        # 현재 복용 중이지 않으면서 장 건강에 문제가 있는 경우 유산균 추가
        if "유산균" not in self.current_supplements and self.digestive_issues:
            supplements.append("유산균")

        # 7. 근육 경련이나 떨림을 자주 경험합니까?
        # 마그네슘을 추가
        if self.muscle_twitching:
            supplements.append("마그네슘")

        # 8. 눈이 자주 피로하거나 붉어지나요?
        # 루테인 추가
        if self.eye_fatigue:
            supplements.append("루테인")

        # 9. 피부의 수분감이나 탄력이 떨어짐을 느끼나요?
        # 콜라겐을 추가
        if self.skin_condition:
            supplements.append("콜라겐")

        # 10. 몸에 기운이 없거나 신진대사가 떨어짐을 느끼나요?
        if self.feel_down:
            supplements.append("비타민 B")

        # 11. 선호하는 알약 제형
        if self.pill_preference == "상관없음":
            pass  # 아무 제약이나 사용 가능
        elif self.pill_preference == "캡슐":
            supplements = [supplement + " 캡슐" for supplement in supplements]
        elif self.pill_preference == "액상":
            supplements = [supplement + " 액상" for supplement in supplements]

        # 11.예산 내에서 최대한 다양한 영양제 선택
        total_cost = sum(get_supplement_cost(supplement) for supplement in supplements)
        if total_cost > self.budget:
            supplements = adjust_budget(supplements, self.budget)


        # 4. 평소 드시는 약?
        # 먹고 있다면 그대로 넣어주자
        # 복용중인 영양제와 같이 먹으면 안되는 영양제는 추천리스트에서 빼자.
        # 1 혈액 희석제 -> 오메가3(-)
        # 2 항경련제 -> 엽산(-)
        # 3 항생제(테트라사이클린, 퀴놀론) -> 철분(-), 칼슘(-)
        # 4 디곡신 -> 비타민 D(-)
        # 5 비스포스포네이트 -> 칼슘(-)
        # 6 항생제 -> 유산균(-), 마그네슘(-)
        # 7 이뇨제, 골다공증 치료제 -> 마그네슘(-)
        if "엽산" in self.medication:
            supplements.append("엽산")
        elif "비타민 D" in self.medication:
            supplements.append("비타민 D")
        elif "오메가-3" in self.medication:
            supplements.append("오메가-3")
        elif "철분" in self.medication:
            supplements.append("철분")
        elif "칼슘" in self.medication:
            supplements.append("칼슘")
        elif "혈액 희석제" in self.medication:
            supplements.remove("오메가-3")
        elif "항경련제" in self.medication:
            supplements.remove("엽산")
        elif "항생제(테트라사이클린, 퀴놀론)" in self.medication:
            supplements.remove("철분")
            supplements.remove("칼슘")
        elif "디곡신" in self.medication:
            supplements.remove("비타민 D")
        elif "비스포스포네이트" in self.medication:
            supplements.remove("칼슘")
        elif "항생제" in self.medication:
            supplements.remove("마그네슘")
        elif "항생제" in self.medication:
            supplements.remove("유산균")
        elif "이뇨제" in self.medication:
            supplements.remove("마그네슘")
        elif "골다공증 치료제" in self.medication:
            supplements.remove("마그네슘")
        elif "비타민 D" in self.medication and "칼슘" in self.medication:
            print("비타민 D와 칼슘을 같이 섭취할 경우 권장 섭취량에 주의하세요")
        else:
            supplements.append(medication)

        # 5. 알러지가 있나요?
        # 선택지는 4개
        # 1)해산물 알러지 -> 오메가 3 제외
        # 2)콜라겐 알러지 -> 콜라겐 제외
        # 3)유산균 알러지 -> 유산균 제외
        # 4)캐로티노이드 알러지 -> 루테인 제외

        if "해산물" in self.allergies:
            supplements.remove("오메가-3")
        elif "콜라겐" in self.allergies:
            supplements.remove("콜라겐")
        elif "유산균" in self.allergies:
            supplements.remove("유산균")
        elif "캐로티노이드" in self.allergies:
            supplements.remove("루테인")

        #중복되는 항목들을 제거해주자
        supplements = list(set(supplements))



        return supplements


def print_recommended_supplements(recommended_supplements):
    for supplement in recommended_supplements:
        cost = get_supplement_cost(supplement)
        print(f"{supplement}: ${cost}")


def get_supplement_cost(supplement):
    # 각 영양제의 가격을 가져오는 함수 (예시)
    supplement_prices = {
        "엽산": 10,
        "철분": 15,
        "비타민 D": 12,
        "칼슘": 20,
        "마그네슘": 18,
        "오메가-3": 25,
        "유산균": 22,
        "루테인": 28,
        "콜라겐": 35,
        "비타민 B": 100,
    }
    return supplement_prices.get(supplement, 0)


def adjust_budget(supplements, budget):
    # 예산 내에서 최대한 많은 영양제를 선택하는 함수 (예시)
    sorted_supplements = sorted(supplements, key=get_supplement_cost)
    selected_supplements = []
    total_cost = 0
    for supplement in sorted_supplements:
        supplement_cost = get_supplement_cost(supplement)
        if total_cost + supplement_cost <= budget:
            selected_supplements.append(supplement)
            total_cost += supplement_cost
    return selected_supplements


# 사용 예시

# weeks, age, bmi, medication, current_supplements, allergies, chronic_disease,
# digestive_issues, muscle_twitching, eye_fatigue, skin_condition, feel_down, pill_preference, budget):

weeks = int(input("임신 주차를 입력하세요: "))
age = int(input("나이를 입력하세요: "))
bmi = float(input("임신 전 몸무게(BMI)를 입력하세요: "))
medication = input("평소 드시는 약이 있나요? (없으면 엔터): ")
current_supplements = input("현재 복용 중인 영양제가 있나요? (모른다면 엔터): ")
allergies = input("알러지가 있나요? (없으면 엔터): ")
chronic_disease = input("만성질환 또는 지병이 있나요? (없으면 엔터): ")
digestive_issues = input("장 건강에 문제가 있나요? (있으면 y, 없으면 엔터): ").lower() == 'y'
muscle_twitching = input("근육 경련이나 떨림을 자주 경험하나요? (있으면 y, 없으면 엔터): ").lower() == 'y'
eye_fatigue = input("눈이 자주 피로하거나 붉어지나요? (있으면 y, 없으면 엔터): ").lower() == 'y'
skin_condition = input("피부의 수분감이나 탄력이 떨어짐을 느끼나요? (있으면 y, 없으면 엔터): ").lower() == 'y'
pill_preference = input("선호하는 알약의 제형을 입력하세요 (형태 또는 함량 상관없음 포함): ")
feel_down = input("몸에 기운이 없거나 신진대사가 떨어짐을 느끼나요? (있으면 y, 없으면 엔터): ")
budget = float(input("하루 투자 가능 금액을 입력하세요: "))
recommendation = Recommendation(weeks, age, bmi, medication, current_supplements, allergies, chronic_disease,
                                digestive_issues, muscle_twitching, eye_fatigue, skin_condition, feel_down,
                                pill_preference, budget)

recommended_supplements = recommendation.recommend_supplements()
print("Recommended Supplements:")
print_recommended_supplements(recommended_supplements)
