import 'package:ezpill/Screens/pill_list_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:ezpill/widgets/image_button.dart';
import 'package:flutter/material.dart';
import 'package:ezpill/Screens/calendar_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ezpill/Screens/survey_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_screen.dart';


var kakaoUid = '3162463219';
var firebaseUid = 'kakao:';


//날짜별 체크 상태를 추적하는 맵
Map<DateTime, bool> checkedDates = {};




class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

typedef OnDaySelected = void Function(
    DateTime selectedDay, DateTime focusedDay);

// selectedDay와 focusedDay 변수 선언 및 초기화
DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();

class Event {
  String title;

  bool isUserPerformedAction;

  Event(this.title, {this.isUserPerformedAction = false});
}

//마커 추가하려면 아래에 정보를 입력해야함.
Map<DateTime, List<Event>> events = {
  DateTime.utc(2023, 10, 1): [Event('title')],
  DateTime.utc(2023, 10, 2): [Event('title')],
  DateTime.utc(2023, 10, 3): [Event('title')],
  DateTime.utc(2023, 10, 4): [Event('title')],
  DateTime.utc(2023, 10, 5): [Event('title')],
  DateTime.utc(2023, 10, 6): [Event('title')],
  DateTime.utc(2023, 10, 7): [Event('title')],
  DateTime.utc(2023, 10, 8): [Event('title')],
  DateTime.utc(2023, 10, 9): [Event('title')],
  DateTime.utc(2023, 10, 10): [Event('title')],
  DateTime.utc(2023, 10, 11): [Event('title')],
  DateTime.utc(2023, 10, 12): [Event('title')],
  DateTime.utc(2023, 10, 13): [Event('title')],
  DateTime.utc(2023, 10, 14): [Event('title')],
  DateTime.utc(2023, 10, 15): [Event('title')],
  DateTime.utc(2023, 10, 16): [Event('title')],
  DateTime.utc(2023, 10, 17): [Event('title')],
  DateTime.utc(2023, 10, 18): [Event('title')],
  DateTime.utc(2023, 10, 19): [Event('title')],
  DateTime.utc(2023, 10, 20): [Event('title')],
  DateTime.utc(2023, 10, 21): [Event('title')],
  DateTime.utc(2023, 10, 22): [Event('title')],
  DateTime.utc(2023, 10, 23): [Event('title')],
  DateTime.utc(2023, 10, 24): [Event('title')],
  DateTime.utc(2023, 10, 25): [Event('title')],
  DateTime.utc(2023, 10, 26): [Event('title')],
  DateTime.utc(2023, 10, 27): [Event('title')],
  DateTime.utc(2023, 10, 28): [Event('title')],
  DateTime.utc(2023, 10, 29): [Event('title')],
  DateTime.utc(2023, 10, 30): [Event('title')],
  DateTime.utc(2023, 10, 31): [Event('title')],
  DateTime.utc(2023, 11, 1): [Event('title')],
  DateTime.utc(2023, 11, 2): [Event('title')],
  DateTime.utc(2023, 11, 3): [Event('title')],
  DateTime.utc(2023, 11, 4): [Event('title')],
  DateTime.utc(2023, 11, 5): [Event('title')],
  DateTime.utc(2023, 11, 6): [Event('title')],
  DateTime.utc(2023, 11, 7): [Event('title')],
  DateTime.utc(2023, 11, 8): [Event('title')],
  DateTime.utc(2023, 11, 9): [Event('title')],
  DateTime.utc(2023, 11, 10): [Event('title')],
  DateTime.utc(2023, 11, 11): [Event('title')],
  DateTime.utc(2023, 11, 12): [Event('title')],
  DateTime.utc(2023, 11, 13): [Event('title')],
  DateTime.utc(2023, 11, 14): [Event('title')],
  DateTime.utc(2023, 11, 15): [Event('title')],
  DateTime.utc(2023, 11, 16): [Event('title')],
  DateTime.utc(2023, 11, 17): [Event('title')],
  DateTime.utc(2023, 11, 18): [Event('title')],
  DateTime.utc(2023, 11, 19): [Event('title')],
  DateTime.utc(2023, 11, 20): [Event('title')],
  DateTime.utc(2023, 11, 21): [Event('title')],
  DateTime.utc(2023, 11, 22): [Event('title')],
  DateTime.utc(2023, 11, 23): [Event('title')],
  DateTime.utc(2023, 11, 24): [Event('title')],
  DateTime.utc(2023, 11, 25): [Event('title')],
  DateTime.utc(2023, 11, 26): [Event('title')],
  DateTime.utc(2023, 11, 27): [Event('title')],
  DateTime.utc(2023, 11, 28): [Event('title')],
  DateTime.utc(2023, 11, 29): [Event('title')],
  DateTime.utc(2023, 11, 30): [Event('title')],
  DateTime.utc(2023, 12, 1): [Event('title')],
  DateTime.utc(2023, 12, 2): [Event('title')],
  DateTime.utc(2023, 12, 3): [Event('title')],
  DateTime.utc(2023, 12, 4): [Event('title')],
  DateTime.utc(2023, 12, 5): [Event('title')],
  DateTime.utc(2023, 12, 6): [Event('title')],
  DateTime.utc(2023, 12, 7): [Event('title')],
  DateTime.utc(2023, 12, 8): [Event('title')],
  DateTime.utc(2023, 12, 9): [Event('title')],
  DateTime.utc(2023, 12, 10): [Event('title')],
  DateTime.utc(2023, 12, 11): [Event('title')],
  DateTime.utc(2023, 12, 12): [Event('title')],
  DateTime.utc(2023, 12, 13): [Event('title')],
  DateTime.utc(2023, 12, 14): [Event('title')],
  DateTime.utc(2023, 12, 15): [Event('title')],
  DateTime.utc(2023, 12, 16): [Event('title')],
  DateTime.utc(2023, 12, 17): [Event('title')],
  DateTime.utc(2023, 12, 18): [Event('title')],
  DateTime.utc(2023, 12, 19): [Event('title')],
  DateTime.utc(2023, 12, 20): [Event('title')],
  DateTime.utc(2023, 12, 21): [Event('title')],
  DateTime.utc(2023, 12, 22): [Event('title')],
  DateTime.utc(2023, 12, 23): [Event('title')],
  DateTime.utc(2023, 12, 24): [Event('title')],
  DateTime.utc(2023, 12, 25): [Event('title')],
  DateTime.utc(2023, 12, 26): [Event('title')],
  DateTime.utc(2023, 12, 27): [Event('title')],
  DateTime.utc(2023, 12, 28): [Event('title')],
  DateTime.utc(2023, 12, 29): [Event('title')],
  DateTime.utc(2023, 12, 30): [Event('title')],
  DateTime.utc(2023, 12, 31): [Event('title')],
  DateTime.utc(2024, 1, 1): [Event('title')],
  DateTime.utc(2024, 1, 2): [Event('title')],
  DateTime.utc(2024, 1, 3): [Event('title')],
  DateTime.utc(2024, 1, 4): [Event('title')],
  DateTime.utc(2024, 1, 5): [Event('title')],
  DateTime.utc(2024, 1, 6): [Event('title')],
  DateTime.utc(2024, 1, 7): [Event('title')],
  DateTime.utc(2024, 1, 8): [Event('title')],
  DateTime.utc(2024, 1, 9): [Event('title')],
  DateTime.utc(2024, 1, 10): [Event('title')],
  DateTime.utc(2024, 1, 11): [Event('title')],
  DateTime.utc(2024, 1, 12): [Event('title')],
  DateTime.utc(2024, 1, 13): [Event('title')],
  DateTime.utc(2024, 1, 14): [Event('title')],
  DateTime.utc(2024, 1, 15): [Event('title')],
  DateTime.utc(2024, 1, 16): [Event('title')],
  DateTime.utc(2024, 1, 17): [Event('title')],
  DateTime.utc(2024, 1, 18): [Event('title')],
  DateTime.utc(2024, 1, 19): [Event('title')],
  DateTime.utc(2024, 1, 20): [Event('title')],
  DateTime.utc(2024, 1, 21): [Event('title')],
  DateTime.utc(2024, 1, 22): [Event('title')],
  DateTime.utc(2024, 1, 23): [Event('title')],
  DateTime.utc(2024, 1, 24): [Event('title')],
  DateTime.utc(2024, 1, 25): [Event('title')],
  DateTime.utc(2024, 1, 26): [Event('title')],
  DateTime.utc(2024, 1, 27): [Event('title')],
  DateTime.utc(2024, 1, 28): [Event('title')],
  DateTime.utc(2024, 1, 29): [Event('title')],
  DateTime.utc(2024, 1, 30): [Event('title')],
  DateTime.utc(2024, 1, 31): [Event('title')],
  DateTime.utc(2024, 2, 1): [Event('title')],
  DateTime.utc(2024, 2, 2): [Event('title')],
  DateTime.utc(2024, 2, 3): [Event('title')],
  DateTime.utc(2024, 2, 4): [Event('title')],
  DateTime.utc(2024, 2, 5): [Event('title')],
  DateTime.utc(2024, 2, 6): [Event('title')],
  DateTime.utc(2024, 2, 7): [Event('title')],
  DateTime.utc(2024, 2, 8): [Event('title')],
  DateTime.utc(2024, 2, 9): [Event('title')],
  DateTime.utc(2024, 2, 10): [Event('title')],
  DateTime.utc(2024, 2, 11): [Event('title')],
  DateTime.utc(2024, 2, 12): [Event('title')],
  DateTime.utc(2024, 2, 13): [Event('title')],
  DateTime.utc(2024, 2, 14): [Event('title')],
  DateTime.utc(2024, 2, 15): [Event('title')],
  DateTime.utc(2024, 2, 16): [Event('title')],
  DateTime.utc(2024, 2, 17): [Event('title')],
  DateTime.utc(2024, 2, 18): [Event('title')],
  DateTime.utc(2024, 2, 19): [Event('title')],
  DateTime.utc(2024, 2, 20): [Event('title')],
  DateTime.utc(2024, 2, 21): [Event('title')],
  DateTime.utc(2024, 2, 22): [Event('title')],
  DateTime.utc(2024, 2, 23): [Event('title')],
  DateTime.utc(2024, 2, 24): [Event('title')],
  DateTime.utc(2024, 2, 25): [Event('title')],
  DateTime.utc(2024, 2, 26): [Event('title')],
  DateTime.utc(2024, 2, 27): [Event('title')],
  DateTime.utc(2024, 2, 28): [Event('title')],
  DateTime.utc(2024, 2, 29): [Event('title')],
  DateTime.utc(2024, 3, 1): [Event('title')],
  DateTime.utc(2024, 3, 2): [Event('title')],
  DateTime.utc(2024, 3, 3): [Event('title')],
  DateTime.utc(2024, 3, 4): [Event('title')],
  DateTime.utc(2024, 3, 5): [Event('title')],
  DateTime.utc(2024, 3, 6): [Event('title')],
  DateTime.utc(2024, 3, 7): [Event('title')],
  DateTime.utc(2024, 3, 8): [Event('title')],
  DateTime.utc(2024, 3, 9): [Event('title')],
  DateTime.utc(2024, 3, 10): [Event('title')],
  DateTime.utc(2024, 3, 11): [Event('title')],
  DateTime.utc(2024, 3, 12): [Event('title')],
  DateTime.utc(2024, 3, 13): [Event('title')],
  DateTime.utc(2024, 3, 14): [Event('title')],
  DateTime.utc(2024, 3, 15): [Event('title')],
  DateTime.utc(2024, 3, 16): [Event('title')],
  DateTime.utc(2024, 3, 17): [Event('title')],
  DateTime.utc(2024, 3, 18): [Event('title')],
  DateTime.utc(2024, 3, 19): [Event('title')],
  DateTime.utc(2024, 3, 20): [Event('title')],
  DateTime.utc(2024, 3, 21): [Event('title')],
  DateTime.utc(2024, 3, 22): [Event('title')],
  DateTime.utc(2024, 3, 23): [Event('title')],
  DateTime.utc(2024, 3, 24): [Event('title')],
  DateTime.utc(2024, 3, 25): [Event('title')],
  DateTime.utc(2024, 3, 26): [Event('title')],
  DateTime.utc(2024, 3, 27): [Event('title')],
  DateTime.utc(2024, 3, 28): [Event('title')],
  DateTime.utc(2024, 3, 29): [Event('title')],
  DateTime.utc(2024, 3, 30): [Event('title')],
  DateTime.utc(2024, 3, 31): [Event('title')],
  DateTime.utc(2024, 4, 1): [Event('title')],
  DateTime.utc(2024, 4, 2): [Event('title')],
  DateTime.utc(2024, 4, 3): [Event('title')],
  DateTime.utc(2024, 4, 4): [Event('title')],
  DateTime.utc(2024, 4, 5): [Event('title')],
  DateTime.utc(2024, 4, 6): [Event('title')],
  DateTime.utc(2024, 4, 7): [Event('title')],
  DateTime.utc(2024, 4, 8): [Event('title')],
  DateTime.utc(2024, 4, 9): [Event('title')],
  DateTime.utc(2024, 4, 10): [Event('title')],
  DateTime.utc(2024, 4, 11): [Event('title')],
  DateTime.utc(2024, 4, 12): [Event('title')],
  DateTime.utc(2024, 4, 13): [Event('title')],
  DateTime.utc(2024, 4, 14): [Event('title')],
  DateTime.utc(2024, 4, 15): [Event('title')],
  DateTime.utc(2024, 4, 16): [Event('title')],
  DateTime.utc(2024, 4, 17): [Event('title')],
  DateTime.utc(2024, 4, 18): [Event('title')],
  DateTime.utc(2024, 4, 19): [Event('title')],
  DateTime.utc(2024, 4, 20): [Event('title')],
  DateTime.utc(2024, 4, 21): [Event('title')],
  DateTime.utc(2024, 4, 22): [Event('title')],
  DateTime.utc(2024, 4, 23): [Event('title')],
  DateTime.utc(2024, 4, 24): [Event('title')],
  DateTime.utc(2024, 4, 25): [Event('title')],
  DateTime.utc(2024, 4, 26): [Event('title')],
  DateTime.utc(2024, 4, 27): [Event('title')],
  DateTime.utc(2024, 4, 28): [Event('title')],
  DateTime.utc(2024, 4, 29): [Event('title')],
  DateTime.utc(2024, 4, 30): [Event('title')],
  DateTime.utc(2024, 5, 1): [Event('title')],
  DateTime.utc(2024, 5, 2): [Event('title')],
  DateTime.utc(2024, 5, 3): [Event('title')],
  DateTime.utc(2024, 5, 4): [Event('title')],
  DateTime.utc(2024, 5, 5): [Event('title')],
  DateTime.utc(2024, 5, 6): [Event('title')],
  DateTime.utc(2024, 5, 7): [Event('title')],
  DateTime.utc(2024, 5, 8): [Event('title')],
  DateTime.utc(2024, 5, 9): [Event('title')],
  DateTime.utc(2024, 5, 10): [Event('title')],
  DateTime.utc(2024, 5, 11): [Event('title')],
  DateTime.utc(2024, 5, 12): [Event('title')],
  DateTime.utc(2024, 5, 13): [Event('title')],
  DateTime.utc(2024, 5, 14): [Event('title')],
  DateTime.utc(2024, 5, 15): [Event('title')],
  DateTime.utc(2024, 5, 16): [Event('title')],
  DateTime.utc(2024, 5, 17): [Event('title')],
  DateTime.utc(2024, 5, 18): [Event('title')],
  DateTime.utc(2024, 5, 19): [Event('title')],
  DateTime.utc(2024, 5, 20): [Event('title')],
  DateTime.utc(2024, 5, 21): [Event('title')],
  DateTime.utc(2024, 5, 22): [Event('title')],
  DateTime.utc(2024, 5, 23): [Event('title')],
  DateTime.utc(2024, 5, 24): [Event('title')],
  DateTime.utc(2024, 5, 25): [Event('title')],
  DateTime.utc(2024, 5, 26): [Event('title')],
  DateTime.utc(2024, 5, 27): [Event('title')],
  DateTime.utc(2024, 5, 28): [Event('title')],
  DateTime.utc(2024, 5, 29): [Event('title')],
  DateTime.utc(2024, 5, 30): [Event('title')],
  DateTime.utc(2024, 5, 31): [Event('title')],
  DateTime.utc(2024, 6, 1): [Event('title')],
  DateTime.utc(2024, 6, 2): [Event('title')],
  DateTime.utc(2024, 6, 3): [Event('title')],
  DateTime.utc(2024, 6, 4): [Event('title')],
  DateTime.utc(2024, 6, 5): [Event('title')],
  DateTime.utc(2024, 6, 6): [Event('title')],
  DateTime.utc(2024, 6, 7): [Event('title')],
  DateTime.utc(2024, 6, 8): [Event('title')],
  DateTime.utc(2024, 6, 9): [Event('title')],
  DateTime.utc(2024, 6, 10): [Event('title')],
  DateTime.utc(2024, 6, 11): [Event('title')],
  DateTime.utc(2024, 6, 12): [Event('title')],
  DateTime.utc(2024, 6, 13): [Event('title')],
  DateTime.utc(2024, 6, 14): [Event('title')],
  DateTime.utc(2024, 6, 15): [Event('title')],
  DateTime.utc(2024, 6, 16): [Event('title')],
  DateTime.utc(2024, 6, 17): [Event('title')],
  DateTime.utc(2024, 6, 18): [Event('title')],
  DateTime.utc(2024, 6, 19): [Event('title')],
  DateTime.utc(2024, 6, 20): [Event('title')],
  DateTime.utc(2024, 6, 21): [Event('title')],
  DateTime.utc(2024, 6, 22): [Event('title')],
  DateTime.utc(2024, 6, 23): [Event('title')],
  DateTime.utc(2024, 6, 24): [Event('title')],
  DateTime.utc(2024, 6, 25): [Event('title')],
  DateTime.utc(2024, 6, 26): [Event('title')],
  DateTime.utc(2024, 6, 27): [Event('title')],
  DateTime.utc(2024, 6, 28): [Event('title')],
  DateTime.utc(2024, 6, 29): [Event('title')],
  DateTime.utc(2024, 6, 30): [Event('title')],
  DateTime.utc(2024, 7, 1): [Event('title')],
  DateTime.utc(2024, 7, 2): [Event('title')],
  DateTime.utc(2024, 7, 3): [Event('title')],
  DateTime.utc(2024, 7, 4): [Event('title')],
  DateTime.utc(2024, 7, 5): [Event('title')],
  DateTime.utc(2024, 7, 6): [Event('title')],
  DateTime.utc(2024, 7, 7): [Event('title')],
  DateTime.utc(2024, 7, 8): [Event('title')],
  DateTime.utc(2024, 7, 9): [Event('title')],
  DateTime.utc(2024, 7, 10): [Event('title')],
  DateTime.utc(2024, 7, 11): [Event('title')],
  DateTime.utc(2024, 7, 12): [Event('title')],
  DateTime.utc(2024, 7, 13): [Event('title')],
  DateTime.utc(2024, 7, 14): [Event('title')],
  DateTime.utc(2024, 7, 15): [Event('title')],
  DateTime.utc(2024, 7, 16): [Event('title')],
  DateTime.utc(2024, 7, 17): [Event('title')],
  DateTime.utc(2024, 7, 18): [Event('title')],
  DateTime.utc(2024, 7, 19): [Event('title')],
  DateTime.utc(2024, 7, 20): [Event('title')],
  DateTime.utc(2024, 7, 21): [Event('title')],
  DateTime.utc(2024, 7, 22): [Event('title')],
  DateTime.utc(2024, 7, 23): [Event('title')],
  DateTime.utc(2024, 7, 24): [Event('title')],
  DateTime.utc(2024, 7, 25): [Event('title')],
  DateTime.utc(2024, 7, 26): [Event('title')],
  DateTime.utc(2024, 7, 27): [Event('title')],
  DateTime.utc(2024, 7, 28): [Event('title')],
  DateTime.utc(2024, 7, 29): [Event('title')],
  DateTime.utc(2024, 7, 30): [Event('title')],
  DateTime.utc(2024, 7, 31): [Event('title')],
  DateTime.utc(2024, 8, 1): [Event('title')],
  DateTime.utc(2024, 8, 2): [Event('title')],
  DateTime.utc(2024, 8, 3): [Event('title')],
  DateTime.utc(2024, 8, 4): [Event('title')],
  DateTime.utc(2024, 8, 5): [Event('title')],
  DateTime.utc(2024, 8, 6): [Event('title')],
  DateTime.utc(2024, 8, 7): [Event('title')],
  DateTime.utc(2024, 8, 8): [Event('title')],
  DateTime.utc(2024, 8, 9): [Event('title')],
  DateTime.utc(2024, 8, 10): [Event('title')],
  DateTime.utc(2024, 8, 11): [Event('title')],
  DateTime.utc(2024, 8, 12): [Event('title')],
  DateTime.utc(2024, 8, 13): [Event('title')],
  DateTime.utc(2024, 8, 14): [Event('title')],
  DateTime.utc(2024, 8, 15): [Event('title')],
  DateTime.utc(2024, 8, 16): [Event('title')],
  DateTime.utc(2024, 8, 17): [Event('title')],
  DateTime.utc(2024, 8, 18): [Event('title')],
  DateTime.utc(2024, 8, 19): [Event('title')],
  DateTime.utc(2024, 8, 20): [Event('title')],
  DateTime.utc(2024, 8, 21): [Event('title')],
  DateTime.utc(2024, 8, 22): [Event('title')],
  DateTime.utc(2024, 8, 23): [Event('title')],
  DateTime.utc(2024, 8, 24): [Event('title')],
  DateTime.utc(2024, 8, 25): [Event('title')],
  DateTime.utc(2024, 8, 26): [Event('title')],
  DateTime.utc(2024, 8, 27): [Event('title')],
  DateTime.utc(2024, 8, 28): [Event('title')],
  DateTime.utc(2024, 8, 29): [Event('title')],
  DateTime.utc(2024, 8, 30): [Event('title')],
  DateTime.utc(2024, 8, 31): [Event('title')],
  DateTime.utc(2024, 9, 1): [Event('title')],
  DateTime.utc(2024, 9, 2): [Event('title')],
  DateTime.utc(2024, 9, 3): [Event('title')],
  DateTime.utc(2024, 9, 4): [Event('title')],
  DateTime.utc(2024, 9, 5): [Event('title')],
  DateTime.utc(2024, 9, 6): [Event('title')],
  DateTime.utc(2024, 9, 7): [Event('title')],
  DateTime.utc(2024, 9, 8): [Event('title')],
  DateTime.utc(2024, 9, 9): [Event('title')],
  DateTime.utc(2024, 9, 10): [Event('title')],
  DateTime.utc(2024, 9, 11): [Event('title')],
  DateTime.utc(2024, 9, 12): [Event('title')],
  DateTime.utc(2024, 9, 13): [Event('title')],
  DateTime.utc(2024, 9, 14): [Event('title')],
  DateTime.utc(2024, 9, 15): [Event('title')],
  DateTime.utc(2024, 9, 16): [Event('title')],
  DateTime.utc(2024, 9, 17): [Event('title')],
  DateTime.utc(2024, 9, 18): [Event('title')],
  DateTime.utc(2024, 9, 19): [Event('title')],
  DateTime.utc(2024, 9, 20): [Event('title')],
  DateTime.utc(2024, 9, 21): [Event('title')],
  DateTime.utc(2024, 9, 22): [Event('title')],
  DateTime.utc(2024, 9, 23): [Event('title')],
  DateTime.utc(2024, 9, 24): [Event('title')],
  DateTime.utc(2024, 9, 25): [Event('title')],
  DateTime.utc(2024, 9, 26): [Event('title')],
  DateTime.utc(2024, 9, 27): [Event('title')],
  DateTime.utc(2024, 9, 28): [Event('title')],
  DateTime.utc(2024, 9, 29): [Event('title')],
  DateTime.utc(2024, 9, 30): [Event('title')],
  DateTime.utc(2024, 10, 1): [Event('title')],
  DateTime.utc(2024, 10, 2): [Event('title')],
  DateTime.utc(2024, 10, 3): [Event('title')],
  DateTime.utc(2024, 10, 4): [Event('title')],
  DateTime.utc(2024, 10, 5): [Event('title')],
  DateTime.utc(2024, 10, 6): [Event('title')],
  DateTime.utc(2024, 10, 7): [Event('title')],
  DateTime.utc(2024, 10, 8): [Event('title')],
  DateTime.utc(2024, 10, 9): [Event('title')],
  DateTime.utc(2024, 10, 10): [Event('title')],
  DateTime.utc(2024, 10, 11): [Event('title')],
  DateTime.utc(2024, 10, 12): [Event('title')],
  DateTime.utc(2024, 10, 13): [Event('title')],
  DateTime.utc(2024, 10, 14): [Event('title')],
  DateTime.utc(2024, 10, 15): [Event('title')],
  DateTime.utc(2024, 10, 16): [Event('title')],
  DateTime.utc(2024, 10, 17): [Event('title')],
  DateTime.utc(2024, 10, 18): [Event('title')],
  DateTime.utc(2024, 10, 19): [Event('title')],
  DateTime.utc(2024, 10, 20): [Event('title')],
  DateTime.utc(2024, 10, 21): [Event('title')],
  DateTime.utc(2024, 10, 22): [Event('title')],
  DateTime.utc(2024, 10, 23): [Event('title')],
  DateTime.utc(2024, 10, 24): [Event('title')],
  DateTime.utc(2024, 10, 25): [Event('title')],
  DateTime.utc(2024, 10, 26): [Event('title')],
  DateTime.utc(2024, 10, 27): [Event('title')],
  DateTime.utc(2024, 10, 28): [Event('title')],
  DateTime.utc(2024, 10, 29): [Event('title')],
  DateTime.utc(2024, 10, 30): [Event('title')],
  DateTime.utc(2024, 10, 31): [Event('title')],
  DateTime.utc(2024, 11, 1): [Event('title')],
  DateTime.utc(2024, 11, 2): [Event('title')],
  DateTime.utc(2024, 11, 3): [Event('title')],
  DateTime.utc(2024, 11, 4): [Event('title')],
  DateTime.utc(2024, 11, 5): [Event('title')],
  DateTime.utc(2024, 11, 6): [Event('title')],
  DateTime.utc(2024, 11, 7): [Event('title')],
  DateTime.utc(2024, 11, 8): [Event('title')],
  DateTime.utc(2024, 11, 9): [Event('title')],
  DateTime.utc(2024, 11, 10): [Event('title')],
  DateTime.utc(2024, 11, 11): [Event('title')],
  DateTime.utc(2024, 11, 12): [Event('title')],
  DateTime.utc(2024, 11, 13): [Event('title')],
  DateTime.utc(2024, 11, 14): [Event('title')],
  DateTime.utc(2024, 11, 15): [Event('title')],
  DateTime.utc(2024, 11, 16): [Event('title')],
  DateTime.utc(2024, 11, 17): [Event('title')],
  DateTime.utc(2024, 11, 18): [Event('title')],
  DateTime.utc(2024, 11, 19): [Event('title')],
  DateTime.utc(2024, 11, 20): [Event('title')],
  DateTime.utc(2024, 11, 21): [Event('title')],
  DateTime.utc(2024, 11, 22): [Event('title')],
  DateTime.utc(2024, 11, 23): [Event('title')],
  DateTime.utc(2024, 11, 24): [Event('title')],
  DateTime.utc(2024, 11, 25): [Event('title')],
  DateTime.utc(2024, 11, 26): [Event('title')],
  DateTime.utc(2024, 11, 27): [Event('title')],
  DateTime.utc(2024, 11, 28): [Event('title')],
  DateTime.utc(2024, 11, 29): [Event('title')],
  DateTime.utc(2024, 11, 30): [Event('title')],
  DateTime.utc(2024, 12, 1): [Event('title')],
  DateTime.utc(2024, 12, 2): [Event('title')],
  DateTime.utc(2024, 12, 3): [Event('title')],
  DateTime.utc(2024, 12, 4): [Event('title')],
  DateTime.utc(2024, 12, 5): [Event('title')],
  DateTime.utc(2024, 12, 6): [Event('title')],
  DateTime.utc(2024, 12, 7): [Event('title')],
  DateTime.utc(2024, 12, 8): [Event('title')],
  DateTime.utc(2024, 12, 9): [Event('title')],
  DateTime.utc(2024, 12, 10): [Event('title')],
  DateTime.utc(2024, 12, 11): [Event('title')],
  DateTime.utc(2024, 12, 12): [Event('title')],
  DateTime.utc(2024, 12, 13): [Event('title')],
  DateTime.utc(2024, 12, 14): [Event('title')],
  DateTime.utc(2024, 12, 15): [Event('title')],
  DateTime.utc(2024, 12, 16): [Event('title')],
  DateTime.utc(2024, 12, 17): [Event('title')],
  DateTime.utc(2024, 12, 18): [Event('title')],
  DateTime.utc(2024, 12, 19): [Event('title')],
  DateTime.utc(2024, 12, 20): [Event('title')],
  DateTime.utc(2024, 12, 21): [Event('title')],
  DateTime.utc(2024, 12, 22): [Event('title')],
  DateTime.utc(2024, 12, 23): [Event('title')],
  DateTime.utc(2024, 12, 24): [Event('title')],
  DateTime.utc(2024, 12, 25): [Event('title')],
  DateTime.utc(2024, 12, 26): [Event('title')],
  DateTime.utc(2024, 12, 27): [Event('title')],
  DateTime.utc(2024, 12, 28): [Event('title')],
  DateTime.utc(2024, 12, 29): [Event('title')],
  DateTime.utc(2024, 12, 30): [Event('title')],
  DateTime.utc(2024, 12, 31): [Event('title')],
};

