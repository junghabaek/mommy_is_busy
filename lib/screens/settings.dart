import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: (){
              AuthController.controller.authentication.signOut();
              print('####################');
              print(AuthController.controller.authentication.currentUser!.uid);
              FirestoreController.controller.eventList.clear();
            }, child: Text('Sign out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

          ],
        ),
      ),
    );
  }
}
