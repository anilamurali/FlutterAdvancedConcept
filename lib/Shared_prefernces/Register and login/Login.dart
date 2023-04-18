import 'package:advancedflutter/Shared_prefernces/Register%20and%20login/Profile.dart';
import 'package:advancedflutter/Shared_prefernces/Register%20and%20login/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final username_controller=TextEditingController();
  final password_controller=TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  late String uname;
  late String pass;
  late String name;

  @override
  void initState(){
    check_if_already_login();
    getvalue();
  }
  void getvalue() async{
    logindata=await SharedPreferences.getInstance();
    setState(() {
      name=logindata.getString("name")!;
      uname=logindata.getString("username")!;
      pass=logindata.getString("password")!;
    });
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('newuser') ?? true);  // null ?? second
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    }


  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Preferences"),),
      body: Center(
        child: Column(
          children:  [
            const Text(
              "Login Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              "To show Example of Shared Preferences",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: password_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(onPressed: (){
              String username=username_controller.text;
              String password=password_controller.text;
              if(username!= '' && password!='' &&
              username==uname && password== pass
              ){
                print("Successful");
                print(uname);
                logindata.setBool("newuser", false);

                Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));
              }
            }, child: Text("Log in")),
            TextButton(onPressed: (){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Registeration()));
    }, child: Text("Not a user Register here!!!"))

          ],
        ),
      ),

    );
  }




}
