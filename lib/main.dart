import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/controller/calendar_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:mommy_is_busy/screens/login_signup/login.dart';
// import 'package:intl/date_symbol_data_http_request.dart';
import 'package:mommy_is_busy/screens/the_very_first_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'controller/deprecated_fridge_controller.dart';
import 'controller/fridge_controller.dart';

void main() async{
  // initializeDateFormatting().then((_) => runApp(const MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
    Get.put(FirestoreController());
    Get.put(CalendarController());
    Get.put(FridgeController());
    // FridgeController.controller.initFridge();
  });
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),

      home: LogInPage(),
      // getPages: _getPages(),
    );
  }

  // List<GetPage> _getPages(){
  //   return [
  //     GetPage(
  //       name: '/Home',
  //       page: ()=>const Home(),
  //       binding: HomeBindings(),
  //     ),
  //   ];
  // }
}
