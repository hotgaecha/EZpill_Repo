import 'package:ezpill/Screens/stress_list_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

// 검색어
String searchText = '';

// 리스트뷰에 표시할 내용
List<String> items = [
  'Q. 추천하는 영양제외 다른 영양제를 같이 먹어도 되나요?',
  'Q. 먹고있는 식단에서 영양제를 섭취할시 영양이 과다섭취되어 문제가 되지는 않을까요?',
  'Q. 복용타이밍과 권장섭취량에 맞게 추천해주시나요?',
  'Q. 혈압이 좀 높은편인데 이러한 점도 고려하여 영양제를 추천해주시나요?',
  'Q. 빈속에 영양제를 먹어도 될까요?',
];
List<String> itemContents = [
  'A. 비타민 a,d,e는 지용성이기에 과잉섭취해도 소변과 함께 배설되지 않고 몸에 축적이됩니다.그렇기에 과한양을 섭취하지 않고 비타민이 부족하다는 진단을 받은경우를 제외하고는 먹지 않는 것이 좋습니다.',
  'A. 영양제 조합을 추천할때 권장량에 맞게 추천해주기에 문제가 없겠지만 따로 먹고있는 음식이 있다면 영양제를 추가 삭제할 수 있는 기능이 있기에 필요한 영양제만 섭취할수있습니다',
  'A. 처음 영양제를 조합할때 권장섭취량에 맞게 추천해주며 달력에 섭취타이밍을 기록하여 복용하는 루틴을 알려줍니다.',
  'A. 설문조사를 통해 복용자가 어떠한 증상을 가지고 있는지 전부 고려하여 추천해주는 기능을 가지고 있습니다.',
  'A. 영양제를 복용할 때는 제품의 지침을 따르고, 개인의 식습관과 몸 상태에 따라 적절한 복용 시기를 결정하는 것이 중요합니다.',
];

class _FAQScreenState extends State<FAQScreen> {
  void cardClickEvent(BuildContext context, int index) {
    String content = itemContents[index];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContentPage(content: content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "자주 묻는 질문"),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  const BackgroundWidget(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                                    hintText: '궁금한 점이 있으신가요?',
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
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (searchText.isNotEmpty &&
                                    !items[index]
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
                                          horizontal: 20,
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
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                items[index],
                                                style: const TextStyle(
                                                  color: Color(0xFFF9B53A),
                                                  fontSize: 15,
                                                  fontFamily: 'NanumSquare',
                                                  fontWeight: FontWeight.w700,
                                                  height: 0,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              itemContents[index],
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                fontSize: 15,
                                                fontFamily: 'NanumSquare',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                '더 보기',
                                                style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 15,
                                                  fontFamily: 'NanumSquare',
                                                  fontWeight: FontWeight.w800,
                                                  height: 0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        cardClickEvent(context, index);
                                      },
                                    ),
                                  );
                                }
                              },
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StressListScreen()),
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
                    "질문하기",
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

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff9b53a),
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Container(
            height: 450,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ContentPage extends StatelessWidget {
  final String content;

  const ContentPage({Key? key, required this.content}) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('답변'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), // 조절 가능한 둥근 모서리 반지름
                color: Colors.white, // 원하는 색상으로 변경 가능
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5), // 그림자 색상
                    spreadRadius: 0, // 그림자 퍼짐 정도
                    blurRadius: 4, // 그림자 흐림 정도
                    offset: Offset(0, 4), // 그림자 위치 (x, y)
                  ),
                ],
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('뒤로 가기'),
            ),
          ],
        ),
      ),
    ),
  );
}
}