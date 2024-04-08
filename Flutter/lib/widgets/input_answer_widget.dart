import 'dart:async';
import 'dart:convert';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:ezpill/Screens/recommend_screen.dart';
import 'package:ezpill/widgets/image_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InputAnswerWidget extends StatefulWidget {
  final String kakaoUid;
  final String firebaseUid;

  const InputAnswerWidget({
    Key? key,
    required this.firebaseUid,
    required String kakaoUid,
  })  : kakaoUid = 'kakao:$kakaoUid',
        super(key: key);

  @override
  State<InputAnswerWidget> createState() => _InputAnswerWidgetState();
}

class _InputAnswerWidgetState extends State<InputAnswerWidget> {
  @override
  void initState() {
    super.initState();
  }

  int _step = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _pregnancyWeekController =
      TextEditingController();

  final List<String> _selectedSupplements = [];
  final List<Map<String, dynamic>> _supplements = [
    {
      'name': '엽산',
      'value': false,
      'image': "assets/icons/free-icon-carrot-1628768.png",
      'text': "면역력에\n도움을 주는",
    },
    {
      'name': '칼슘',
      'value': false,
      'image': "assets/icons/free-icon-milk-products-8708829.png",
      'text': "튼튼한 뼈와\n치아를 위한",
    },
    {
      'name': '철분',
      'value': false,
      'image': "assets/icons/free-icon-meat-2339945.png",
      'text': "빈혈 예방과\n면역력을 위한",
    },
    {
      'name': '비타민D',
      'value': false,
      'image': "assets/icons/free-icon-sun-5892536.png",
      'text': "햇빛이 필요한\n엄마들을 위해",
    },
    {
      'name': '오메가3',
      'value': false,
      'image': "assets/icons/free-icon-fish-1907083.png",
      'text': "건강한 눈과\n혈행개선을 위한",
    },
  ];

// 클래스 내 변수 섹션에 약품 관련 리스트 추가
  final List<String> _selectedMedications = [];
  final List<Map<String, dynamic>> _medications = [
    {
      'name': '혈액\n희석제',
      'value': false,
      'image': "assets/icons/free-icon-blood-cells-7357167.png"
    },
    {
      'name': '항경련제',
      'value': false,
      'image': "assets/icons/free-icon-difficulties-10157970.png"
    },
    {
      'name': '항생제',
      'value': false,
      'image': "assets/icons/free-icon-antibiotics-4977836.png"
    },
    {
      'name': '디곡신',
      'value': false,
      'image': "assets/icons/free-icon-heart-8981043.png"
    },
    {
      'name': '비스포스\n포네이트',
      'value': false,
      'image': "assets/icons/free-icon-bone-1581650.png"
    },
    {
      'name': '이뇨제',
      'value': false,
      'image': "assets/icons/free-icon-urine-test-2679312.png"
    },
    {
      'name': '골다공증\n치료제',
      'value': false,
      'image': "assets/icons/free-icon-bone-8981015.png"
    },
  ];

  final List<String> _selectedAllergies = [];
  final List<Map<String, dynamic>> _allergies = [
    {
      'name': '어류',
      'value': false,
      'image': 'assets/icons/free-icon-fish-1907083.png',
    },
    {
      'name': '유제품',
      'value': false,
      'image': 'assets/icons/free-icon-milk-products-8708829.png',
    },
    {
      'name': '콜라겐',
      'value': false,
      'image': 'assets/icons/free-icon-massage-5362182.png',
    },
    {
      'name': '루테인',
      'value': false,
      'image': 'assets/icons/free-icon-eye-822102.png',
    },
  ];

