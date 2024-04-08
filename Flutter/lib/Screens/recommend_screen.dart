import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'test_screen.dart'; // 'test_screen.dart' 파일의 정확한 경로로 바꿔주세요.
import 'search_screen.dart';
import 'package:http/http.dart' as http;

class RecommendScreen extends StatelessWidget {
  final String name;
  final String recommendation;
  final String kakaoUid;
  final String firebaseUid;

  const RecommendScreen({
    Key? key,
    required this.kakaoUid,
    required this.name,
    required this.recommendation,
    required this.firebaseUid,
  }) : super(key: key);

  Future<void> callLambdaFunction(BuildContext context) async {
    const urlLambdaRds3 =
        'https://m6iecy7wn2.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds3';

    print("firebaseUid: $firebaseUid");
    print("Attempting to call Lambda function for recommendations");
    try {
      final response = await http.post(
        Uri.parse(urlLambdaRds3),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'firebase_uid': firebaseUid}),
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['min_cost_combination'] != null &&
            responseData['cost_up_combination'] != null) {
          // 바로 추천받은 영양제를 저장
          await saveRecommendedProducts(responseData['cost_up_combination']);

          // 결과 화면으로 이동
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                name: name, // 장고에서 가져온 name 값
                firebaseUid: firebaseUid,
                recommendation: recommendation, // 장고에서 가져온 recommendation 값
                kakaoUid: kakaoUid,
              ),
            ),
          );
        } else {
          print('Invalid response format');
          // TODO: Handle the error with a user-friendly message
        }
      } else {
        print('Failed to call lambda function: ${response.body}');
        // TODO: Handle the error with a user-friendly message
      }
    } catch (e) {
      print('Error occurred while calling lambda function: $e');
      // TODO: Handle the error with a user-friendly message
    }
  }

  Future<void> saveRecommendedProducts(
      Map<String, dynamic> recommendedProducts) async {
    const urlLambdaRds4 =
        'https://kn2jc2nvy7.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds4';

    try {
      final response = await http.post(
        Uri.parse(urlLambdaRds4),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'firebase_uid': firebaseUid,
          'products': recommendedProducts.values.toList(),
        }),
      );

      if (response.statusCode != 200) {
        print('Failed to save recommended products: ${response.body}');
        // TODO: Handle the error with a user-friendly message
      } else {
        print('Recommended products saved successfully');
      }
    } catch (e) {
      print('Error occurred while saving recommended products: $e');
      // TODO: Handle the error with a user-friendly message
    }
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
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                '오로지 $name님을 위한\n영양제 조합을 소개할게요.',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: "NanumSquare",
                  fontSize: 27,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name님은',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontFamily: 'NanumSquare',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '$recommendation이(가) 부족해요.',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'NanumSquare',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 0,
            ),
            GestureDetector(
              onTap: () {
                callLambdaFunction(context);
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
                  '다음',
                  style: TextStyle(
                      fontFamily: "Gmarket Sans TTF",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final String kakaoUid;
  final String firebaseUid;
  final String name;
  final String recommendation; // 이 줄을 추가하세요

  const ResultScreen(
      {Key? key,
      required this.firebaseUid,
      required this.kakaoUid,
      required this.name,
      required this.recommendation})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with WidgetsBindingObserver {
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;
  double total = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchUserData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchUserData();
    }
  }

  Future<void> fetchUserData() async {
    final encodedUid = Uri.encodeComponent(widget.firebaseUid);
    final userDataUrl = Uri.parse(
        'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/basket2/api/basket2/$encodedUid');

    try {
      final userDataResponse = await http.get(userDataUrl);

      if (userDataResponse.statusCode == 200) {
        var latestOrder = json
            .decode(userDataResponse.body)
            .reduce((curr, next) => (curr['id'] > next['id']) ? curr : next);

        List<String> productIds = latestOrder['product_id'].split(',');
        List<String> productTitles = latestOrder['product_title'].split(',');
        List<String> productPrices =
            _processPrices(latestOrder['product_per_price'].split(','));

        setState(() {
          products = List.generate(productIds.length, (index) {
            return {
              'product_id': productIds[index].trim(),
              'product_title': productTitles[index].trim(),
              'product_per_price': productPrices[index].trim(),
              'isSelected': false,
            };
          });
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load userData');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching user data: $e');
    }
  }

  List<String> _processPrices(List<String> prices) {
    List<String> processedPrices = [];
    String currentPrice = '';

    for (var part in prices) {
      if (currentPrice.isEmpty || currentPrice.length > 1) {
        processedPrices.add(part);
        currentPrice = part;
      } else {
        currentPrice += ',$part';
        processedPrices[processedPrices.length - 1] = currentPrice;
      }
    }

    return processedPrices;
  }

  void _onProductSelected(bool? isSelected, int index) {
    setState(() {
      products[index]['isSelected'] = isSelected;
      total = 0;
      for (var product in products) {
        if (product['isSelected']) {
          String priceWithoutComma =
              product['product_per_price'].replaceAll(',', '');
          total += double.parse(priceWithoutComma);
        }
      }
    });
  }

  void _callLambdaFunctionForNext() async {
    const url =
        'https://dhrgcc32lg.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds7';
    try {
      // 선택된 제품의 ID만 포함하는 배열 생성
      List<int> selectedProductIds = products
          .where((product) => product['isSelected'])
          .map((product) => int.parse(product['product_id']))
          .toList();

      if (selectedProductIds.isEmpty) {
        print('No products selected');
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'product_ids': selectedProductIds}),
      );

      if (response.statusCode == 200) {
        print('Lambda function called successfully for next action');
        print('Response body: ${response.body}');

        final responseData = json.decode(response.body);
        List<int> productIds = List<int>.from(responseData['product_ids']);
        List<String> ingredients =
            List<String>.from(responseData['ingredients']);

        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TestScreen(
              productIds: productIds,
              ingredients: ingredients,
              name: widget.name,
              totalPrice: total,
              kakaoUid: widget.kakaoUid,
              firebaseUid: widget.firebaseUid,
            ),
          ),
        );
        fetchUserData();
      } else {
        print(
            'Failed to call lambda function for next action: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

//##################################################################################
  Widget _buildProductTile(Map<String, dynamic> product, int index) {
    return Card(
      elevation: 3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Colors.black.withOpacity(0.25),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 0,
            ),
            GestureDetector(
              onTap: () {
                _onProductSelected(!product['isSelected'], index);
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      product['isSelected']
                          ? 'assets/icons/free-icon-checkbox-1168610.png' // 이미지1: 체크된 상태의 이미지
                          : 'assets/icons/free-icon-checkbox-1168732.png', // 이미지2: 체크되지 않은 상태의 이미지
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/${product['product_id']}.jpg', // 이미지 경로 수정
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            Column(
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    product['product_title'],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'NanumSquare',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    '하루 ${product['product_per_price']}원',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'NanumSquare',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 130, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Text(
                '매일 ${total.toStringAsFixed(0)}원으로\n오늘보다 내일 더 건강해질\n${widget.name}님을 위한 영양제예요.',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: "NanumSquare",
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 330,
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildProductTile(products[index], index);
                },
              ),
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 52,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFDFE0DF)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '영양제 추가하기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'NanumSquare',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // 버튼 사이의 간격
                GestureDetector(
                  onTap: () {
                    _callLambdaFunctionForNext();
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
                      '다음',
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
          ],
        ),
      ),
    );
  }
}
