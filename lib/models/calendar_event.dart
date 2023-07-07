import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event{

  bool isDone = false;
  String eventName = '할 일을 다시 지정해 주세요';
  //created date 필요하고
  DateTime createdAt = DateTime.now();
  TimeOfDay deadline; //몇년 몇월 몇일 몇시까지?

  Event({required this.eventName, required this.deadline}){}

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is Event &&
        other.eventName == eventName &&
        other.deadline == deadline;
  }

  @override
  int get hashCode => eventName.hashCode ^ deadline.hashCode;

}

// var kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// );

// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 5 + 1, (index) => Event('Event $item | ${index + 1}')))
//   ..addAll({
//     kToday: [
//       Event('Today\'s Event 1'),
//       Event('Today\'s Event 2'),
//     ],
//   });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);