import 'package:flutter/material.dart';

class LikedPillListWidget extends StatelessWidget {
  final List likedPills;

  const LikedPillListWidget({
    Key? key, // 수정된 부분: Key 타입으로 변경
    required this.likedPills,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          likedPills.isNotEmpty
              ? 'Liked Pills: ${likedPills.join(', ')}'
              : 'No liked pills',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
