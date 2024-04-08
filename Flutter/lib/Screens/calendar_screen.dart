import 'package:ezpill/Screens/checklist_screen.dart';
import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});




  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  Map<DateTime, List<Event>> events = {};
  int completionRate = 0; // 섭취 완료율을 저장할 변수

  @override
  void initState() {
    super.initState();
    _loadCompletionRate();
  }

  void _loadCompletionRate() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      completionRate = prefs.getInt('completionRate') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "Calendar"),
      ),
      body: Column(
        children: [
          TableCalendar(

          focusedDay: focusedDay, // focusedDay 변수 사용
          firstDay: DateTime.utc(2023, 1, 1),
          lastDay: DateTime.utc(2033, 12, 31),
          locale: 'ko_KR',
          daysOfWeekHeight: 30,


          headerStyle: const HeaderStyle(
            //주차 표시 버튼
            formatButtonVisible: false,

            // 글자 제어 여부
            // formatButtonShowsNext: false,

            // formatButton 글자 꾸미기
            formatButtonTextStyle: const TextStyle(fontSize: 14.0),

            formatButtonDecoration: const BoxDecoration(
              border: const Border.fromBorderSide(BorderSide()),
              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
            ),

            titleCentered: true,
            titleTextStyle: const TextStyle(
              fontSize: 25,
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w500,
              height: 0,
              color: Colors.orange,
            ), // title 글자 크기

            leftChevronPadding: const EdgeInsets.all(12.0), //왼쪽 화살표 Padding 조절
            leftChevronMargin:
            const EdgeInsets.symmetric(horizontal: 8.0), // 왼쪽 화살표 Margin 조절

            rightChevronPadding:
            const EdgeInsets.all(12.0), // rightChevron Padding 조절
            rightChevronMargin:
            const EdgeInsets.symmetric(horizontal: 8.0), // rightChevron Margin 조절
          ),
          calendarStyle: CalendarStyle(

            defaultTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
            defaultDecoration: BoxDecoration(
              color: const Color(0xFFF6F6F6),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(6.0),
            ),
            weekendTextStyle: TextStyle(
              fontSize: 18,
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w500,
              height: 0,),
            weekendDecoration: BoxDecoration(
              color: const Color(0xFFE2E2E2),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),

            ),
            outsideDaysVisible: false,
            todayTextStyle: const TextStyle(
              fontSize: 25,
              fontFamily: 'Gmarket Sans TTF',
              fontWeight: FontWeight.w500,
              height: 0,
              color: Colors.white,

            ),
            todayDecoration: BoxDecoration(
                color: const Color(0xffFFDFBF),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.orange, width: 1.5)),

            // selectedDay 글자 조정
            selectedTextStyle: const TextStyle(
              color: const Color(0xFFFAFAFA),
              fontSize: 25,
              fontFamily: 'Gmarket Sans TTF',
              height: 0,
              fontWeight: FontWeight.bold,
            ),

            // selectedDay 모양 조정
            selectedDecoration: BoxDecoration(
              color: const Color(0xFF5C6BC0),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.blue, width: 1.5),
            ),

            //마커
            //*****************************************************************
            //마커는 아래에서 eventLoader로 만든 이벤트 마커 표시임.
            // marker 여러개 일 때 cell 영역을 벗어날지 여부
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
            markersMaxCount: 4,

            // marker 모양 조정
            markerDecoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          //마커 생성
          eventLoader: _getEventsForDay,

          //아래 코드도 이벤트 생성이 가능함( 짝수일에 다 생성하는 것이며, 여기서 h는 아무 의미없는 문자열임)
          // eventLoader: (day) {
          //   if (day.day % 2 == 0) {
          //     return ['h'];
          //   }
          //   return [];
          // },



          //*****************************************************************

          // selectedDayPredicate와 onDaySelected 속성 추가
          selectedDayPredicate: (day) {
            // selectedDay와 같은 날짜를 선택하도록 함
            return isSameDay(selectedDay, day);
          },
          onDaySelected: (selectedDay2, focusedDay2) {
            // selectedDay와 focusedDay를 업데이트하고 화면을 갱신함
            setState(() {
              selectedDay = selectedDay2;
              focusedDay = focusedDay2;
            });
          },
        ),
          ElevatedButton(onPressed: (){
            // ElevatedButton이 눌리면 Navigator를 통해 checklist 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChecklistScreen()),
            );
          }, child: Text('checklist'),),
        ],
      ),

    );
  }
}
