import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/controller/calendar_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';
import 'package:interval_time_picker/interval_time_picker.dart';
import 'package:mommy_is_busy/static_methods/time_converters.dart';
import 'package:table_calendar/table_calendar.dart';

import 'bottom_button_icons.dart';
import 'package:timezone/standalone.dart' as tz;


class Calendar_Fixed extends StatelessWidget {
  Calendar_Fixed({super.key});

  final calendarController = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {

    LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<DateTime, List<Event>>();

    List<Event> getEventsForDay(DateTime day){
      return kEvents[day] ?? [];
    }

    late final ValueNotifier<List<Event>> selectedEvents;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CalendarFormat calendarFormat = CalendarFormat.month;

    // DateTime selectedDay = calendarController.focusedDay.value;
    selectedEvents = ValueNotifier(getEventsForDay(calendarController.selectedDay.value!));

    List<Widget> newTasks = [TextFormField(
      key: UniqueKey(),
      onSaved:(val){
        if (val?.trim()=='') {
          Fluttertoast.showToast(msg: '할 일을 입력해 주세요');
        }else {
          calendarController.tempEventList.add(Event(
              eventName: val!, deadline: ((TC.subtractNineHours(TC.convertToSeoulTimeZone(TC.deadlineDateTime(calendarController.pickedTime.value, calendarController.selectedDay.value))))),
          createdAt: DateTime.now()));
        }
      },
      decoration: InputDecoration(hintText: '할 일을 적어주세요'),)];

    Future<void> createAlertDialog(BuildContext context) async {
      await showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (context, setState) {
                  LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<
                      DateTime,
                      List<Event>>();

                  return AlertDialog(
                    title: Text('할 일을 입력하세요'),
                    content: Form(
                      key: calendarController.formKey.value,
                      child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .3,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * .5,
                                child: ListView.builder(
                                    itemCount: newTasks.length,
                                    itemBuilder: (context, index) {
                                      return newTasks[index];
                                    }),
                              ),
                            ),
                            // TextFormField(decoration: InputDecoration(hintText: '할 일을 적어주세요'),),
                            SizedBox(height: 20,),
                            if(calendarController.isTimePicked.value)
                              Text('${calendarController.pickedTime.value.format(context)} 까지'),

                            if(!calendarController.isTimePicked.value)
                              Row(children: [
                                Text('언제까지 해야 하나요? : '),
                                ElevatedButton(onPressed: () {
                                  // showTimePicker(context: context,
                                  //     initialTime: calendarController.pickedTime.value);
                                  showIntervalTimePicker(
                                      context: context,
                                      interval: 15,
                                      initialTime: calendarController.pickedTime.value).then((value) {
                                        setState((){

                                          calendarController.isTimePicked.value = true;
                                          calendarController.pickedTime.value = value!;
                                        });

                                  }
                                  );
                                }, child: Icon(Icons.timelapse)),
                              ]
                              )

                          ],
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(onPressed: () {
                        setState(() {
                          newTasks.add(TextFormField(
                            onSaved: (val) {
                              // calendarController.tempEventList.add(Event(eventName: val!, deadline: deadlineDateTime(calendarController.pickedTime.value, calendarController.selectedDay.value),
                              // createdAt: DateTime.now()));
                              calendarController.tempEventList.add(Event(
                                  eventName: val!, deadline: ((TC.subtractNineHours(TC.convertToSeoulTimeZone(TC.deadlineDateTime(calendarController.pickedTime.value, calendarController.selectedDay.value))))),
                                  createdAt: DateTime.now()));
                            },
                            decoration: const InputDecoration(
                                hintText: '할 일을 적어주세요'),));
                          print('setstate');
                        });
                      },
                        child: Text('할 일 추가'),),
                      SizedBox(width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.3,),
                      ElevatedButton(
                        child: Text(' 확인 '),
                        onPressed: () async {
                          // kEvents.addAll();
                          // _selectedEvents.
                          // newTask를 넣어줘야함...
                          // 주체도 적어줘야함
                          //



                          calendarController.formKey.value.currentState!.save();
                          DateTime convertedTime = TC.convertToDateTime(
                              calendarController.pickedTime.value, calendarController.focusedDay.value);
                          convertedTime = TC.convertToSeoulTimeZone(convertedTime);
                          calendarController.removeRepeatedEvents(); // 중복값 잘 없앴음.
                          kEvents.addAll({convertedTime: calendarController.tempEventList.value});


                          print('=============================');


                          for (Event e in kEvents[convertedTime]!) {
                            print(e.eventName);
                            print(e.deadline);
                            print(e.createdAt);

                            // FirestoreController.controller.storeTasks(e, convertedTime);
                            FirestoreController.controller.storeTasks(e);
                          }

                          print('=============================');

                          kEvents.clear();

                          calendarController.isTimePicked.value=false;

                          Navigator.of(context).pop();

                          if(!calendarController.tempEventList.isEmpty)
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('성공적으로 업데이트됐습니다.')));
                          calendarController.tempEventList.clear();

                          // setState((){
                          //   kEvents.clear();
                          //
                          // });
                          // kEvents.clear();
                          print(kEvents.isEmpty);
                          // for (Event e in kEvents[convertToDateTime(_pickedTime, _focusedDay)]!){
                          //   print(e.eventName);
                          // }
                          // print('=============================');
                        },
                      )
                    ],
                  );
                }
            );
          }
      );



    }


    return Obx(
      ()=> Scaffold(
        backgroundColor: Colors.orange,
        floatingActionButton:
        Padding(padding: EdgeInsets.only(bottom: 100), child: FloatingActionButton(onPressed: (){

          createAlertDialog(context);

        }, backgroundColor: Colors.orangeAccent, child: const Icon(Icons.add),)),

        body:
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: EdgeInsets.only(top: 60, right: 12, left: 12),
            child: TableCalendar(
              headerStyle:
              HeaderStyle(formatButtonVisible: false, titleCentered: true),
              rowHeight: height * .05,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2040, 3, 14),
              focusedDay: calendarController.focusedDay.value,
              calendarFormat: calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(calendarController.selectedDay.value, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(calendarController.selectedDay.value, selectedDay)) {
                    calendarController.selectedDay.value = selectedDay;
                    calendarController.focusedDay.value = focusedDay;

                }
              },
              onFormatChanged: (format) {
                if (calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                    calendarFormat = format;
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                calendarController.focusedDay.value = focusedDay;
              },
            ),
          ),
          BottomButtonIconRow(pageFrom: 'Calendar',),
        ]),
      ),
    );;
  }
}
