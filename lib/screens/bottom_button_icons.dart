import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/screens/calendar.dart';
import 'package:mommy_is_busy/screens/fridge_state.dart';
import 'package:mommy_is_busy/screens/main_page.dart';
import 'package:mommy_is_busy/screens/settings.dart';

import 'household_account.dart';

class BottomButtonIconRow extends StatelessWidget {
  const BottomButtonIconRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {
          Get.offAll(MainPage());
        }, icon: Icon(Icons.home)),
        IconButton(onPressed: (){
          Get.offAll(Calendar());
        }, icon: Icon(Icons.calendar_month)),
        IconButton(onPressed: () {
          Get.offAll(Fridge());
        }, icon: Icon(Icons.food_bank)),
        IconButton(
            onPressed: () {
              Get.offAll(HouseAccount());
            }, icon: Icon(Icons.monetization_on)),
        IconButton(
            onPressed: () {
              Get.offAll(Settings());
            }, icon: Icon(Icons.settings)),
        
      ],
    );
  }
}
