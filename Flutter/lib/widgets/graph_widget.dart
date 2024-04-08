import 'package:flutter/material.dart';
import 'dart:math';

class GraphWidget extends StatelessWidget {
  final String ingredientName;
  final double recommendedIntake;
  final double currentIntake;
  final double upperIntake;

  const GraphWidget({
    super.key,
    required this.ingredientName,
    required this.recommendedIntake,
    required this.currentIntake,
    required this.upperIntake,
  });

  String formatLargeNumber(double value) {
    if (value >= 100000000) {
      // If the value is 100 million or more, use '억'
      return '${(value / 100000000).toStringAsFixed(1)}억';
    } else if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}백만';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}천';
    } else {
      return value.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 계산된 바의 너비가 210을 초과하지 않도록 하는 로직입니다.
    double barWidth = min(currentIntake / upperIntake * 210, 210);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                ingredientName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontFamily: 'NanumSquare',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
            Text(
              '권장 섭취량 : ${formatLargeNumber(recommendedIntake)}mg',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontFamily: 'NanumSquare',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Row(
              children: [
                Text(
                  '섭취 상한선',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'NanumSquare',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Stack(
              children: [
                Container(
                  width: 210,
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD9D9D9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: barWidth, // 수정된 바의 너비
                  height: 20,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF9B53A),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      '${formatLargeNumber(currentIntake)}mg', // 큰 수도 처리
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'NanumSquare',
                        fontWeight: FontWeight.w800,
                        height: 0,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Text(
                  '${formatLargeNumber(upperIntake)}mg', // 큰 수도 처리
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'NanumSquare',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
