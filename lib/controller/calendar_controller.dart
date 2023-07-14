import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';

class CalendarController extends GetxController{
  static CalendarController controller = Get.find();

  final formKey = GlobalKey<FormState>().obs;
  RxList<Event> tempEventList = <Event>[].obs;
  RxBool isTimePicked = false.obs;
  var pickedTime = TimeOfDay(hour: 8, minute: 0).obs;
  var focusedDay = DateTime.now().obs;
  var selectedDay = DateTime.now().obs;

  var focusedDayFromHome = DateTime.now().obs;
  var selectedDayFromHome = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).obs;

  void removeRepeatedEvents (){
    tempEventList = tempEventList.value.toSet().toList().obs;
  }
}

// I/flutter ( 5698): 2023-07-10 15:00:00.000Z
// I/flutter ( 5698): 2023-07-11 15:00:00.000Z