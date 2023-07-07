import 'package:flutter/cupertino.dart';
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

  void removeRepeatedEvents (){
    tempEventList = tempEventList.value.toSet().toList().obs;
  }
}