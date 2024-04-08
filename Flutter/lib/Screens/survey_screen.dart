import 'package:ezpill/auth/kakao_login.dart';
import 'package:ezpill/auth/main_view_model.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:ezpill/widgets/input_answer_widget.dart';
import 'package:flutter/material.dart';

class SurveyScreen extends StatefulWidget {
  final String kakaoUid;
  final String firebaseUid;

  const SurveyScreen({
    Key? key,
    required this.kakaoUid,
    required this.firebaseUid,
  }) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(screentitle: "맞춤 영양제 추천"),
        ),
        body: InputAnswerWidget(
            kakaoUid: widget.kakaoUid, firebaseUid: widget.firebaseUid));
  }
}
