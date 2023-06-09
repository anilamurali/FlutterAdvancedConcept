import 'package:advancedflutter/sqflite/db/SQLHelper.dart';
import 'package:advancedflutter/sqflite/screens/Admin.dart';
import 'package:advancedflutter/sqflite/screens/Home.dart';
import 'package:advancedflutter/sqflite/screens/login_signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class LoginPage extends StatefulWidget{

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var formkey=GlobalKey<FormState>();
  final TextEditingController conemail=TextEditingController();
  final TextEditingController conpass=TextEditingController();
  var showpass= true;

  void  logincheck(String email, String pasword) async {
    if (email == 'admin@gmail.com' && pasword == '12345678') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AdminPage()));
    }
    else{
      var data= await SQLHelper.CheckLogin(email,pasword);
      if(data.isNotEmpty){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home(data: data,)));

      }
      else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login_and_SignUp()));
      }


    }
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: formkey,
          child: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10,),
                  child: Text("Login",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                ),
                const Padding(
                  padding:  EdgeInsets.only(left: 10,right: 10,top: 20),
                  child: Text("Welcome back! Login with your Credentials"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: TextFormField(
                    controller: conemail,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_2_sharp),
                        hintText: "Email ID",
                        labelText: "Email ID",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    validator: (email){
                      if(email !.isEmpty || !email.contains("@")){
                        return "Enter a valied Email ID";
                      }
                      else{
                        return null;
                      }

                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
                  child: TextFormField(
                    controller: conpass,
                    obscureText: showpass,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.visibility_off),
                        labelText: "Password",
                        hintText: "Password",
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            if (showpass) {
                              showpass=false;

                            }
                            else{
                              showpass=true;
                            }
                          });
                        }, icon: Icon(showpass==true ? Icons.visibility_off :Icons.visibility)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    validator: (password){
                      if(password !.isEmpty || password.length<8){
                        return "Enter a valied password";

                      }
                      else{
                        return null;
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 60,
                    width: 500,
                    child: ElevatedButton(onPressed: (){
                      final valied= formkey.currentState!.validate();
                      if(valied){
                        logincheck(conemail.text, conpass.text);
                      }
                      else{
                        return null;
                      }

                    }, child: Text("Login"),
                      style: ElevatedButton.styleFrom(shape: StadiumBorder()),),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.only(top: 20),
                  child: Text("Do you have an account? Sign Up"),
                )
              ],
            ),
          )),
    );
  }


}