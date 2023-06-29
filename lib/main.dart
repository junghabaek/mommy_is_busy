import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_http_request.dart';
import 'package:mommy_is_busy/screens/the_very_first_page.dart';

void main() {
  // initializeDateFormatting().then((_) => runApp(const MyApp()));
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('ko', 'KR'),
      // ],
      home: TheVeryFirstPage(),
    );
  }
}
