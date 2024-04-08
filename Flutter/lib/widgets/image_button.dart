import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final String ingredientName;
  final dynamic ingredientImage;
  final String? ingredientText;
  final Color? buttonColor;

  const ImageButton({
    Key? key, // key 추가
    required this.ingredientName,
    required this.ingredientImage,
    this.ingredientText,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [
      Container(
        width: 100,
        height: 100,
        decoration: ShapeDecoration(
          color: buttonColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
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
      ),
    ];

    if (ingredientText == null) {
      stackChildren.add(
        Positioned(
          bottom: 20,
          left: 8,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(ingredientImage),
            ),
          ),
        ),
      );
      stackChildren.add(
        Positioned(
          top: 12,
          right: 16,
          child: Text(
            ingredientName,
            style: TextStyle(
              color: Colors.black,
              fontSize: (ingredientName.length > 3 ? 20 : 25),
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      );
    } else {
      stackChildren.add(
        Positioned(
          top: 10,
          left: 10,
          child: Text(
            ingredientText!,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12,
              fontFamily: 'NanumSquare',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      );
      stackChildren.add(
        Positioned(
          bottom: 16,
          right: 16,
          child: Text(
            ingredientName,
            style: TextStyle(
              color: Colors.black,
              fontSize: (ingredientName.length > 3 ? 20 : 25),
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      );
      stackChildren.add(
        Positioned(
          bottom: 20,
          left: 8,
          child: SizedBox(
            width: 48,
            height: 48,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(ingredientImage),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: stackChildren,
    );
  }
}
