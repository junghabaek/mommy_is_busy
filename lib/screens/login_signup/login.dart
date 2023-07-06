import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';
import 'package:mommy_is_busy/screens/login_signup/login_or_signup.dart';

class LogInPage extends StatelessWidget {
  LogInPage({super.key});


  // TextEditingController nicknameController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  // var formKey = GlobalKey<FormState>();

  late String email;
  late String password;
  late String nickName;

  void setEmail(String val){
    email = val;
  }

  void setPassword(String val){
    password = val;
  }

  void setNickName(String val){
    nickName=val;
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.orange,
      body: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: width*.2),
                    child: Image(image: AssetImage('image/family.png'), width: width*.5, height: width*.5,)),
                Text('Please sign in or sign up to continue'),

                SizedBox(height: height*.05,),

                Obx(()=> AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    width: width*.9,
                    height: AuthController.controller.isLoginPressed.value? 200: 250,
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children:[
                            GestureDetector(
                              onTap: (){AuthController.controller.isLoginPressed.value=true;},
                              child: Column(children: [
                                Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                SizedBox(height: 4,),
                                Container(width: 40, height: 2, color: AuthController.controller.isLoginPressed.value? Colors.blue : null,)
                              ],),),
                            GestureDetector(
                              onTap: (){AuthController.controller.isLoginPressed.value=false;},
                              child: Column(children: [
                                Text('SIGN UP', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                SizedBox(height: 4,),
                                Container(width: 50, height: 2, color: !AuthController.controller.isLoginPressed.value? Colors.blue : null,)
                              ],),)

                          ],
                        ),

                        SizedBox(height: height*.03,),

                        Container(
                          width: width*.8,
                          child :
                              AuthController.controller.isLoginPressed.value?
                              LoginSelected(setEmail: setEmail, setPassword: setPassword,) :
                                  SignupSelected(setEmail: setEmail, setNickName: setNickName, setPassword: setPassword,)

                        ),

                      ],
                    ),
                  ),

                ),

          ElevatedButton(onPressed: (){
            if (AuthController.controller.isLoginPressed.value){
              AuthController.controller.login(email, password);
            }else{
              AuthController.controller.signup(email, password);
            }
          }, child: Icon(Icons.arrow_forward)),

                // AnimatedContainer(
                //   duration: Duration(milliseconds: 500),
                //   curve: Curves.easeIn,
                //   child: ElevatedButton(onPressed: (){}, child: Icon(Icons.arrow_forward),),
                // ),


            ]
            ),
          ),
        ),
      )
    );
  }
}
