// import 'package:advancedflutter/sqflite/SqfHelper.dart';
// import 'package:advancedflutter/sqflite/db/SQLHelper.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // Remove the debug banner
//         debugShowCheckedModeBanner: false,
//         title: 'Sqlite',
//         theme: ThemeData(
//           primarySwatch: Colors.orange,
//         ),
//         home: const Sqflite_Example());
//   }
// }
//
// class Sqflite_Example extends StatefulWidget {
//   const Sqflite_Example({Key? key}) : super(key: key);
//
//   @override
//   State<Sqflite_Example> createState() => _Sqflite_ExampleState();
// }
//
// class _Sqflite_ExampleState extends State<Sqflite_Example> {
//   final TextEditingController _descriptionController=TextEditingController();
//   final TextEditingController _titleController= TextEditingController();
//  void  _ShowForm(int? id) async {
//
//    showModalBottomSheet(context: context,
//        elevation: 5,
//        isScrollControlled: true,
//        builder: (_)=>Container(
//          child: Padding(
//            padding: EdgeInsets.only(
//              top: 15,
//              left: 15,
//              right: 15,
//                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
//            ),
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              crossAxisAlignment: CrossAxisAlignment.end,
//              children: [
//                TextField(
//                  controller: _titleController,
//                  decoration: const InputDecoration(hintText: 'Title'),
//                ),
//                const SizedBox(
//                  height: 10,
//                ),
//                TextField(
//                  controller: _descriptionController,
//                  decoration: const InputDecoration(hintText: 'Description'),
//                ),
//                const SizedBox(
//                  height: 20,
//                ),
//                ElevatedButton(onPressed: () async{
//                  if(id==null){
//                    await _addItem();
//                  }
//                  if(id != id){
//                   // await _updateItem(id);
//                  }
//                  _titleController.text="";
//                  _descriptionController.text="";
//                  Navigator.pop(context);
//
//                }, child:  Text(id == null ? "Creare Item" :"Update Item"))
//              ],
//            ),
//          ),
//        ));
//  }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(' SQFLite'),
//       ),
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: ()=> _ShowForm(null),
//         child:const Icon(Icons.add) ,
//       ),
//
//     );
//   }
//
//   Future <void> _addItem() async{
//     await SQLHelper.AddTask(_titleController.text,_descriptionController.text);
//   }
//
//
// }
