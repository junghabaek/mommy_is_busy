import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mommy_is_busy/bottom_buttons.dart';
import 'package:mommy_is_busy/screens/bottom_button_icons.dart';
import 'package:timer_builder/timer_builder.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var date = DateTime.now();

  bool isLoggedIn = true; // 로그인이 되어있는가? 일단 되어있다고 생각하고 만들기
  String today = DateFormat('yMMMMEEEEd').format(DateTime.now());
  String howBusy = '매우바쁜'; // 이거 나중에 함수로 만들어서 받아와야함

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat('yMMMMEEEEd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                        child: ListView.builder(
                            itemCount: 10,
                            padding: EdgeInsets.all(8),
                            itemBuilder: (context, idx) {
                              return Container(
                                  margin: EdgeInsets.all(8),
                                  height: 40,
                                  color: Colors.amber);
                            }),
                      ),
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
