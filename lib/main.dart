import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/screens/login_signup/login.dart';
// import 'package:intl/date_symbol_data_http_request.dart';
import 'package:mommy_is_busy/screens/the_very_first_page.dart';
import 'package:get/get.dart';

void main() async{
  // initializeDateFormatting().then((_) => runApp(const MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
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
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('ko', 'KR'),
      // ],
      home: LogInPage(),
    );
  }
}
