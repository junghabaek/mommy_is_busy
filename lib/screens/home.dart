import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:timer_builder/timer_builder.dart';

import 'bottom_button_icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String howBusy = '매우바쁜';

    String getSystemTime() {
      var now = DateTime.now();
      return DateFormat('yMMMMEEEEd').format(now);
    }

    FirestoreController.controller.eventList.clear();

    print('db call');
    FirestoreController.controller.getEvents(DateTime.now());

    Future.delayed(Duration(seconds: 5));

    var tempEventList = FirestoreController.controller.eventList.value;

    return Scaffold(
        backgroundColor: Colors.orange,
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
                        height: height * .05,
                      ),
                      Container(
                        height: height * .55,
                        color: Colors.yellow,
                        child: Obx( ()=>ListView.builder(
                            itemCount: FirestoreController.controller.eventList.length,
                            padding: EdgeInsets.all(8),
                            itemBuilder: (context, idx) {
                              return Obx(()=>Container(
                                color: Colors.grey,
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children:[
                                  Text(FirestoreController.controller.eventList.value[idx].eventName),
                                  Text(FirestoreController.controller.eventList.value[idx].isDone.toString())
                                ])
                              ));
                              // return Container(
                              //     child: Text(''),
                              //     margin: EdgeInsets.all(8),
                              //     height: 40,
                              //     color: Colors.amber);
                            })),)
                      // Container(height: height*0.2, color: Colors.green,)
                    ],
                  ),
                ),
              ),
              Column(children: [
                BottomButtonIconRow(),
                Container(
                  color: Colors.black,
                  height: height * .05,
                ) // 광고
              ])
            ]));
  }
}
