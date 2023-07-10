import 'package:flutter/material.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:mommy_is_busy/screens/main_page.dart';

class TheVeryFirstPage extends StatelessWidget {
  const TheVeryFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Home()));
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.orange,), child: const Text('to the main page'),
        ),
      ),
    );
  }
}
