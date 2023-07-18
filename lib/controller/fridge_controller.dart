import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FridgeController extends GetxController{
  static FridgeController controller = Get.find();


  RxString connectedId = ' '.obs;

  RxBool hasMeat = false.obs;
  RxBool hasVeggies = false.obs;
  RxBool hasFruits = false.obs;
  RxBool hasSauce = false.obs;
  RxBool hasSnacks = false.obs;
  RxBool hasDrinks = false.obs;
  var textController = TextEditingController().obs;
  RxString memo = 'memo'.obs;

  Future<void> loadFridge() async {


    DocumentSnapshot snapshot = await FirestoreController.controller.firestore
        .collection('user').doc(
        AuthController.controller.authentication.currentUser!.uid).get();

    connectedId.value = snapshot.get('connected_id');
    print('connectedId.value from loadFridge is called');
    print(connectedId.value);



    DocumentSnapshot FridgeDocumentSnapshot;

    if (connectedId==' ') { // 연결된 계정이 없다면, 자기 자신의 계정의 냉장고를 본다.
      FridgeDocumentSnapshot = await FirestoreController
          .controller.firestore.collection('user').doc(
          AuthController.controller.authentication.currentUser!.uid).collection(
          'fridge').doc('default_fridge').get();
    } else{ // 연결된 계정이 있다면, 연결된 계정의 냉장고를 본다.
      FridgeDocumentSnapshot = await FirestoreController
          .controller.firestore.collection('user').doc(connectedId.value).collection(
          'fridge').doc('default_fridge').get();
    }
    // if (connectedId == ' ') { //if no other account is connected
    //   DocumentSnapshot unConnectedFridgeDocumentSnapshot = await FirestoreController
    //       .controller.firestore.collection('user').doc(
    //       AuthController.controller.authentication.currentUser!.uid).collection('fridge').doc('default_fridge').get();
    //
    //   bool tempMeat = unConnectedFridgeDocumentSnapshot.get('hasMeat');
    //   hasMeat.value = tempMeat;
    //
    //   bool tempVeggies = unConnectedFridgeDocumentSnapshot.get('hasVeggies');
    //   hasVeggies.value = tempVeggies;
    //
    //   bool tempFruits = unConnectedFridgeDocumentSnapshot.get('hasFruits');
    //   hasFruits.value = tempFruits;
    //
    //   bool tempSauce = unConnectedFridgeDocumentSnapshot.get('hasSauce');
    //   hasSauce.value = tempSauce;
    //
    //   bool tempSnacks = unConnectedFridgeDocumentSnapshot.get('hasSnacks');
    //   hasSnacks.value = tempSnacks;
    //
    //   bool tempDrinks = unConnectedFridgeDocumentSnapshot.get('hasDrinks');
    //   hasDrinks.value = tempDrinks;

      String tempMemo = FridgeDocumentSnapshot.get('memo');
      memo.value = tempMemo;

      print(memo);
      textController.value.text = memo.value;


  }

    Future<void> toggleFood(RxBool hasFood, String food) async { // 값이 바뀌는게 바로바로 적용이 안된다. 아무래도 함수를 여러개 정의해야 할것 같다.
      String documentName = connectedId.value;
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
      String documentName = connectedId.value;
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
      String documentName = connectedId.value;
      if (connectedId == ' ') {
        documentName =
            AuthController.controller.authentication.currentUser!.uid;
      }

      await FirestoreController.controller.firestore.collection('user').doc(
          documentName).collection('fridge').doc('default_fridge').update({
        'memo': ' '
      });
    }

    Stream<DocumentSnapshot> getDocumentSnapshot() {
      String documentName = connectedId.value;
      if (connectedId.value == ' ') {
        documentName =
            AuthController.controller.authentication.currentUser!.uid;
      }
      print('connectedId $connectedId');
      print('documentName');
      print(documentName);
      return FirestoreController.controller.firestore.collection('user/$documentName/fridge').doc('default_fridge').snapshots();
    }
  }


// I/flutter ( 5698): 2023-07-10 15:00:00.000Z
// I/flutter ( 5698): 2023-07-11 15:00:00.000Z