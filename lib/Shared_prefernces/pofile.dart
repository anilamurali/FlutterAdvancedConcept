import 'package:advancedflutter/Shared_prefernces/mainpage.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
    initial();
  }
  void initial()  async{
    logindata= await SharedPreferences.getInstance();
    setState(() {
      username=logindata.getString('username')!;
    });
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Shared preferences"),),
      body: Center(
        child: Column(
          children: [
             Text("Welcome $username",style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ElevatedButton(onPressed: (){
              logindata.setBool('newuser', true);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyLoginPage()));
            }, child: const Text("Log Out"))
          ],
        ),
      ),
    );
  }

}
