import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FridgeController extends GetxController{
  static FridgeController controller = Get.find();


  String connectedId = ' ';

  late RxBool hasMeat;
  RxBool hasVeggies = false.obs;
  RxBool hasFruits = false.obs;
  RxBool hasSauce = false.obs;
  RxBool hasSnacks = false.obs;
  RxBool hasDrinks = false.obs;
  var textController = TextEditingController().obs;
  RxString memo = 'memo'.obs;

  Future<void> loadFridge() async {
    hasMeat = false.obs;

    DocumentSnapshot snapshot = await FirestoreController.controller.firestore
        .collection('user').doc(
        AuthController.controller.authentication.currentUser!.uid).get();

    connectedId = snapshot.get('connected_id');

    if (connectedId == ' ') { //if no other account is connected
      DocumentSnapshot unConnectedFridgeDocumentSnapshot = await FirestoreController
          .controller.firestore.collection('user').doc(
          AuthController.controller.authentication.currentUser!.uid).collection('fridge').doc('default_fridge').get();

      bool tempMeat = unConnectedFridgeDocumentSnapshot.get('hasMeat');
      hasMeat.value = tempMeat;

      bool tempVeggies = unConnectedFridgeDocumentSnapshot.get('hasVeggies');
      hasVeggies.value = tempVeggies;

      bool tempFruits = unConnectedFridgeDocumentSnapshot.get('hasFruits');
      hasFruits.value = tempFruits;

      bool tempSauce = unConnectedFridgeDocumentSnapshot.get('hasSauce');
      hasSauce.value = tempSauce;

      bool tempSnacks = unConnectedFridgeDocumentSnapshot.get('hasSnacks');
      hasSnacks.value = tempSnacks;

      bool tempDrinks = unConnectedFridgeDocumentSnapshot.get('hasDrinks');
      hasDrinks.value = tempDrinks;

      String tempMemo = unConnectedFridgeDocumentSnapshot.get('memo');
      memo = tempMemo.obs;

      print(tempMeat);
      print(memo);
      textController.value.text = memo.value;


    }
  }

    Future<void> toggleFood(RxBool hasFood, String food) async { // 값이 바뀌는게 바로바로 적용이 안된다. 아무래도 함수를 여러개 정의해야 할것 같다.
      String documentName = connectedId;
      if (connectedId == ' ') {
        documentName =
            AuthController.controller.authentication.currentUser!.uid;
      }

      print(documentName);


      if (hasFood.value) {
        hasFood.value = false;
        await FirestoreController.controller.firestore.collection('user').doc(
            documentName).collection('fridge').doc('default_fridge').update({
          food : false
        });
      } else {
        hasFood.value = true;
        await FirestoreController.controller.firestore.collection('user').doc(
            documentName).collection('fridge').doc('default_fridge').update({
          food: true
        });
      }
    }





    Future<void> saveSharedText(String text) async {
      String documentName = connectedId;
      if (connectedId == ' ') {
        documentName =
            AuthController.controller.authentication.currentUser!.uid;
      }

      await FirestoreController.controller.firestore.collection('user').doc(
          documentName).collection('fridge').doc('default_fridge').update({
        'memo': text
      });
    }

    Future<void> clearSharedText() async {
      String documentName = connectedId;
      if (connectedId == ' ') {
        documentName =
            AuthController.controller.authentication.currentUser!.uid;
      }

      await FirestoreController.controller.firestore.collection('user').doc(
          documentName).collection('fridge').doc('default_fridge').update({
        'memo': ' '
      });
    }
  }


// I/flutter ( 5698): 2023-07-10 15:00:00.000Z
// I/flutter ( 5698): 2023-07-11 15:00:00.000Z