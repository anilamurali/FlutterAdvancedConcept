import 'package:advancedflutter/Shared_prefernces/Register%20and%20login/Login.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Registeration(),
    );
  }
}
class Registeration extends StatefulWidget {
  const Registeration({Key? key}) : super(key: key);

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final name_controller=TextEditingController();
  final username_controller=TextEditingController();
  final password_controller=TextEditingController();
  late SharedPreferences logindata;


  @override
  void dispose() {
    name_controller.dispose();
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Preferences"),),
      body: Center(
        child: Column(
          children:  [
            const Text(
              "Register Form",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              "To show Example of Shared Preferences",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: name_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: username_controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
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
              Registerr();
              }, child: Text("Register"))

          ],
        ),
      ),

    );
  }

  void Registerr() async {
    logindata=await SharedPreferences.getInstance();


    String name = name_controller.text;
    String username = username_controller.text;
    String password=password_controller.text;

    if(username != "" && password != "" ){
      logindata.setString("name",name);
      logindata.setString("username",username);
      logindata.setString("password",password);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }

  }


}