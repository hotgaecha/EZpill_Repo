import 'package:ezpill/Screens/login_screen.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirstLoadingScreen();
  }
}

class FirstLoadingScreen extends StatelessWidget {
  const FirstLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '매일매일 나를 위한',
                    style: TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '나만의 영양제',
                    style: TextStyle(
                      fontFamily: "NanumSquare",
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xfff9b53a),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Transform.scale(
                    scale: 1,
                    child: Transform.translate(
                      offset: const Offset(60, 0),
                      child: Image.asset(
                        "assets/icons/icon1.png",
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xfff9b53a),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffdfe0df),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffdfe0df),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SecondLoadingScreen(),
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
                      "다음",
                      style: TextStyle(
                          fontFamily: "Gmarket Sans TTF",
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SecondLoadingScreen extends StatelessWidget {
  const SecondLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '내 아이는 물론이고,',
                    style: TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '엄마까지 건강하게',
                    style: TextStyle(
                      fontFamily: "NanumSquare",
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffff54ba),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Transform.scale(
                    scale: 1,
                    child: Transform.translate(
                      offset: const Offset(60, 0),
                      child: Image.asset(
                        "assets/icons/icon2.png",
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffdfe0df),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffff54ba),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffdfe0df),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ThirdLoadingScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffff54ba),
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
                      "다음",
                      style: TextStyle(
                          fontFamily: "Gmarket Sans TTF",
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ThirdLoadingScreen extends StatelessWidget {
  const ThirdLoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 150, 30, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '한 달마다 현관 앞에',
                    style: TextStyle(
                        fontFamily: "NanumSquare",
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '배송비 걱정 없이',
                    style: TextStyle(
                      fontFamily: "NanumSquare",
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff00c6fc),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Transform.scale(
                    scale: 1,
                    child: Transform.translate(
                      offset: const Offset(60, 0),
                      child: Image.asset(
                        "assets/icons/icon3.png",
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffdfe0df),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xffdfe0df),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.circle,
                      size: 10,
                      color: Color(0xff00c6fc),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xff00c6fc),
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
                      "다음",
                      style: TextStyle(
                          fontFamily: "Gmarket Sans TTF",
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
