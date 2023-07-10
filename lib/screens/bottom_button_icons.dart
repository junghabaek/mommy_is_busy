
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/screens/calendar_fixed.dart';
import 'package:mommy_is_busy/screens/fridge_state.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:mommy_is_busy/screens/settings.dart';

import 'household_account.dart';

class BottomButtonIconRow extends StatelessWidget {
  const BottomButtonIconRow({super.key});


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {
            Get.offAll(()=>Home());
          }, icon: Icon(Icons.home)),
          IconButton(onPressed: (){
            Get.offAll(()=>Calendar_Fixed());
          }, icon: Icon(Icons.calendar_month)),
          IconButton(onPressed: () {
            Get.offAll(()=>Fridge());
          }, icon: Icon(Icons.food_bank)),
          IconButton(
              onPressed: () {
                Get.offAll(()=>HouseAccount());
              }, icon: Icon(Icons.monetization_on)),
          IconButton(
              onPressed: () {
                Get.offAll(()=>Settings());
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
