import 'package:flutter/material.dart';
import 'package:mommy_is_busy/screens/the_very_first_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
