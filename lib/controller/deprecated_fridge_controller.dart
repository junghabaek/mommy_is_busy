// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mommy_is_busy/controller/auth_controller.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class FridgeController extends GetxController{
//   static FridgeController controller = Get.find();
//
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//
//   String? uid;
//
//   late RxBool hasMeat;
//   late RxBool hasVeggies;
//   late RxBool hasFruits;
//   late RxBool hasSauce;
//   late RxBool hasSnacks;
//   late RxBool hasDrinks;
//   // late SharedPreferences pref;// 매번 함수를 부를 때 마다 만들고싶진 않은데...
//
//   // final SharedPreferences pref = await SharedPreferences.getInstance();
//
//   var textController = TextEditingController().obs;
//   RxString text = ''.obs;
//
//   Future<void> Fridge() async {
//     final SharedPreferences pref = await _prefs;
//
//     print('**************');
//     uid = AuthController.controller.authentication.currentUser==null? 'not logged in' : AuthController.controller.authentication.currentUser!.uid;
//     print(uid);
//
//     //   //'meat - uid' 가 초기화 되지 않은 경우
//     //   if (pref.getBool('meat - $uid') == null){
//     //     pref.setBool('meat - $uid', false); // data persists in filesystem
//     //     hasMeat = pref.getBool('meat - $uid')!.obs; // hasMeat is set to a value
//     //   } else { // pref.getBool('meat - $uid) 가 존재하면
//     //     // pref.setBool은 할 필요가 없고
//     //   }
//     //   hasMeat = pref.getBool('meat - $uid')!.obs;
//     //
//     // }
//
//     //위의 코드는 이렇게 더 간단하게 고칠 수 있다
//
//     if (pref.getBool('meat - $uid') == null)
//       pref.setBool('meat - $uid', false);
//     hasMeat = pref.getBool('meat - $uid')!.obs;
//
//     if (pref.getBool('veggies - $uid') == null)
//       pref.setBool('veggies - $uid', false);
//     hasVeggies = pref.getBool('veggies - $uid')!.obs;
//
//     if (pref.getBool('fruits - $uid') == null)
//       pref.setBool('fruits - $uid', false);
//     hasFruits = pref.getBool('fruits - $uid')!.obs;
//
//     if (pref.getBool('sauce - $uid') == null)
//       pref.setBool('sauce - $uid', false);
//     hasSauce = pref.getBool('sauce - $uid')!.obs;
//
//     if (pref.getBool('snacks - $uid') == null)
//       pref.setBool('snacks - $uid', false);
//     hasSnacks = pref.getBool('snacks - $uid')!.obs;
//
//     if (pref.getBool('drinks - $uid') == null)
//       pref.setBool('drinks - $uid', false);
//     hasDrinks = pref.getBool('drinks - $uid')!.obs;
//
//     if(pref.getString('text - $uid') == null || pref.getString('text - $uid') == '')
//       pref.setString('text - $uid', '메모');
//     text = pref.getString('text - $uid')!.obs;
//     textController.value.text = (text.value);
//
//   }
//
//   Future<void> toggleFood(RxBool hasFood, String food) async {
//     final SharedPreferences pref = await _prefs;
//
//     if (!hasFood.value){ // hasMeat과 sharedPreferences를 둘다 바꿔줘야함
//       hasFood = false.obs;
//       pref.setBool('$food - $uid', false);
//     }else{
//       hasFood = true.obs;
//       pref.setBool('$food - $uid', true);
//     }
//
//     // print(hasMeat.value);
//
// }
//
//
//   Future<void> saveSharedText(String text) async{
//     final SharedPreferences pref = await _prefs;
//
//     pref.setString('text - $uid', text);
//   }
//
//   Future<void> clearSharedText() async{
//     final SharedPreferences pref = await _prefs;
//
//     pref.setString('text - $uid', '');
//   }
//
//
//
//
//
// }
//
// // I/flutter ( 5698): 2023-07-10 15:00:00.000Z
// // I/flutter ( 5698): 2023-07-11 15:00:00.000Z