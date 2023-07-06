import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: (){
            AuthController.controller.signout();
          }, child: Text('Sign out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

        ],
      ),
    );
  }
}
