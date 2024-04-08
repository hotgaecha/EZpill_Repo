import 'package:ezpill/Screens/faq_screen.dart';
import 'package:ezpill/Screens/pharmacy_screen.dart';
import 'package:ezpill/Screens/profile_screen.dart';
import 'package:ezpill/Screens/recommend_screen.dart';
import 'package:ezpill/widgets/input_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BottomnavBarWidget extends StatefulWidget {
  final String firebaseUid;
  final String kakaoUid;

  const BottomnavBarWidget({
    Key? key,
    required this.kakaoUid,
    required this.firebaseUid,
  }) : super(key: key);

  @override
  State<BottomnavBarWidget> createState() => _BottomnavBarWidgetState();
}

class _BottomnavBarWidgetState extends State<BottomnavBarWidget> {
  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        border: Border.all(color: Colors.black.withOpacity(0.25)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              IconButton(
                visualDensity: const VisualDensity(horizontal: 2),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/icons/fi-rr-user.png",
                  width: 40,
                  height: 40,
                ),
              ),
              const Text(
                '내 정보',
                style: TextStyle(
                  color: Color(0xff374957),
                  fontSize: 11,
                  fontFamily: 'NanumSquare',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              IconButton(
                visualDensity: const VisualDensity(horizontal: 2),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FAQScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/icons/fi-rr-comment-alt.png",
                  width: 40,
                  height: 40,
                ),
              ),
              const Text(
                'FAQ',
                style: TextStyle(
                  color: Color(0xff374957),
                  fontSize: 11,
                  fontFamily: 'NanumSquare',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              )
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              IconButton(
                visualDensity: const VisualDensity(horizontal: 2),
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PharmacyScreen(),
                    ),
                  );
                },
                icon: Image.asset(
                  "assets/icons/fi-rr-map-marker.png",
                  width: 40,
                  height: 40,
                ),
              ),
              const Text(
                '주변 약국',
                style: TextStyle(
                  color: Color(0xff374957),
                  fontSize: 11,
                  fontFamily: 'NanumSquare',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              )
            ],
          ),
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              IconButton(
                visualDensity: const VisualDensity(horizontal: 2),
                padding: EdgeInsets.zero,
                onPressed: () async {
                  var firebaseUid = widget.firebaseUid;
                  var url =
                      'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/surveyresponses/user/$firebaseUid/';

                  var response = await http.get(Uri.parse(url));
                  if (response.statusCode == 200) {
                    var data = json.decode(response.body);
                    var name = data['name'];
                    var recommendation = data['recommendation'];

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          name: name, // 장고에서 가져온 name 값
                          firebaseUid: firebaseUid,
                          kakaoUid: widget.kakaoUid,
                          recommendation:
                              recommendation, // 장고에서 가져온 recommendation 값
                        ),
                      ),
                    );
                  } else {
                    // 에러 처리
                    print('Failed to fetch user info');
                  }
                },
                icon: Image.asset(
                  "assets/icons/fi-rr-shopping-bag.png",
                  width: 40,
                  height: 40,
                ),
              ),
              const Text(
                '장바구니',
                style: TextStyle(
                  color: Color(0xff374957),
                  fontSize: 11,
                  fontFamily: 'NanumSquare',
                  fontWeight: FontWeight.w800,
                  height: 0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
