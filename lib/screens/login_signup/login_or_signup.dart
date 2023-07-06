import 'package:flutter/material.dart';
import 'package:mommy_is_busy/controller/auth_controller.dart';

class LoginSelected extends StatelessWidget {
  LoginSelected({super.key, required this.setEmail, required this.setPassword,});

  // TextEditingController emailController;
  // TextEditingController passwordController;
  Function setEmail;
  Function setPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: AuthController.controller.formKey.value,
      // key: UniqueKey(),
      child: Column(
          children: [
            TextFormField(
              key: ValueKey(1),
              onChanged: (val){
                setEmail(val);
              },
              // controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.email),
                hintText: 'email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35))
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),

            SizedBox(height: 5,),

            TextFormField(
              key: ValueKey(2),
              obscureText: true,
              onChanged: (val){
                setPassword(val);
              },
              // controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35))
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ]
      ),
    );
  }
}


class SignupSelected extends StatelessWidget {
  SignupSelected({super.key, required this.setEmail, required this.setPassword, required this. setNickName});

  // var formKey;
  // TextEditingController nicknameController;
  // TextEditingController emailController;
  // TextEditingController passwordController;

  Function setEmail;
  Function setPassword;
  Function setNickName;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: AuthController.controller.formKey.value,
      child: Column(
          children: [
            TextFormField(
              key: ValueKey(3),
              // controller: nicknameController,
              onChanged: (val){
                setNickName(val);
              },
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.account_circle),
                hintText: 'nickname',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35))
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            SizedBox(height: 5,),

            TextFormField(
              key: ValueKey(1),
              // controller: emailController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (val){
                setEmail(val);
              },
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.email),
                hintText: 'email',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35))
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),

            SizedBox(height: 5,),

            TextFormField(
              key: ValueKey(4),
              obscureText: true,
              // controller: passwordController,
              onChanged: (val){
                setPassword(val);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'password',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(35))
                ),
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ]
      ),
    );
  }
}