List<Event> _getEventsForDay(DateTime day) {
  return events[day] ?? [];
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  Map<DateTime, List<Event>> events = {};
  Map<DateTime, bool> checkedStatus = {}; // 날짜별 체크 상태를 추적하는 맵
  Map<DateTime, bool> checkedDates = {};
  DateTime selectedDate = DateTime.now();
  int completionRate = 0;
  @override
  void initState() {
    super.initState();
    _loadAllCheckedStatus();
  }

  void _loadCheckedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // 예시로, 현재 날짜의 체크 상태를 불러옵니다.
    bool isChecked = prefs.getBool(_formatDate(selectedDate)) ?? false;
    setState(() {
      checkedDates[selectedDate] = isChecked;
    });
  }

  void _loadAllCheckedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    Map<DateTime, bool> newCheckedStatus = {};
    for (DateTime date in events.keys) {
      String formattedDate = _formatDate(date);
      bool isChecked = prefs.getBool('checked_status_$formattedDate') ?? false;
      newCheckedStatus[date] = isChecked;
    }

    setState(() {
      checkedStatus = newCheckedStatus;
    });
  }

  void _saveAllCheckedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    for (DateTime date in checkedStatus.keys) {
      String formattedDate = _formatDate(date);
      prefs.setBool('checked_status_$formattedDate', checkedStatus[date] ?? false);
    }
  }
  void _handleCheckboxChanged(bool? newValue) {
  setState(() {
    // 선택한 날짜의 체크 상태를 업데이트합니다.
    checkedStatus[selectedDay] = newValue ?? false;

    // 섭취 완료율을 계산합니다. 여기서는 단순화를 위해 모든 날짜가 동일한 비중을 가진다고 가정합니다.
    // 실제로는 적절한 로직으로 변경해야 할 것입니다.
    int checkedCount = checkedStatus.values.where((status) => status).length;
    int totalCount = checkedStatus.length;
    int completionRate = (checkedCount / totalCount * 100).round();

    // SharedPreferences에 체크 상태를 저장합니다.
    _saveCheckedStatus(selectedDay, checkedStatus[selectedDay]!);
  });
}

  void _saveCheckedStatus(DateTime date, bool isChecked) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('checked_status_${_formatDate(date)}', isChecked);
}




  bool isIconChecked1 = false;
  bool isIconChecked2 = false;

  void _handleIconClick(DateTime date) async {
  final prefs = await SharedPreferences.getInstance();
  String formattedDate = _formatDate(date);
  bool newStatus = !(checkedStatus[date] ?? false);

  setState(() {
    checkedStatus[date] = newStatus;
    // 모든 날짜의 체크 상태를 동일하게 설정합니다.
    checkedStatus.keys.forEach((key) {
      checkedStatus[key] = newStatus;
    });

    // 섭취 완료율을 업데이트합니다. 모든 날짜가 체크되면 100%, 아니면 0%입니다.
    completionRate = newStatus ? 100 : 0;

    // 그래프의 너비를 계산합니다.
    graphWidth = 326 * (completionRate / 100);

    prefs.setBool('checked_status_$formattedDate', newStatus);
    _saveAllCheckedStatus();
  });
}

