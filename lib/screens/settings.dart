import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/screens/bottom_button_icons.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();

    Future<void> _dialogBuilder(BuildContext context, int sharingCode){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text('이 코드를 3분 안에 공유하고자 하는 디바이스에 적어주세요'),
          content: Text(sharingCode.toString()),
          actions: [
            ElevatedButton(onPressed: (){Navigator.of(context).pop();}, child: Text('확인'))
          ],
        );
      });
    }


    Future<void> _dialogBuilderEnter(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text('공유받은 코드를 입력해 주세요'),
          content: TextFormField(
            controller: controller,
          ),
          actions: [
            ElevatedButton(onPressed: () async
        {
          if (await AuthController.controller.connectWithSharingCode(
              int.parse(controller.text)) == false) {
            Fluttertoast.showToast(msg: '코드를 다시 확인해 주세요');
            controller.clear();
          } else {
            Fluttertoast.showToast(msg: ' 연동되었습니다. ');
            controller.clear();
            Navigator.of(context).pop();
          }
        }
                , child: Text('확인'))
          ],
        );
      });
    }


    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            TextButton(onPressed: (){
              AuthController.controller.authentication.signOut();
              print('####################');
              print(AuthController.controller.authentication.currentUser!.uid);
              FirestoreController.controller.eventList.clear();
            }, child: Text('Sign out', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            TextButton(onPressed: (){
              int sharingCode = Random().nextInt(900000)+100000;
              print(sharingCode);
              AuthController.controller.updateSharingCode(sharingCode);
              _dialogBuilder(context, sharingCode);},
                child: Text('get the connection code',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            TextButton(onPressed: (){
              _dialogBuilderEnter(context);},
                child: Text('enter the connection code',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

            BottomButtonIconRow(pageFrom: 'Settings'),
          ],
        ),
      ),
    );
  }
}
