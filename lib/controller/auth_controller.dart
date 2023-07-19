import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/controller/deprecated_fridge_controller.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:mommy_is_busy/screens/main_page.dart';

import '../screens/login_signup/login.dart';
import 'calendar_controller.dart';
import 'fridge_controller.dart';

class AuthController extends GetxController{
  static AuthController controller = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  RxBool isLoginPressed = true.obs;
  final loginFormKey = UniqueKey().obs;
  final signupFormKey = UniqueKey().obs;

  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(authentication.currentUser);
    _user.bindStream(authentication.userChanges());
    ever(_user, _moveToPage);
  }

  _moveToPage(User? user) async {
    if (user == null){
      Get.offAll(()=>LogInPage());
    }else{
      FirestoreController.controller.eventList.clear();
      FirestoreController.controller.eventMap.clear();
      await FirestoreController.controller.getEvents(CalendarController.controller.selectedDayFromHome.value);
      Get.offAll(()=>Home());
    }
  }

  void login(String email, String password) async {
    await authentication.signInWithEmailAndPassword(email: email, password: password);
  }

  void signup(String email, String password, String nickname) async {
    await authentication.createUserWithEmailAndPassword(email: email, password: password);
    await FirestoreController.controller.firestore.collection('user').doc(authentication.currentUser!.uid).set({
      'nickname' : nickname,
      'email_address' : email,
      'sharing_code' : 0,
      'connected_id' : ' ',
    });

    await FirestoreController.controller.firestore.collection('user').doc(authentication.currentUser!.uid).collection('fridge').doc('default_fridge').set({
      'hasMeat' : false,
      'hasVeggies' : false,
      'hasFruits' : false,
      'hasSauce' : false,
      'hasSnacks' : false,
      'hasDrinks' : false,
      'memo' : ' ',
    });
  }

  void updateSharingCode(int sharingCode) async {
    await FirestoreController.controller.firestore.collection('user').doc(authentication.currentUser!.uid).update({
      'sharing_code' : sharingCode,
    });



  }

  Future<bool> connectWithSharingCode(int sharingCode) async{
    // String documentName;
    var querySnapshot = await FirestoreController.controller.firestore.collection('user').where('sharing_code', isEqualTo: sharingCode).get();
    if (querySnapshot.size==0){
      return false;
    }else {


      String docId = querySnapshot.docs[0].id;

      print(docId);
      print(authentication.currentUser!.uid);
      await FirestoreController.controller.firestore.collection('user').doc(authentication.currentUser!.uid).update({'connected_id': docId,});

      return true;
    }
    // then((querySnapshot){querySnapshot.docs.forEach((var doc){print(doc.id);});});
  }

  void signOut() async {
    await authentication.signOut();
  }

}