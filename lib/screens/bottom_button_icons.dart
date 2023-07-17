
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/deprecated_fridge_controller.dart';
import 'package:mommy_is_busy/screens/calendar_fixed.dart';
import 'package:mommy_is_busy/screens/deprecated_fridge_state_using_shared_preferences.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:mommy_is_busy/screens/settings.dart';

import '../controller/fridge_controller.dart';
import 'fridge_state.dart';
import 'household_account.dart';

class BottomButtonIconRow extends StatelessWidget {
  BottomButtonIconRow({super.key, required this.pageFrom});

  String pageFrom;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {
            if(pageFrom!='Home')
            Get.offAll(()=>Home());
          }, icon: Icon(Icons.home)),
          IconButton(onPressed: (){
            if(pageFrom!='Calendar')
            Get.offAll(()=>Calendar_Fixed());
          }, icon: Icon(Icons.calendar_month)),
          IconButton(onPressed: () {
            if(pageFrom!='Fridge') {
              FridgeController.controller.loadFridge();
              Get.offAll(() => Fridge());
            }
          }, icon: Icon(Icons.food_bank)),
          // IconButton(
          //     onPressed: () {
          //       if(pageFrom!='HouseAccount')
          //       Get.offAll(()=>HouseAccount());
          //     }, icon: Icon(Icons.monetization_on)),
          IconButton(
              onPressed: () {
                if(pageFrom!='Settings') {
                  Get.offAll(() => Settings());
                }
              }, icon: Icon(Icons.settings)),

        ],
      ),
    Container(
    color: Colors.black,
    height: height *0.05,
    )
    ]
    );
  }
}
