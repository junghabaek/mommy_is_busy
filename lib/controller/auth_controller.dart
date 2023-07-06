import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mommy_is_busy/screens/main_page.dart';

import '../screens/login_signup/login.dart';

class AuthController extends GetxController{
  static AuthController controller = Get.find();
  late Rx<User?> _user;
  FirebaseAuth authentication = FirebaseAuth.instance;
  RxBool isLoginPressed = true.obs;
  final formKey = GlobalKey<FormState>().obs;

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
      Get.offAll(()=>MainPage());
    }
  }

  void login(String email, String password) async {
    await authentication.signInWithEmailAndPassword(email: email, password: password);
  }

  void signup(String email, String password) async {
    await authentication.createUserWithEmailAndPassword(email: email, password: password);
  }

  void signout() async {
    await authentication.signOut();
  }

}