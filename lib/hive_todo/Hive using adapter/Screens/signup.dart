import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/Screens/login.dart';
import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/database/DBFunctins.dart';
import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/model/user_model.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final email= TextEditingController();
  final pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Login Page'),),
      body:  Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                  hintText: 'Name'
              ),
            ),
          ),

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
          ElevatedButton(onPressed: () async{
            final userList=await DataBasee.instance.getUser();

            validateSignUp(userList);
            email.text = '';
            pass.text = '';
          }, child: const Text('SignUp')),
          const SizedBox(height: 20,),
          TextButton(onPressed: (){
            Get.to(()=>Login());
          }, child: const Text('Alrady have an account !! Login'))
        ],
      ),



    );
  }

  void validateSignUp(List<User> userList) async{
    final mail= email.text.trim();
    final pwd=pass.text.trim();
    bool isUserFount = false;

    final emailVildation=EmailValidator.validate(mail);
    if(mail != null && pwd != null){
      if(emailVildation == true){
        await Future.forEach(userList, (users){
          if(users.email == mail){
            isUserFount = true;
          }
          else
          {
            isUserFount = false;
          }
        });
        if(isUserFount){
          Get.snackbar("Error", "User is already Registered");
        }
        else {
          final passwordValidation = checkPassword(pwd);
          if (passwordValidation == true) {
            final user = User(email: mail, password: pwd);
            await DataBasee.instance.userSignUp(user);
            Get.back();
            Get.snackbar("Success", "Account Created",);
          }
        }

      }
      else{
        Get.snackbar("Error", "Please Provide a Valied email",colorText: Colors.red);
      }
    }
    else{
      Get.snackbar("Error", "Fields cannot be empty",colorText: Colors.red);
    }

  }

 bool  checkPassword(String pwd) {
    if(pwd.length < 6){
      Get.snackbar("Error", "Password length should be grater than 6",colorText: Colors.red);
      return false;
    }
    else{
      return true;

    }
 }
}
