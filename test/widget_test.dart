import 'package:flutter/material.dart';

void main(){
  print(DateTime.now());
  TimeOfDay timeOfDay = TimeOfDay(hour: 8, minute: 30);

  print(timeOfDay.hour);
  print(DateTime.now().hour);

  print(DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, timeOfDay.hour, timeOfDay.minute));
}