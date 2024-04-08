import 'package:ezpill/Screens/faq_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth를 위한 import

class PillDetailScreen extends StatefulWidget {
  final String product_id;
  final Map<String, dynamic> productInfo;
  final Function(List<String>) updateLikedPills;

  const PillDetailScreen({
    Key? key,
    required this.productInfo,
    required this.product_id,
    required this.updateLikedPills,
  }) : super(key: key);

  @override
  State<PillDetailScreen> createState() => _PillDetailScreenState();
}

class _PillDetailScreenState extends State<PillDetailScreen> {
  late SharedPreferences prefs;
  List<String> likedPills = [];
  bool isLiked = false;
  String? firebaseUid; // Firebase UID를 저장할 변수

  @override
  void initState() {
    super.initState();
    initPrefs();
    getCurrentUserUid(); // 현재 사용자의 UID를 가져옴
  }

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedPills = prefs.getStringList('likedPills');
    if (likedPills != null) {
      if (likedPills.contains("${widget.productInfo['product_id']}") == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedPills', []);
    }
  }

  void getCurrentUserUid() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      firebaseUid = user.uid; // 현재 로그인된 사용자의 UID 저장
      print("Current User UID: $firebaseUid"); // 콘솔에 UID 출력
    } else {
      print("No user is currently signed in.");
    }
  }

  onHeartTap() async {
    final likedPills = prefs.getStringList('likedPills') ?? [];
    if (isLiked) {
      likedPills.remove("${widget.productInfo['product_id']}");
    } else {
      likedPills.add("${widget.productInfo['product_id']}");
    }
    await prefs.setStringList('likedPills', likedPills);
    setState(() {
      isLiked = !isLiked;
    });

    widget.updateLikedPills(likedPills);
  }

  Future<void> addToBasket() async {
    if (firebaseUid == null) {
      print('Firebase UID is null');
      return;
    }

    final uri = Uri.parse(
        'https://uodb2jdqki.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds6');

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'firebase_uid': firebaseUid,
          'product_id': widget.productInfo['product_id'],
          'product_title': widget.productInfo['product_title'],
          'product_per_price': widget.productInfo['product_per_price'],
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 데이터가 추가된 경우
        print('Data added to basket successfully');
      } else {
        // 오류 발생
        print('Failed to add data to basket: ${response.body}');
      }
    } catch (e) {
      print('Error adding data to basket: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> reviews =
        (widget.productInfo['review'] as String?)?.split('\n') ?? [];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarWidget(
            screentitle: widget.productInfo['product_title'] ?? 'Unknown'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
          child: Column(
            children: [
              Stack(
                children: [
                  const BackgroundWidget(),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: Image.asset(
                                      'assets/images/${widget.productInfo['product_id']}.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: SizedBox(
                          height: 310,
                          width: 330,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.productInfo['product_title'] ??
                                          'Unknown',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontFamily: 'NanumSquare',
                                        fontWeight: FontWeight.w800,
                                        height: 0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                            onTap: onHeartTap,
                                            child: isLiked
                                                ? Image.asset(
                                                    'assets/icons/free-icon-heart-1176380.png',
                                                    height: 36,
                                                  )
                                                : Image.asset(
                                                    'assets/icons/free-icon-heart-1176482.png',
                                                    height: 36,
                                                  )),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${widget.productInfo['product_price']}원',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: Color(0xFFD9D9D9),
                                                fontSize: 10,
                                                fontFamily: 'NanumSquare',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '하루 ${widget.productInfo['product_per_price']}원',
                                              textAlign: TextAlign.right,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'NanumSquare',
                                                fontWeight: FontWeight.w800,
                                                height: 0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  '상품 설명:',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                    widget.productInfo['product_usage'] ??
                                        'No usage information available',
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 16),
                                const Text('주의 사항:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    widget.productInfo['product_precautions'] ??
                                        'No precaution information available',
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 16),
                                const Text('성분 정보:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text(
                                    widget.productInfo[
                                                'product_ingredient_information']
                                            ?.replaceAll('\\n', '\n') ??
                                        'No ingredient information available',
                                    style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 16),
                                const Text('리뷰:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: reviews.map((review) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(review.trim(),
                                          style: const TextStyle(fontSize: 16)),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  addToBasket(); // '내 영양제로 추가' 버튼 클릭 시 addToBasket 함수 호출
                  Navigator.pop(
                    context,
                    {
                      'productInfo': widget.productInfo,
                      'likedPills': likedPills,
                    },
                  ); // 선택된 제품을 BasketScreen으로 반환
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
                    "장바구니에 추가",
                    style: TextStyle(
                      fontFamily: "Gmarket Sans TTF",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
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
