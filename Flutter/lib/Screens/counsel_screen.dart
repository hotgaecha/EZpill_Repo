import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class CounselScreen extends StatelessWidget {
  const CounselScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "1:1 상담"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/icons/free-icon-time-5861879.png",
              width: 300,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            "모든 약사님들이 상담 중이에요..",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'NanumSquare',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
