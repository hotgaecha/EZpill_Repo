import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'pill_list_screen.dart';
import 'ingredient_list_screen.dart'; // 필요한 영양제 목록을 위한 import

class StressListScreen extends StatefulWidget {
  const StressListScreen({Key? key}) : super(key: key);

  @override
  _StressListScreenState createState() => _StressListScreenState();
}

class _StressListScreenState extends State<StressListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();
  bool _isAnalyzing = false;

  // 사용자의 채팅 메시지를 저장하는 리스트
  List<Map<String, String>> chatMessages = [];
  String? systemResponse; // null로 초기화

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "고민으로 검색하기"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: chatMessages.length +
                    (_isAnalyzing
                        ? 0
                        : (systemResponse != null
                            ? 1
                            : 0)), // systemResponse가 null이 아니면 1 추가
                itemBuilder: (context, index) {
                  if (index < chatMessages.length) {
                    // 채팅 메시지 출력
                    final message = chatMessages[index];
                    final isUser = message['type'] == 'user';

                    return Padding(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        left: isUser ? 120.0 : 8.0,
                        right: isUser ? 8.0 : 50.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isUser
                              ? const Color(0xfff9b53a)
                              : const Color(0xffdfe0df),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: 250.0,
                        ),
                        width: message['message']!.length *
                            8.0, // 예시로 조절, 실제로는 상황에 맞게 조절
                        child: Align(
                          alignment:
                              isUser ? Alignment.topRight : Alignment.topLeft,
                          child: Text(
                            message['message']!,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'NanumGothic',
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    // _isAnalyzing이 false이면서 systemResponse가 null이 아니면 버튼 출력
                    return !_isAnalyzing && systemResponse != null
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 250.0,
                              ),
                              child: _buildNutrientButtons(),
                            ),
                          )
                        : Container(); // _isAnalyzing이 true이거나 systemResponse가 null이면 빈 컨테이너 반환
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                border: Border.all(color: Colors.black.withOpacity(0.25)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            hintText: '어떤 고민이 있으신가요?',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: _isAnalyzing ? null : () => _processInput(),
                          child: Image.asset(
                            _isAnalyzing
                                ? "assets/icons/free-icon-sending-1168700.png"
                                : "assets/icons/free-icon-sending-1168578.png",
                            width: 60,
                            height: 60,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _processInput() async {
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        chatMessages.add({
          'type': 'user',
          'message': _textEditingController.text,
        });
        _isAnalyzing = true;
      });

      final response = await http.post(
        Uri.parse(
          'http://ec2-15-165-33-226.ap-northeast-2.compute.amazonaws.com:5000/analyze',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'input': _textEditingController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          chatMessages.add({
            'type': 'system',
            'message': responseBody['response'],
          });
          systemResponse = responseBody['response']; // systemResponse 업데이트
        });
      } else {
        setState(() {
          chatMessages.add({
            'type': 'system',
            'message': '응답을 가져오는데 실패했습니다.',
          });
        });
      }

      _textEditingController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

      setState(() {
        _isAnalyzing = false;
      });
    }
  }

  // 시스템 응답에서 영양제를 추출하여 버튼들을 생성하는 함수
  Widget _buildNutrientButtons() {
    List<String> resultLines = systemResponse!.split('\n');
    String nutrientsLine =
        resultLines.last.contains('필요한 영양제:') ? resultLines.removeLast() : '';
    List<String> nutrients = nutrientsLine.isNotEmpty
        ? nutrientsLine.split(':')[1].split(', ').map((e) => e.trim()).toList()
        : [];

    if (nutrients.isNotEmpty) {
      return Wrap(
        spacing: 8.0, // 수평 간격
        runSpacing: 4.0, // 수직 간격
        children: nutrients
            .map((nutrient) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // 버튼의 텍스트 색상
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          color: Color(0xfff9b53a),
                          width: 2), // 수정된 부분: 테두리 색 및 두께 조정
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    String trimmedNutrient = nutrient.trim();
                    print('선택한 영양제: $trimmedNutrient');
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PillListScreen(trimmedNutrient),
                    ));
                  },
                  child: Text(
                    nutrient,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Gmarket Sans TTF',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ))
            .toList(),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white, // 버튼의 텍스트 색상
          shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color(0xfff9b53a), width: 2), // 수정된 부분: 테두리 색 및 두께 조정
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          // 영양제가 없는 경우 IngredientListScreen으로 이동
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const IngredientListScreen(),
          ));
        },
        child: const Text(
          '성분으로 검색하기',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Gmarket Sans TTF',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Stress Analysis',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: const StressListScreen(),
  ));
}
