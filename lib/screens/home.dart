import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mommy_is_busy/controller/calendar_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/screens/task_list_screen.dart';
import 'package:mommy_is_busy/static_methods/time_converters.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:mommy_is_busy/models/calendar_event.dart';

import 'bottom_button_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    CalendarController calendarController = Get.put(CalendarController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    CalendarFormat calendarFormat = CalendarFormat.month;

    bool isEveryTaskDone(List<Event> eventList){

      bool result = true;

      eventList.forEach((element) {
        if (element.isDone==false){
          result = false;
        }
      });

      return result;
    }

    String howBusy = '매우바쁜';

    String getSystemTime() {
      var now = DateTime.now();
      return DateFormat('yMMMMEEEEd').format(now);
    }

    FirestoreController.controller.eventList.clear();
    FirestoreController.controller.eventMap.clear();

    FirestoreController.controller.getEvents(calendarController.selectedDayFromHome.value);
    print('selectedDayFromHome :${calendarController.selectedDayFromHome.value}');
    List<DateTime> keyList = FirestoreController.controller.eventMap.value.keys.toList()..sort();

    print('keylist');
    print(DateTime.now().toString());
    // print(keyList);
    // keyList.forEach((element) {print(element.toString());});

    print('db call');


    return Scaffold(
        backgroundColor: Colors.orange,
        floatingActionButton:
        Padding(padding: EdgeInsets.only(bottom: 100),
            child: FloatingActionButton(
              onPressed: (){
              showDialog(context: context, builder: (context){
            return Obx(
                ()=> AlertDialog(title: Text('날짜를 지정해 주세요'),
                actions: [],
                content: Container(
                  width: width*.8,
                  height: height*.5,
                  child:
                TableCalendar(
                  headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
                  rowHeight: height * .05,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: calendarController.focusedDayFromHome.value,
                  calendarFormat: calendarFormat,
                  selectedDayPredicate: (day) {
                    // Use `selectedDayPredicate` to determine which day is currently selected.
                    // If this returns true, then `day` will be marked as selected.

                    // Using `isSameDay` is recommended to disregard
                    // the time-part of compared DateTime objects.
                    return isSameDay(calendarController.selectedDay.value, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                      calendarController.selectedDayFromHome.value = TC.subtractNineHours(selectedDay.toLocal());
                      calendarController.focusedDayFromHome.value = focusedDay;
                      FirestoreController.controller.eventList.clear();
                      FirestoreController.controller.eventMap.clear();
                      FirestoreController.controller.getEvents(calendarController.selectedDayFromHome.value);

                      print('selectedDay');
                      print(selectedDay);
                      Navigator.of(context).pop();

                  },
                  onFormatChanged: (format) {
                    if (calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      calendarFormat = format;
                    }
                  },
                  onPageChanged: (focusedDay) {
                    // No need to call `setState()` here
                    calendarController.focusedDayFromHome.value = focusedDay;
                  },
                ),

              )),
            );
    });},
              backgroundColor: Colors.orangeAccent,
              child: const Icon(Icons.calendar_month),)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 60),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '오늘은 ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TimerBuilder.periodic(Duration(minutes: 1),
                                      builder: (context) {
                                        return Text(
                                          getSystemTime(),
                                          style: TextStyle(color: Colors.white),
                                        );
                                      }),
                                  Text(
                                    ' 입니다.',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: '오늘은 ',
                                      style: TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: howBusy,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: '날 입니다.'),
                                      ])),
                              RichText(
                                  text: TextSpan(
                                      text: '오늘은 ',
                                      style: TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: howBusy,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: '날 입니다.'),
                                      ])),
                              RichText(
                                  text: TextSpan(
                                      text: '오늘은 ',
                                      style: TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: howBusy,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: '날 입니다.'),
                                      ])),
                              RichText(
                                  text: TextSpan(
                                      text: '오늘은 ',
                                      style: TextStyle(color: Colors.white),
                                      children: [
                                        TextSpan(
                                            text: howBusy,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: '날 입니다.'),
                                      ])),
                            ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                      height: 50,
                        child: Obx(()=> Text('${calendarController.selectedDayFromHome.value.month}월 ${calendarController.selectedDayFromHome.value.day}일의 할 일들은 아래와 같습니다.'),)
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.yellow,
                          child: Obx( ()=>ListView.builder(
                              itemCount: FirestoreController.controller.eventMap.length,
                              padding: EdgeInsets.all(8),
                              itemBuilder: (context, idx) {
                                DateTime mapKey = FirestoreController.controller.keyList[idx];

                                return GestureDetector(
                                  key: UniqueKey(),
                                  onTap: (){
                                    Get.offAll(()=>TaskListScreen(mapKey: mapKey,));
                                  },
                                  child: Container(
                                    color: Colors.grey,
                                    margin: EdgeInsets.all(8),
                                    child: Column(
                                      children:[
                                        (isEveryTaskDone(FirestoreController.controller.eventMap[mapKey]!))?
                                Text(mapKey.toString(), style: TextStyle( decoration: TextDecoration.lineThrough),) : Text(mapKey.toString())
                                      // Text(FirestoreController.controller.eventList.value[idx].eventName),
                                      // Text(FirestoreController.controller.eventList.value[idx].isDone.toString())
                                    ])
                                  ),
                                );
                                // return Container(
                                //     child: Text(''),
                                //     margin: EdgeInsets.all(8),
                                //     height: 40,
                                //     color: Colors.amber);
                              })),),
                      )
                      // Container(height: height*0.2, color: Colors.green,)
                    ],
                  ),
                ),
              ),
              BottomButtonIconRow(pageFrom: 'Home',)
            ]));
  }
}
