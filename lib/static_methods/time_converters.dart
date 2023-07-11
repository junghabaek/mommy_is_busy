import 'package:flutter/material.dart';
import 'package:timezone/standalone.dart' as tz;

class TC{
  static DateTime subtractNineHours(DateTime dateTime){

    return dateTime.subtract(Duration(hours: 9));
  }

  static DateTime convertToSeoulTimeZone (DateTime localDateTime){

    // final seoul = tz.getLocation('Asia/Seoul');

    return tz.TZDateTime.from(localDateTime, seoul);
  }

  static final seoul = tz.getLocation('Asia/Seoul');

  static DateTime convertToDateTime(TimeOfDay timeOfDay, DateTime focusedDay){

    return DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day, timeOfDay.hour, timeOfDay.minute);

  }

  static DateTime deadlineDateTime (TimeOfDay pickedTime, DateTime dateTime){

    final year = dateTime.year;
    final month = dateTime.month;
    final day = dateTime.day;
    final hour = pickedTime.hour;
    final minutes = pickedTime.minute;

    return DateTime.utc(year, month, day, hour, minutes);

  }




}