import 'dart:async';

import 'package:flutter/material.dart';

class AD extends StatefulWidget {
  const AD({super.key});

  @override
  State<AD> createState() => _ADState();
}

class _ADState extends State<AD> {
  late Timer timer;

  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        int currentPage = controller.page!.toInt();
        int nextPage = currentPage + 1;

        if (nextPage > 2) {
          nextPage = 0;
        }

        controller.animateToPage(nextPage,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: controller,
          children: [0, 1, 2]
              .map((e) => Container(
                    width: 360,
                    height: 240,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/AdImage$e.png"),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(15),
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
                  ))
              .toList()),
    );
  }
}
