// import 'package:flutter/material.dart';
// import 'package:mommy_is_busy/screens/calendar_fixed.dart';
// import 'package:mommy_is_busy/screens/main_page.dart';
// import 'package:mommy_is_busy/screens/calendar.dart';
// import 'package:get/get.dart';
// import 'package:mommy_is_busy/screens/settings.dart';
//
// class BottomButtons{
//   String? button_name;
//   BuildContext context;
//
//   BottomButtons({required this.button_name, required this.context}){}
//
//   Widget returnIconButton(){
//     if (button_name == 'main'){
//       return IconButton(onPressed: (){
//         Get.offAll(MainPage());
//         // Navigator.of(context).push(MaterialPageRoute(builder: (context){
//         //   return const MainPage();
//         // }
//         // )
//         // );
//       }, icon: const Icon(Icons.home));
//     }else if(button_name == 'calendar'){
//       return IconButton(onPressed: (){
//         // Navigator.of(context).push(MaterialPageRoute(builder: (context){
//         //   return const Calendar();
//         // }
//         // )
//         // );
//         Get.offAll(Calendar_Fixed());
//       }, icon: const Icon(Icons.calendar_month));
//     }else if(button_name == 'settings'){
//       return IconButton(onPressed: (){
//         Get.offAll(Settings());
//       }, icon: const Icon(Icons.settings));
//     }
//
//     return IconButton(onPressed: (){}, icon: Icon(Icons.add));
//   }
// }