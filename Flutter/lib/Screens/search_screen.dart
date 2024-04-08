import 'package:ezpill/Screens/ingredient_list_screen.dart';
import 'package:ezpill/Screens/stress_list_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "영양제 검색"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 3,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                              "assets/icons/free-icon-molecule-5969230.png"),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 16,
                      child: SizedBox(
                        width: 92,
                        child: Text(
                          '검색하기',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        '성분으로',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumSquare',
                          fontWeight: FontWeight.w800,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IngredientListScreen(),
                    ),
                  );
                },
              ),
              GestureDetector(
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 3,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.asset(
                              "assets/icons/free-icon-overthinking-7021107.png"),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 16,
                      child: SizedBox(
                        width: 92,
                        child: Text(
                          '검색하기',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18,
                            fontFamily: 'NanumSquare',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        '고민으로',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'NanumSquare',
                          fontWeight: FontWeight.w800,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StressListScreen()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
