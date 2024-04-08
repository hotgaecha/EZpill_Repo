import 'package:ezpill/Screens/faq_screen.dart';
import 'package:ezpill/Screens/stress_list_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pill_detail_screen.dart'; // DetailScreen 파일 import

class PillListScreen extends StatefulWidget {
  final String nutrientName;

  const PillListScreen(this.nutrientName, {super.key});

  @override
  _PillListScreenState createState() => _PillListScreenState();
}

// 검색어
String searchText = '';

class _PillListScreenState extends State<PillListScreen> {
  List<Map<String, dynamic>> nutrientInfo = [];

  @override
  void initState() {
    super.initState();
    fetchNutrientInfo(widget.nutrientName);
  }

  Future<void> fetchNutrientInfo(String nutrientName) async {
    try {
      // Django API URL
      String pillDataUrl =
          'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/ezpill';

      var response = await http.get(
        Uri.parse('$pillDataUrl/api/products/$nutrientName/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8'
        }, // UTF-8 설정
      );

      if (response.statusCode == 200) {
        var jsonResponse =
            json.decode(utf8.decode(response.bodyBytes)); // UTF-8 디코딩
        setState(() {
          nutrientInfo = List<Map<String, dynamic>>.from(jsonResponse);
        });
      } else {
        print('Failed to load nutrient information: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: '성분으로 검색하기'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: nutrientInfo.isEmpty
            ? const Center(child: CircularProgressIndicator()) // 로딩 중이면 스피너 표시
            : Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        const BackgroundWidget(),
                        Column(children: [
                          const SizedBox(
                            height: 60,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                  width: 320,
                                  height: 60,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: Colors.black.withOpacity(0.25),
                                      ),
                                      borderRadius: BorderRadius.circular(25),
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
                                ),
                                Positioned(
                                  top: 18,
                                  left: 18,
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(),
                                    child: Image.asset(
                                        "assets/icons/fi-rr-search.png"),
                                  ),
                                ),
                                Positioned(
                                  left: 56,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 250,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: '찾으시는 영양제가 있나요?',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          searchText = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: SingleChildScrollView(
                                child: SizedBox(
                              height: 410,
                              width: 360,
                              child: ListView.builder(
                                itemCount: nutrientInfo.length,
                                itemBuilder: (context, index) {
                                  if (searchText.isNotEmpty &&
                                      !nutrientInfo[index]['product_title']
                                          .toLowerCase()
                                          .contains(searchText.toLowerCase())) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return Card(
                                      elevation: 3,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.elliptical(10, 10)),
                                      ),
                                      child: GestureDetector(
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
                                                color: Colors.black
                                                    .withOpacity(0.25),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 60,
                                                height: 60,
                                                child: Text(
                                                  '${index + 1}',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Color(0xFFF9B53A),
                                                    fontSize: 25,
                                                    fontFamily:
                                                        'Gmarket Sans TTF',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                  ),
                                                ),
                                              ),
                                              Image.asset(
                                                'assets/images/${nutrientInfo[index]['product_id']}.jpg',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 220,
                                                    child: Text(
                                                      nutrientInfo[index][
                                                              'product_title'] ??
                                                          'Unknown',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'NanumSquare',
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        height: 0,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  SizedBox(
                                                    width: 220,
                                                    child: Text(
                                                      '${nutrientInfo[index]['product_price']}원',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFFD9D9D9),
                                                        fontSize: 10,
                                                        fontFamily:
                                                            'NanumSquare',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height: 0,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  SizedBox(
                                                    width: 220,
                                                    child: Text(
                                                      '하루 ${nutrientInfo[index]['product_per_price']}원',
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontFamily:
                                                            'NanumSquare',
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        height: 0,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PillDetailScreen(
                                                productInfo:
                                                    nutrientInfo[index],
                                                product_id:
                                                    "${nutrientInfo[index]['product_id']}",
                                                updateLikedPills:
                                                    (List<String> likedPills) {
                                                  // 이 부분에 likedPills를 사용하여 필요한 동작을 수행하세요.
                                                  // ProfileScreen에서의 업데이트 로직을 여기에 추가
                                                  setState(() {
                                                    // 예시: likedPills를 출력하는 로직
                                                    print(
                                                        'Liked Pills: $likedPills');
                                                  });
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            )),
                          )
                        ]),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StressListScreen(),
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
                          "고민으로 검색하기",
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
