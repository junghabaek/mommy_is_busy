// import 'dart:collection';
// import 'dart:collection';
//
// import 'package:flutter/material.dart';
// import 'package:mommy_is_busy/screens/bottom_button_icons.dart';
//
// import '../bottom_buttons.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../models/calendar_event.dart';
// import 'package:interval_time_picker/interval_time_picker.dart';
//
// class Calendar extends StatefulWidget {
//   const Calendar({super.key});
//
//
//   @override
//   State<Calendar> createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
//   late final ValueNotifier<List<Event>> _selectedEvents;
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   // List<Event> events = Event.fromJsonToList
//   bool isTimePicked = false;
//   TimeOfDay _pickedTime = const TimeOfDay(hour: 8, minute: 0);
//   final _formKey = GlobalKey<FormState>();
//   // List<Widget> newTasks = [];
//   Map<DateTime, List<Event>> tempMap = {};
//
//   List<Event> tempEventList = [];
//
//
//   // List<Widget> newTasks = [TextFormField(
//   //   onSaved:(val){
//   //     tempEventList.add(Event(eventName: val!));
//   //     .length;
//     // },
//     // decoration: InputDecoration(hintText: '할 일을 적어주세요'),)];
//
//   LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<DateTime, List<Event>>();
//
//   // LinkedHashMap<DateTime, List<Event>> kEvents; = LinkedHashMap<DateTime, List<Event>>;
//
//   // var kEvents = LinkedHashMap<DateTime, List<Event>>(
//   // equals: isSameDay,
//   // hashCode: getHashCode,
// // );
//
// //
//
//   List<Event> _getEventsForDay(DateTime day){
//     return kEvents[day] ?? [];
//   }
//
//   void _addEventOnFocused(DateTime day, Event event){
//     setState(() {
//       kEvents.addAll({day : [event]});
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }
//
//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }
//
//
//
//
//
//   ////////////////////////below is the build method/////////////////////
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//
//     List<Widget> newTasks = [TextFormField(
//       key: UniqueKey(),
//       onSaved:(val){
//         tempEventList.add(Event(eventName: val!, deadline: _pickedTime));
//         // .length;
//       },
//       decoration: InputDecoration(hintText: '할 일을 적어주세요'),)];
//
//     DateTime convertToDateTime(TimeOfDay timeOfDay, DateTime focusedDay){
//
//       return DateTime.utc(focusedDay.year, focusedDay.month, focusedDay.day, timeOfDay.hour, timeOfDay.minute);
//
//     }
//
//     Future<Event?> createAlertDialog(BuildContext context) async{
//       Event event = await showDialog(
//           context: context,
//           builder: (context){
//             return StatefulBuilder(
//                 builder: (context, setState){
//                   LinkedHashMap<DateTime, List<Event>> kEvents = LinkedHashMap<DateTime, List<Event>>();
//
//                   return AlertDialog(
//                     title: Text('할 일을 입력하세요'),
//                     content: Form(
//                       key: _formKey,
//                       child: Container(
//                         height: MediaQuery.of(context).size.height*.3,
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width*.5,
//                                 child: ListView.builder(itemCount: newTasks.length, itemBuilder: (context, index){
//                                   return newTasks[index];
//                                 }),
//                               ),
//                             ),
//                             // TextFormField(decoration: InputDecoration(hintText: '할 일을 적어주세요'),),
//                             SizedBox(height: 20,),
//                             if(isTimePicked)
//                               Text('${_pickedTime.format(context)} 까지'),
//
//                             if(!isTimePicked)
//                               Row(children: [
//                                 Text('언제까지 해야 하나요? : '),
//                                 ElevatedButton(onPressed: () {
//                                   // showTimePicker(context: context, initialTime: _pickedTime);
//                                   showIntervalTimePicker(
//                                       context: context,
//                                       interval: 15,
//                                       initialTime: _pickedTime).then((value) {
//                                     setState(() {
//                                       isTimePicked=true;
//                                       _pickedTime = value!;
//                                     }
//                                     );
//                                   }
//                                   );}, child: Icon(Icons.timelapse)),]
//                               )
//
//                           ],
//                         ),
//                       ),
//                     ),
//                     actions: [
//                       ElevatedButton(onPressed: (){
//                         setState((){
//                           newTasks.add(TextFormField(
//                             onSaved:(val){tempEventList.add(Event(eventName: val!, deadline: _pickedTime));},
//                             decoration: const InputDecoration(hintText: '할 일을 적어주세요'),));
//                           print('setstate');
//                         });
//
//                       },
//                         child: Text('할 일 추가'),),
//                       SizedBox(width: MediaQuery.of(context).size.width*0.3,),
//                       ElevatedButton(
//                         child: Text(' 확인 '),
//                         onPressed: () {
//                           // kEvents.addAll();
//                           // _selectedEvents.
//                           // newTask를 넣어줘야함...
//                           // 주체도 적어줘야함
//                           //
//                           _formKey.currentState!.save();
//                           DateTime convertedTime=convertToDateTime(_pickedTime, _focusedDay);
//                           kEvents.addAll({convertedTime : tempEventList});
//
//
//                           print('=============================');
//
//                           for (Event e in kEvents[convertToDateTime(_pickedTime, _focusedDay)]!){
//                             print(e.eventName);
//                           }
//
//                           print('=============================');
//                           tempEventList.clear();
//
//                           kEvents.clear();
//
//                           Navigator.of(context).pop();
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('성공적으로 업데이트됐습니다.')));
//
//                           // setState((){
//                           //   kEvents.clear();
//                           //
//                           // });
//                           // kEvents.clear();
//                           print(kEvents.isEmpty);
//                           // for (Event e in kEvents[convertToDateTime(_pickedTime, _focusedDay)]!){
//                           //   print(e.eventName);
//                           // }
//                           // print('=============================');
//                         },
//                       )
//                     ],
//                   );}
//             );
//
//           }
//       );
//
//       if (event !=null){
//         return event;
//       }else{
//         return null;
//       }
//
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.orange,
//       floatingActionButton:
//           Padding(padding: EdgeInsets.only(bottom: 100), child: FloatingActionButton(onPressed: (){
//             // setState(() {
//             //
//             // });
//             createAlertDialog(context).then((onValue){
//               if(onValue?.eventName!='할 일을 다시 지정해 주세요'){
//                 Event? tempEvent = onValue;
//                 print(onValue);
//                 print('dsfjlksfjlsafjdklfjkfjalfas');
//                 // _addEventOnFocused(_focusedDay,tempEvent!);
//               }
//
//               return null;
//             });
//           }, backgroundColor: Colors.orangeAccent, child: const Icon(Icons.add),)),
//
//       body:
//           Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//         Padding(
//           padding: EdgeInsets.only(top: 60, right: 12, left: 12),
//           child: TableCalendar(
//             headerStyle:
//                 HeaderStyle(formatButtonVisible: false, titleCentered: true),
//             rowHeight: height * .05,
//             firstDay: DateTime.utc(2010, 10, 16),
//             lastDay: DateTime.utc(2030, 3, 14),
//             focusedDay: _focusedDay,
//             calendarFormat: _calendarFormat,
//             selectedDayPredicate: (day) {
//               // Use `selectedDayPredicate` to determine which day is currently selected.
//               // If this returns true, then `day` will be marked as selected.
//
//               // Using `isSameDay` is recommended to disregard
//               // the time-part of compared DateTime objects.
//               return isSameDay(_selectedDay, day);
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               if (!isSameDay(_selectedDay, selectedDay)) {
//                 // Call `setState()` when updating the selected day
//                 setState(() {
//                   _selectedDay = selectedDay;
//                   _focusedDay = focusedDay;
//                 });
//
//               }
//             },
//             onFormatChanged: (format) {
//               if (_calendarFormat != format) {
//                 // Call `setState()` when updating calendar format
//                 setState(() {
//                   _calendarFormat = format;
//                 });
//               }
//             },
//             onPageChanged: (focusedDay) {
//               // No need to call `setState()` here
//               _focusedDay = focusedDay;
//             },
//           ),
//         ),
//         Column(children: [
//           BottomButtonIconRow(),
//           Container(
//             color: Colors.black,
//             height: height * .05,
//           )
//         ]),
//       ]),
//     );
//   }
// }
