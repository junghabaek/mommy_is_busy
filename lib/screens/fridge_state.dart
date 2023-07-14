import 'package:flutter/material.dart';
import 'package:mommy_is_busy/screens/bottom_button_icons.dart';
import 'package:get/get.dart';

import '../controller/fridge_controller.dart';

class Fridge extends StatelessWidget {
  const Fridge({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        color: Colors.orange,
        child: Column(
          children: [
            // ToggleButtons(children: children, isSelected: isSelected)
            Expanded(
              child: Container(
                // color: Colors.green,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              // color: Colors.blue,
                              width: 90,
                              child: Row(children: [
                                Text('육류'),
                                Obx( ()=>Switch(value: FridgeController.controller.hasMeat.value,
                                    onChanged: (value) {
                                      FridgeController.controller.toggleFood(
                                          FridgeController.controller.hasMeat, 'meat');
                                      FridgeController.controller.hasMeat.value=value;
                                      // print(FridgeController.controller.hasMeat.value);
                                    }))
                              ]),
                            ),
                            Container(
                              // color: Colors.blue,
                              width: 90,
                              child: Row(children: [
                                Text('채소'),
                                Obx( ()=>Switch(value: FridgeController.controller.hasVeggies.value,
                                    onChanged: (value) {
                                      FridgeController.controller.toggleFood(
                                          FridgeController.controller.hasVeggies,'veggies');
                                      FridgeController.controller.hasVeggies.value=value;
                                      // print(FridgeController.controller.hasMeat.value);
                                    }))
                              ]),
                            ),
                            Container(
                              // color: Colors.blue,
                              width: 90,
                              child: Row(children: [
                                Text('과일'),
                                Obx( ()=>Switch(value: FridgeController.controller.hasFruits.value,
                                    onChanged: (value) {
                                      FridgeController.controller.toggleFood(
                                          FridgeController.controller.hasFruits, 'fruits');
                                      FridgeController.controller.hasFruits.value=value;
                                      // print(FridgeController.controller.hasMeat.value);
                                    }))
                              ]),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              // color: Colors.blue,
                              width: 90,
                              child: Row(children: [
                                Text('양념'),
                                Obx( ()=>Switch(value: FridgeController.controller.hasSauce.value,
                                    onChanged: (value) {
                                      FridgeController.controller.toggleFood(
                                          FridgeController.controller.hasSauce, 'sauce');
                                      FridgeController.controller.hasSauce.value=value;
                                      // print(FridgeController.controller.hasMeat.value);
                                    }))
                              ]),
                            ),
                            Container(
                              // color: Colors.blue,
                              width: 90,
                              child: Row(children: [
                                Text('간식'),
                                Obx( ()=>Switch(value: FridgeController.controller.hasSnacks.value,
                                    onChanged: (value) {
                                      FridgeController.controller.toggleFood(
                                          FridgeController.controller.hasSnacks,
                                          'snacks');
                                      FridgeController.controller.hasSnacks.value=value;
                                      // print(FridgeController.controller.hasMeat.value);
                                    }))
                              ]),
                            ),
                            Container(
                              // color: Colors.blue,
                              width: 90,
                              child: Row(children: [
                                Text('음료'),
                                Obx( ()=>Switch(value: FridgeController.controller.hasDrinks.value,
                                    onChanged: (value) {
                                      FridgeController.controller.toggleFood(
                                          FridgeController.controller.hasDrinks,
                                          'drinks');
                                      FridgeController.controller.hasDrinks.value=value;
                                      // print(FridgeController.controller.hasMeat.value);
                                    }))
                              ]),
                            ),

                          ],
                        )
                      ],
                    )

                ]),
              ),
            ),
            Container(
              height: 300,
              color: Colors.blue,
            ),
            BottomButtonIconRow(pageFrom: 'Fridge')
          ],
        ),
      ),
    );
  }
}