  final List<String> _selectedChronicDiseases = [];
  final List<Map<String, dynamic>> _chronicDiseases = [
    {
      'name': '당뇨',
      'value': false,
      'image': 'assets/icons/free-icon-diabetes-9867908.png',
    },
    {
      'name': '고혈압',
      'value': false,
      'image': 'assets/icons/free-icon-blood-pressure-6181722.png',
    },
    {
      'name': '심장병',
      'value': false,
      'image': 'assets/icons/free-icon-ecg-monitor-9593670.png',
    },
    {
      'name': '비만',
      'value': false,
      'image': 'assets/icons/free-icon-weight-6567398.png',
    },
    {
      'name': '간경화',
      'value': false,
      'image': 'assets/icons/free-icon-liver-3390248.png',
    },
    {
      'name': '류마티스\n관절염',
      'value': false,
      'image': 'assets/icons/free-icon-osteochondrosis-10368793.png',
    },
  ];

  final List<String> _selectedHealthConcerns = [];
  final List<Map<String, dynamic>> _healthConcerns = [
    {
      'name': '장 건강',
      'value': false,
      'image': 'assets/icons/free-icon-intestine-6147731.png',
    },
    {
      'name': '눈 건강',
      'value': false,
      'image': 'assets/icons/free-icon-eye-822102.png',
    },
    {
      'name': '피부',
      'value': false,
      'image': 'assets/icons/free-icon-massage-5362182.png',
    },
    {
      'name': '피로감',
      'value': false,
      'image': 'assets/icons/free-icon-laziness-10368908.png',
    },
    {
      'name': '근육 경련',
      'value': false,
      'image': 'assets/icons/free-icon-difficulties-10157970.png',
    },
  ];

  final List<String> _selectedInvestment = [];
  final List<Map<String, dynamic>> _investments = [
    {
      'name': 'C커피\n1500',
      'value': false,
      'image': 'assets/icons/letter-c.png',
    },
    {
      'name': 'M커피\n2000',
      'value': false,
      'image': 'assets/icons/letter-m.png',
    },
    {
      'name': '별다방\n4500',
      'value': false,
      'image': 'assets/icons/star.png',
    },
  ];

