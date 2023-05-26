import 'dart:html';

import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/Screens/home.dart';
import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/Screens/signup.dart';
import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/database/DBFunctins.dart';
import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Login extends StatelessWidget {
  final email= TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page'),),
      body:  Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                hintText: 'Username'
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: pass,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                  hintText: 'Password',

              ),
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: () async{
              final userList=await DataBasee.instance.getUser();
              checkUser(userList);//check the entered value is fount in db
              email.text = '';
              pass.text = '';

            }, child: const Text('Login')),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(onPressed: (){
              Get.to(()=>Register());
            }, child: const Text('Not a user ? Register !!')),
          )
        ],
      ),
      
    );
  }

  Future<void> checkUser(List<User> userList) async {
    final mail = email.text.trim();
    final pwd = pass.text.trim();
    bool isUserFount=false;
    final validateEmpty= await ValidateLogin(mail,pwd);
    if(validateEmpty == true){
      await Future.forEach(userList, (users){
        if(users.email == mail && users.password == pwd){
          isUserFount = true;
        }
        else
          {
            isUserFount = false;
          }
      });
      if(isUserFount == true){
        Get.offAll(()=> Home( email : mail));
        Get.snackbar("Success", "Logined in as $mail");
      }
      else{
        Get.snackbar("Failed", "Login Failed");
      }
    }
    else{
      Get.snackbar("Error", "Fields Must not be empty");
    }
  }

 Future<bool> ValidateLogin(String mail, String pwd) async {
    if(mail != '' && pwd !=''){
      return true;
    }
    else{

      return false;
    }
 }
}