// 클래스 변수에 graphWidth를 추가합니다.
double graphWidth = 0.0;

  




  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEAEAEA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        leadingWidth: 120,
        leading: Image.asset("assets/icons/Logo_nav.png"),
        actions: [
          IconButton(
            //  Calendar
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CalendarScreen(),
                ),
              );
            },
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            //  Notification
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xffFFBF65),
            width: 395,
            height: 30,
          ),
          Container(
            color: Color(0xffFFBF65),
            child: TableCalendar(
              pageAnimationEnabled: true,
              focusedDay: focusedDay,
              // focusedDay 변수 사용
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2033, 12, 31),
              locale: 'ko_KR',
              daysOfWeekHeight: 20,
              calendarFormat: CalendarFormat.week,
              weekNumbersVisible: false,
              headerVisible: false,
              calendarStyle: const CalendarStyle(
                weekendTextStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                selectedTextStyle: const TextStyle(
                  color: const Color(0xFFFAFAFA),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),

                defaultDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffE4EFFF),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffE4EFFF),
                ),
                canMarkersOverflow: false,

                // marker 자동정렬 여부
                markersAutoAligned: true,

                // marker 크기 조절
                markerSize: 10.0,

                // marker 크기 비율 조절
                markerSizeScale: 10.0,

                // marker 의 기준점 조정
                markersAnchor: 0.7,

                // marker margin 조절
                markerMargin: const EdgeInsets.symmetric(horizontal: 0.3),

                // marker 위치 조정
                markersAlignment: Alignment.bottomCenter,

                // 한줄에 보여지는 marker 갯수
                markersMaxCount: 1,

                markerDecoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              eventLoader: _getEventsForDay,

              // TableCalendar 내에서 날짜 선택시 체크 상태 초기화
              onDaySelected: (selectedDay2, focusedDay2) {
                setState(() {
                  selectedDay = selectedDay2;
                  focusedDay = selectedDay2;
                  if (!checkedStatus.containsKey(selectedDay)) {
                    // 새로운 날짜가 선택되면, 체크 상태를 false로 설정
                    checkedStatus[selectedDay] = false;
                  }
                });
              },

              selectedDayPredicate: (day) {
                // selectedDay와 같은 날짜를 선택하도록 함
                return isSameDay(selectedDay, day);
              },
            ),
          ),
          SizedBox(
            width: 327,
            height: 30,
          ),
          Container(
            width: 360,
            height: 174,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 360,
                    height: 174,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: Colors.black.withOpacity(0.25),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 20,
                  child: Text(
                    '이번 달 섭취 완료율',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Gmarket Sans TTF',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
  left: 30,
  top: 58,
  child: Text(
    '$completionRate%', // 동적으로 완료율을 표시
    style: TextStyle(
      color: Colors.black,
      fontSize: 43,
      fontFamily: 'Gmarket Sans TTF',
      fontWeight: FontWeight.w700,
      height: 0,
    ),
  ),
),
                // 회색 배경 바
Positioned(
  left: 17,
  top: 120,
  child: Container(
    width: 326, // 이 값은 고정입니다. 완료율 바의 최대 너비를 나타냅니다.
    height: 29,
    decoration: BoxDecoration(
      color: Color(0x99D9D9D9),
      borderRadius: BorderRadius.circular(14.50),
      boxShadow: [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 4,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
  ),
),
// 오렌지색 진행 상황 바
Positioned(
  left: 17,
  top: 120,
  child: AnimatedContainer(
    duration: Duration(milliseconds: 300),
    width: graphWidth, // 섭취 완료율에 따라 동적으로 계산된 너비
    height: 29,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(-1.00, -0.00),
        end: Alignment(1, 0),
        colors: [
          Color(0xFFFE9F09),
          Color(0xFFFE9F0C),
          Color(0x7AF9B53A),
          Color(0xE8FDA213)
        ],
      ),
      borderRadius: BorderRadius.circular(14.50),
    ),
  ),
),

                Positioned(
                  left: 11,
                  top: 120,
                  child: Container(
                    width: 326,
                    height: 29,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 327,
            height: 30,
          ),
          Container(
            width: 363,
            height: 97,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 363,
                    height: 97,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF5BE62),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 3,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  top: 25,
                  child: Text(
                    '오늘도 한 봉지 ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Gmarket Sans TTF',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 22,
                  top: 58,
                  child: Text(
                    'x캡슐',
                    style: TextStyle(
                      color: Color(0xFFA8AAB9),
                      fontSize: 18,
                      fontFamily: 'Gmarket Sans TTF',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
                Positioned(
                  left: 285,
                  top: 27,
                  width: 40,
                  height: 40,
                    child: GestureDetector(
                      onTap: () {
                        _handleIconClick(selectedDay);
                      }, // Use the existing function to handle the tap
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              child: Icon(
                                checkedStatus[selectedDay] ?? false
                                    ? Icons.check
                                    : Icons.check_box_outline_blank,
                                // 상태에 따라 아이콘 변경
                                color: Colors.black,
                                size: 40,
                              ),
                              width: 43,
                              height: 43,

                            ),
                          ),
                          if (!isIconChecked1)
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                child: Icon(
                                  checkedStatus[selectedDay] ?? false
                                      ? Icons.check
                                      : Icons.check_box_outline_blank,
                                  // 상태에 따라 아이콘 변경
                                  color: Colors.black,
                                  size: 40,
                                ),
                                width: 43,
                                height: 43,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF5BE62),
                                  shape: OvalBorder(
                                    side: BorderSide(
                                      style: BorderStyle.solid,
                                      width: 3,
                                      strokeAlign: BorderSide.strokeAlignOutside,
                                      color: Color(0xFFF5BE62),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                ),

              ],
            ),
          ),
          SizedBox(
            width: 327,
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              // SurveyScreen으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyScreen(kakaoUid: kakaoUid, firebaseUid:firebaseUid)),
              );
            },
            child: Container(
              width: 363,
              height: 97,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 363,
                      height: 97,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF5BE62),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 3,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 24,
                    child: Text(
                      '나만의 건강 조합 바로가기',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Gmarket Sans TTF',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 57,
                    child: Text(
                      '주기적으로 업데이트 하세요',
                      style: TextStyle(
                        color: Color(0xFFA8AAB9),
                        fontSize: 18,
                        fontFamily: 'Gmarket Sans TTF',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
