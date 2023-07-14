import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mommy_is_busy/controller/firestore_controller.dart';
import 'package:mommy_is_busy/controller/fridge_controller.dart';
import 'package:mommy_is_busy/screens/home.dart';
import 'package:mommy_is_busy/screens/main_page.dart';

import '../screens/login_signup/login.dart';

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

  _moveToPage(User? user){
    if (user == null){
      Get.offAll(()=>LogInPage());
    }else{
      FridgeController.controller.initFridge();
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
    });
  }

  void signOut() async {
    await authentication.signOut();
  }

}