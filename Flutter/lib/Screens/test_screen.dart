import 'package:ezpill/Screens/login_screen.dart';
import 'package:ezpill/Screens/main_screen.dart';
import 'package:ezpill/widgets/graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TestScreen extends StatelessWidget {
  final List<int> productIds;
  final List<String> ingredients;
  final String name;
  final double totalPrice;
  final String kakaoUid;
  final String firebaseUid;

  const TestScreen({
    super.key,
    required this.productIds,
    required this.ingredients,
    required this.name,
    required this.totalPrice,
    required this.kakaoUid,
    required this.firebaseUid,
  });

  String getIngredientName(int productId) {
    if (productId >= 1 && productId <= 25) return '루테인';
    if ((productId >= 26 && productId <= 37) ||
        [125, 175, 205].contains(productId)) return '엽산';
    if ((productId >= 38 && productId <= 63) ||
        [92, 114, 140].contains(productId)) return '콜라겐';
    if ((productId >= 64 && productId <= 79) || productId == 93) return '마그네슘';
    if ((productId >= 80 && productId <= 110) || productId == 164) {
      return '오메가 3';
    }
    if (productId >= 115 && productId <= 124) return '비타민 B';
    if ((productId >= 126 && productId <= 143) ||
        productId == 173 ||
        productId == 174) return '비타민 D';
    if (productId >= 144 && productId <= 158) return '칼슘';
    if ((productId >= 159 && productId <= 163) ||
        (productId >= 165 && productId <= 172) ||
        (productId >= 176 && productId <= 196) ||
        (productId >= 210 && productId <= 215)) return '유산균';
    if ((productId >= 197 && productId <= 205) ||
        (productId >= 206 && productId <= 209)) return '철분';

    return '알 수 없는 성분';
  }

  double getRecommendedIntake(String ingredientName) {
    switch (ingredientName) {
      case '엽산':
        return 1;
      case '칼슘':
        return 700;
      case '철분':
        return 130;
      case '비타민 D':
        return 0.1;
      case '오메가 3':
        return 1500;
      case '마그네슘':
        return 100;
      case '루테인':
        return 10;
      case '콜라겐':
        return 10000;
      case '유산균':
        return 100000000; // 1억 CFU
      case '비타민 B':
        return 0.5;
      default:
        return 0;
    }
  }

  double getUpperIntake(String ingredientName) {
    switch (ingredientName) {
      case '엽산':
        return 3;
      case '칼슘':
        return 1500;
      case '철분':
        return 250;
      case '비타민 D':
        return 0.7;
      case '오메가 3':
        return 3000;
      case '마그네슘':
        return 350;
      case '루테인':
        return 30;
      case '콜라겐':
        return 35000;
      case '유산균':
        return 1000000000; // 10억 CFU
      case '비타민 B':
        return 3;
      default:
        return 0;
    }
  }

  double convertToMg(String value) {
    if (value.contains('ug')) {
      return (double.parse(value.replaceAll('ug', '')) / 1000);
    } else if (value.contains('CFU')) {
      return double.parse(value.replaceAll('CFU', ''));
    }
    return double.parse(value.replaceAll('mg', ''));
  }

  List<Map<String, dynamic>> get intakeDoseList {
    Map<String, double> intakeSums = {};
    Map<String, double> recommendedIntakes = {};
    Map<String, double> upperIntakes = {};

    for (int index = 0; index < productIds.length; index++) {
  if (index < ingredients.length) {
    String ingredientName = getIngredientName(productIds[index]);
    double currentIntakeMg = convertToMg(ingredients[index]);

      intakeSums.update(
          ingredientName, (existingValue) => existingValue + currentIntakeMg,
          ifAbsent: () => currentIntakeMg);
      recommendedIntakes[ingredientName] = getRecommendedIntake(ingredientName);
      upperIntakes[ingredientName] = getUpperIntake(ingredientName);
    }
    }

    return intakeSums.keys.map((ingredientName) {
      return {
        'name': ingredientName,
        'recommendedIntake': recommendedIntakes[ingredientName],
        'currentIntake': intakeSums[ingredientName],
        'upperIntake': upperIntakes[ingredientName],
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '매일 이만큼의 영양성분을\n보충할 수 있어요.',
                  style: TextStyle(
                      fontFamily: "NanumSquare",
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 430, // GridView에 고정된 높이 제공
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(), // 내부 스크롤 비활성화
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 7,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: intakeDoseList.length,
                  itemBuilder: (context, index) {
                    return GraphWidget(
                      ingredientName: intakeDoseList[index]['name'],
                      recommendedIntake: intakeDoseList[index]
                          ['recommendedIntake'],
                      currentIntake: intakeDoseList[index]['currentIntake'],
                      upperIntake: intakeDoseList[index]['upperIntake'],
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SubscriptionOptionsScreen(
                        totalPrice: totalPrice, // 여기서 totalPrice를 전달
                        name: name, // 여기서 name을 전달
                        kakaoUid: kakaoUid,
                        firebaseUid: firebaseUid,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xfff9b53a),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 5,
                        offset: Offset(0, 4),
                        spreadRadius: 3,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "구매하기",
                    style: TextStyle(
                        fontFamily: "Gmarket Sans TTF",
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubscriptionOptionsScreen extends StatelessWidget {
  final String kakaoUid;
  final String firebaseUid;
  final double totalPrice;
  final String name;

  const SubscriptionOptionsScreen({
    Key? key,
    required this.totalPrice,
    required this.name,
    required this.kakaoUid,
    required this.firebaseUid,
  }) : super(key: key);

  double calculateDiscountedPrice(int months) {
    final discountRates = {1: 0.0, 3: 0.05, 6: 0.10}; // 할인율 설정
    final discountRate = discountRates[months] ?? 0.0;
    return totalPrice * (1 - discountRate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const SizedBox(
              width: double.maxFinite,
              child: Text(
                '영양제를 복용할 기간을\n선택해주세요.',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: "NanumSquare",
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
            SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndScreen(
                                kakaoUid: kakaoUid, firebaseUid: firebaseUid),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 3,
                              color: Color(0xfff9b53a),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '1개월',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Gmarket Sans TTF',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${totalPrice.toInt()}원',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: 'Gmarket Sans TTF',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const Text(
                                      '/일',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Gmarket Sans TTF',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168610.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '한 번에 배송해드려요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168732.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '다음 달부터 무료로 배송돼요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndScreen(
                                kakaoUid: kakaoUid, firebaseUid: firebaseUid),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 3,
                              color: Color(0xfff9b53a),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '3개월',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Gmarket Sans TTF',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${(totalPrice * 0.9).toInt()}원',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: 'Gmarket Sans TTF',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const Text(
                                      '/일',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Gmarket Sans TTF',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168610.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '매월 무료로 배송해드려요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168610.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '추가 사은품이 증정돼요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168732.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '변경한 영양제는 다음 달부터 적용돼요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndScreen(
                                kakaoUid: kakaoUid, firebaseUid: firebaseUid),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 3,
                              color: Color(0xfff9b53a),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '6개월',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontFamily: 'Gmarket Sans TTF',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${(totalPrice * 0.85).toInt()}원',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontFamily: 'Gmarket Sans TTF',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const Text(
                                      '/일',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'Gmarket Sans TTF',
                                        fontWeight: FontWeight.w300,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168610.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '무료로 배송해드려요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168610.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '추가 사은품이 증정돼요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/free-icon-checkbox-1168610.png',
                                  height: 24,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '배송 주기를 선택할 수 있어요.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'NanumSquare',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EndScreen extends StatelessWidget {
  final String kakaoUid;
  final String firebaseUid;
  const EndScreen({
    super.key,
    required this.kakaoUid,
    required this.firebaseUid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: double.maxFinite,
              child: Text(
                '결제가 완료되었어요!',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: "NanumSquare",
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(color: Colors.white),
              child: Transform.scale(
                scale: 1,
                child: Transform.translate(
                  offset: const Offset(60, 0),
                  child: Image.asset(
                    "assets/icons/icon3.png",
                    width: 300,
                    height: 300,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(
                        kakaoUid: kakaoUid, firebaseUid: firebaseUid),
                  ),
                );
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xff00c6fc),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 3,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "곧 만나요!",
                  style: TextStyle(
                      fontFamily: "Gmarket Sans TTF",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
