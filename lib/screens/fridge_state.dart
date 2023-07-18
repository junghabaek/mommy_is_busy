import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/screens/bottom_button_icons.dart';
import 'package:get/get.dart';

import '../controller/deprecated_fridge_controller.dart';
import '../controller/fridge_controller.dart';

class Fridge extends StatelessWidget {
  const Fridge({super.key});


  @override
  Widget build(BuildContext context) {

    TextEditingController controller = TextEditingController();
    controller.text = FridgeController.controller.memo.value;
    Stream<DocumentSnapshot> documentSnapshot = FridgeController.controller.getDocumentSnapshot();

    return Scaffold(
      appBar: AppBar(title: Text('냉장고 관리',),
        centerTitle: true,),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: FloatingActionButton.small(onPressed: () {
          FridgeController.controller.textController.value.clear();
          FridgeController.controller.clearSharedText();
        }, backgroundColor: Colors.orangeAccent, child: Icon(Icons.clear)
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: documentSnapshot,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GestureDetector(
            onTap: (){FocusScope.of(context).unfocus();},
            child: Container(
              width: double.maxFinite,
              color: Colors.orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SizedBox(height: 100,),
                  // Text('우리집 냉장고를 관리해봐요'),
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
                                        Switch(value: snapshot.data!.get('hasMeat'),
                                            onChanged: (value) {
                                              FridgeController.controller.toggleFood(
                                                  FridgeController.controller.hasMeat,
                                                  'hasMeat');
                                              // FridgeController.controller.hasMeat.value=value;
                                              // print(FridgeController.controller.hasMeat.value);
                                            })
                                      ]),
                                    ),
                                    Container(
                                      // color: Colors.blue,
                                      width: 90,
                                      child: Row(children: [
                                        Text('채소'),
                                        Switch(value: snapshot.data!.get('hasVeggies'),
                                            onChanged: (value) {
                                              FridgeController.controller.toggleFood(FridgeController.controller.hasVeggies, 'hasVeggies');
                                              // FridgeController.controller.hasVeggies.value=value;
                                              // print(FridgeController.controller.hasMeat.value);
                                            })
                                      ]),
                                    ),
                                    Container(
                                      // color: Colors.blue,
                                      width: 90,
                                      child: Row(children: [
                                        Text('과일'),
                                        Switch(value: snapshot.data!.get('hasFruits'),
                                            onChanged: (value) {
                                              FridgeController.controller.toggleFood(
                                                  FridgeController.controller.hasFruits, 'hasFruits');
                                              // FridgeController.controller.hasFruits.value=value;
                                              // print(FridgeController.controller.hasMeat.value);
                                            })
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
                                        Switch(value: snapshot.data!.get('hasSauce'),
                                            onChanged: (value) {
                                              FridgeController.controller.toggleFood(
                                                  FridgeController.controller.hasSauce, 'hasSauce');
                                              // FridgeController.controller.hasSauce.value=value;
                                              // print(FridgeController.controller.hasMeat.value);
                                            })
                                      ]),
                                    ),
                                    Container(
                                      // color: Colors.blue,
                                      width: 90,
                                      child: Row(children: [
                                        Text('간식'),
                                        Switch(value:snapshot.data!.get('hasSnacks'),
                                            onChanged: (value) {
                                              FridgeController.controller.toggleFood(
                                                  FridgeController.controller.hasSnacks,
                                                  'hasSnacks');
                                              // FridgeController.controller.hasSnacks.value=value;
                                              // print(FridgeController.controller.hasMeat.value);
                                            })
                                      ]),
                                    ),
                                    Container(
                                      // color: Colors.blue,
                                      width: 90,
                                      child: Row(children: [
                                        Text('음료'),
                                        Switch(value: snapshot.data!.get('hasDrinks'),
                                            onChanged: (value) {
                                              FridgeController.controller.toggleFood(
                                                  FridgeController.controller.hasDrinks,
                                                  'hasDrinks');
                                              // FridgeController.controller.hasDrinks.value=value;
                                              // print(FridgeController.controller.hasMeat.value);
                                            })
                                      ]),
                                    ),

                                  ],
                                )
                              ],
                            )

                          ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){FocusScope.of(context).focusedChild!;},
                    child: SingleChildScrollView(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.fromLTRB(15, 0, 15, 5),
                          height: MediaQuery.of(context).size.height*.2,
                          child:
                          Obx( ()=>TextFormField(
                            // snapshot.data!.get('hasMeat')
                            minLines: 1,
                            maxLines: 30,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(border: InputBorder.none
                              ,),
                            // suffixIcon: FridgeController.controller.textController.value.text.isEmpty?
                            // null : IconButton(onPressed: (){FridgeController.controller.textController.value.clear();},
                            //     icon: Icon(Icons.clear, color: Colors.black,))),
                            controller: FridgeController.controller.textController.value,
                            // initialValue: snapshot.data!.get('memo'),
                            onChanged: (text){
                              // controller.text = snapshot.data!.get('memo');
                              FridgeController.controller.saveSharedText(text);
                              // FridgeController.controller.textController.value.text = text;

                            },
                            onSaved: (text){},
                          ),

                      )
                      )
                      ),
                    ),
                  BottomButtonIconRow(pageFrom: 'Fridge')
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