  Future<Map<String, dynamic>> callLambdaFunction() async {
    const url =
        'https://gi7wm7a8ha.execute-api.ap-northeast-2.amazonaws.com/default/lambda-with-rds';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            {'firebase_uid': widget.kakaoUid}), // Lambda 함수에 firebase_uid 전달
      );
      if (response.statusCode == 200) {
        return json.decode(response.body); // JSON 응답을 Map으로 변환합니다.
      } else {
        print('Failed to call lambda function: ${response.body}');
        return {'error': 'Failed to call lambda function'};
      }
    } catch (e) {
      print('Error calling lambda function: $e');
      return {'error': 'Error calling lambda function'};
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthDateController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _pregnancyWeekController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now(); // 기본값 설정

    Completer<DateTime?> completer = Completer<DateTime?>(); // Completer 추가

    try {
      BottomPicker.date(
        title: '생년월일을 입력해주세요.',
        dateOrder: DatePickerDateOrder.ymd, // 년, 월, 일 순서로 변경

        pickerTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        titleStyle: const TextStyle(
          color: Colors.black,
        ),
        onSubmit: (value) {
          if (value != null) {
            setState(() {
              selectedDate = value;
              _birthDateController.text =
                  DateFormat('yyyy-MM-dd').format(selectedDate);
            });
          }
          completer.complete(value); // Completer 완료
        },
        bottomPickerTheme: BottomPickerTheme.orange,
      ).show(context);

      await completer.future; // Completer의 future를 await
    } catch (e) {
      print('날짜 선택 중 오류 발생: $e');
    }
  }

  Future<void> submitSurvey() async {
    final response = await http.post(
      Uri.parse(
          'http://ec2-13-209-244-84.ap-northeast-2.compute.amazonaws.com/surveyresponses/submit/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'firebase_uid': widget.kakaoUid,
        'name': _nameController.text,
        'birth_date': _birthDateController.text,
        'height': int.tryParse(_heightController.text),
        'weight': int.tryParse(_weightController.text),
        'pregnancy_week': int.tryParse(_pregnancyWeekController.text),
        'supplements': _selectedSupplements.join(', '),
        'medications': _selectedMedications.join(', '),
        'allergies': _selectedAllergies.join(', '),
        'chronic_diseases': _selectedChronicDiseases.join(', '),
        'health_concerns': _selectedHealthConcerns.join(', '),
        'investment': _selectedInvestment.join(', ')
      }),
    );

    if (response.statusCode == 200) {
      // 성공적으로 전송되었을 때 처리
      print('Survey submitted successfully');
    } else {
      // 오류 처리
      print('Failed to submit survey: ${response.body}');
    }
  }

  void _nextStep() async {
    // 입력 검증 부분
    if (_step == 1 && _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('이름을 입력해주세요.'),
      ));
      return;
    }
    if (_step == 2 && _birthDateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('생년월일을 입력해주세요.'),
      ));
      return;
    }
    if (_step == 3 && _heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('키를 입력해주세요.'),
      ));
      return;
    }
    if (_step == 4 && _weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('임신 전 몸무게를 입력해주세요.'),
      ));
      return;
    }
    if (_step == 5 && _pregnancyWeekController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('임신 몇 주차이신가요?'),
      ));
      return;
    }
    if (_step == 10 && _selectedHealthConcerns.length > 3) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('건강고민은 최대 세 가지까지만 선택해주세요.'),
      ));
      return;
    }

    // 상태 업데이트 부분
    if (_step < 11) {
      setState(() {
        _step++;
      });
    } else if (_step == 11) {
      // 투자 금액이 선택되었는지 확인
      if (_selectedInvestment.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('가격을 입력해주세요.'),
        ));
        return;
      }

      await submitSurvey();
      setState(() {
        _step = 12;
      });
    } else if (_step == 12) {
      Map<String, dynamic> lambdaResponse = await callLambdaFunction();
      String name = lambdaResponse['name'] ?? 'Unknown';
      String recommendation =
          lambdaResponse['recommendation'] ?? 'No recommendation';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendScreen(
            name: name,
            recommendation: recommendation,
            firebaseUid: widget.kakaoUid, // kakaoUid를 RecommendScreen에 전달
            kakaoUid: widget.kakaoUid,
          ),
        ),
      );
      // 초기화 로직
      _selectedSupplements.clear();
      _selectedAllergies.clear();
      _selectedChronicDiseases.clear();
      _selectedHealthConcerns.clear();
      _selectedInvestment.clear();
      setState(() {
        _step = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(30, 90, 30, 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            child: _step == 0
                ? const Text(
                    '\n맞춤 영양제를 구성해드릴게요.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        height: 1.2),
                  )
                : _step == 1
                    ? const Text(
                        '성함을 입력해주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "NanumSquare",
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : _step == 2
                        ? const Text(
                            '생년월일을 입력해주세요.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "NanumSquare",
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : _step == 3
                            ? const Text(
                                '키를 입력해주세요.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "NanumSquare",
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : _step == 4
                                ? const Text(
                                    '임신 전 몸무게를 입력해주세요.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "NanumSquare",
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : _step == 5
                                    ? const Text(
                                        '임신 몇 주차이신가요?',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "NanumSquare",
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : _step == 6
                                        ? const Text(
                                            '아래 영양제 중에\n드시고 있는 영양제가 있나요?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "NanumSquare",
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              height: 1.2,
                                            ),
                                          )
                                        : _step == 7
                                            ? const Text(
                                                '드시고 있는 약이 있나요?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: "NanumSquare",
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ) // 새로운 단계 추가
                                            : _step == 8
                                                ? const Text(
                                                    '어류나 유제품에 대한\n알러지가 있나요?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: "NanumSquare",
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                : _step == 9
                                                    ? const Text(
                                                        '지병이나 만성질환이 있나요?',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "NanumSquare",
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      )
                                                    : _step == 10
                                                        ? const Text(
                                                            '가장 큰 건강고민을\n세 가지까지 골라주세요.',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "NanumSquare",
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          )
                                                        : _step == 11
                                                            ? const Text(
                                                                '나의 건강에 매일 얼마까지 투자할 수 있나요?',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "NanumSquare",
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )
                                                            : const SizedBox(
                                                                width: 0,
                                                              ),
          ),

          if (_step > 0 && _step < 6)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: _step == 1
                  ? TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '여기에 입력해주세요!',
                      ),
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : _step == 2
                      ? InkWell(
                          onTap: () => _selectDate(context),
                          child: IgnorePointer(
                            child: TextField(
                              controller: _birthDateController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '생년월일',
                                hintText: 'YYYY-MM-DD',
                              ),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        )
                      : _step == 3
                          ? TextField(
                              controller: _heightController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '키를 입력해주세요.',
                                hintText: 'cm',
                              ),
                              keyboardType: TextInputType.number,
                            )
                          : _step == 4
                              ? TextField(
                                  controller: _weightController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '몸무게를 입력해주세요.',
                                    hintText: 'kg',
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                              : TextField(
                                  controller: _pregnancyWeekController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: '임신주차를 입력해주세요.',
                                    hintText: '주',
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
            ),
          // 드시고 있는 영양제에 대한 체크박스 리스트
          if (_step == 6)
            SizedBox(
              height: 320,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 3개의 요소를 표시
                  crossAxisSpacing: 5, // 수평 간격
                  mainAxisSpacing: 5, // 수직 간격
                  childAspectRatio: 1, // 아이템의 가로 세로 비율
                ),
                itemCount: _supplements.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _supplements[index]['value'] =
                            !_supplements[index]['value'];
                        if (_supplements[index]['value']) {
                          _selectedSupplements.add(_supplements[index]['name']);
                        } else {
                          _selectedSupplements
                              .remove(_supplements[index]['name']);
                        }
                        print(_selectedSupplements);
                      });
                    },
                    child: ImageButton(
                      ingredientName: _supplements[index]['name'],
                      ingredientImage: _supplements[index]['image'],
                      ingredientText: _supplements[index]['text'],
                      buttonColor: _supplements[index]['value']
                          ? Colors.grey.shade200
                          : Colors.white,
                    ),
                  );
                },
              ),
            ),
          // 새로운 단계: 드시고 있는 약에 대한 체크박스 리스트
          if (_step == 7)
            SizedBox(
              height: 320,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 3개의 요소를 표시
                  crossAxisSpacing: 5, // 수평 간격
                  mainAxisSpacing: 5, // 수직 간격
                  childAspectRatio: 1, // 아이템의 가로 세로 비율
                ),
                itemCount: _medications.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _medications[index]['value'] =
                            !_medications[index]['value'];
                        if (_medications[index]['value']) {
                          _selectedMedications.add(_medications[index]['name']);
                        } else {
                          _selectedMedications
                              .remove(_medications[index]['name']);
                        }
                        print(_selectedMedications);
                      });
                    },
                    child: ImageButton(
                      ingredientName: _medications[index]['name'],
                      ingredientImage: _medications[index]['image'],
                      ingredientText: _medications[index]['text'],
                      buttonColor: _medications[index]['value']
                          ? Colors.grey.shade200
                          : Colors.white,
                    ),
                  );
                },
              ),
            ),
          // 이후의 단계들 업데이트
          if (_step == 8)
            SizedBox(
              height: 300,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 3개의 요소를 표시
                  crossAxisSpacing: 5, // 수평 간격
                  mainAxisSpacing: 5, // 수직 간격
                  childAspectRatio: 1, // 아이템의 가로 세로 비율
                ),
                itemCount: _allergies.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _allergies[index]['value'] =
                            !_allergies[index]['value'];
                        if (_allergies[index]['value']) {
                          _selectedAllergies.add(_allergies[index]['name']);
                        } else {
                          _selectedAllergies.remove(_allergies[index]['name']);
                        }
                        print(_selectedAllergies);
                      });
                    },
                    child: ImageButton(
                      ingredientName: _allergies[index]['name'],
                      ingredientImage: _allergies[index]['image'],
                      ingredientText: null,
                      buttonColor: _allergies[index]['value']
                          ? Colors.grey.shade300
                          : Colors.white,
                    ),
                  );
                },
              ),
            ),
          if (_step == 9)
            SizedBox(
              height: 320,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 한 줄에 3개의 요소를 표시
                  crossAxisSpacing: 5, // 수평 간격
                  mainAxisSpacing: 5, // 수직 간격
                  childAspectRatio: 1, // 아이템의 가로 세로 비율
                ),
                itemCount: _chronicDiseases.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _chronicDiseases[index]['value'] =
                            !_chronicDiseases[index]['value'];
                        if (_chronicDiseases[index]['value']) {
                          _selectedChronicDiseases
                              .add(_chronicDiseases[index]['name']);
                        } else {
                          _selectedChronicDiseases
                              .remove(_chronicDiseases[index]['name']);
                        }
                        print(_selectedChronicDiseases);
                      });
                    },
                    child: ImageButton(
                      ingredientName: _chronicDiseases[index]['name'],
                      ingredientImage: _chronicDiseases[index]['image'],
                      ingredientText: null,
                      buttonColor: _chronicDiseases[index]['value']
                          ? Colors.grey.shade300
                          : Colors.white,
                    ),
                  );
                },
              ),
            ),
          if (_step == 10)
            SizedBox(
              height: 320,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: _healthConcerns.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        bool currentValue = _healthConcerns[index]['value'];

                        if (_selectedHealthConcerns.length < 3 ||
                            currentValue) {
                          _healthConcerns[index]['value'] = !currentValue;

                          if (currentValue) {
                            _selectedHealthConcerns
                                .remove(_healthConcerns[index]['name']);
                          } else {
                            _selectedHealthConcerns
                                .add(_healthConcerns[index]['name']);
                          }
                        }
                      });
                    },
                    child: ImageButton(
                      ingredientName: _healthConcerns[index]['name'],
                      ingredientImage: _healthConcerns[index]['image'],
                      ingredientText: null,
                      buttonColor: _healthConcerns[index]['value']
                          ? Colors.grey.shade300
                          : Colors.white,
                    ),
                  );
                },
              ),
            ),
          if (_step == 11)
            SizedBox(
              height: 320,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1,
                ),
                itemCount: _investments.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        bool currentValue = _investments[index]['value'];

                        if (!currentValue) {
                          // 현재 선택되어 있지 않은 경우에만 처리
                          for (var item in _investments) {
                            item['value'] = false; // 모든 항목의 선택 취소
                          }

                          _investments[index]['value'] = true;
                          _selectedInvestment.clear();
                          _selectedInvestment
                              .add(_investments[index]['name'].split('\n')[1]);
                        }
                        print(_selectedInvestment);
                      });
                    },
                    child: ImageButton(
                      ingredientName: _investments[index]['name'],
                      ingredientImage: _investments[index]['image'],
                      ingredientText: null,
                      buttonColor: _investments[index]['value']
                          ? Colors.grey.shade300
                          : Colors.white,
                    ),
                  );
                },
              ),
            ),
          if (_step == 12)
            const Text(
              '맞춤 영양제를 구성 중입니다...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "NanumSquare",
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
          GestureDetector(
            onTap: () {
              _nextStep();
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
              child: Text(
                _step < 11 ? '다음' : (_step == 11 ? '제출하기' : '결과보기'),
                style: const TextStyle(
                    fontFamily: "Gmarket Sans TTF",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
