import 'package:flutter/material.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:ezpill/widgets/google_map_widget.dart';

class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "주변 약국"),
      ),
      body: Stack(
        children: [
          const GoogleMapWidget(),
          Container(
            width: double.maxFinite,
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xfff9b53a),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 48,
                    height: 48,
                    child: Image.asset(
                        'assets/icons/free-icon-hourglass-7400604.png')),
                const SizedBox(
                  width: 10,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '근처 약국을 검색 중이에요..',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontFamily: 'NanumSquare',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      '현재 위치 : 단국대학교',
                      style: TextStyle(
                        color: Colors.white,
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
        ],
      ),
    );
  }
}
