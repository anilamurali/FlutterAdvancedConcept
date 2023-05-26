import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('todo_box');
  //await Hive.deleteBoxFromDisk('todo_box'); delete the hivebox from phone storage
  runApp(MaterialApp(home: MyTodo() ));
}

class MyTodo  extends StatefulWidget{
  @override
  State<MyTodo> createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  List<Map<String,dynamic>> tasks=[];
  final TextEditingController title =TextEditingController();
  final TextEditingController task=TextEditingController();

  //Hive class object
  final my_task_box = Hive.box('todo_box');


  @override
  initState() {

    super.initState();
    fetchTask();
  }

  //Hive create operation
  Future<void> createTask(Map<String, dynamic> newtask ) async {
    await my_task_box.add(newtask);
    fetchTask();

  }

  //read single data

  //read all data frokm hive
  void fetchTask() {
    final task_from_hive= my_task_box.keys.map((key){
      final value= my_task_box.get(key);
      return {"id":key,"title":value["title"],"task":value["task"]};
    }).toList();

    setState(() {
      tasks=task_from_hive.reversed.toList();//reversed to sort item in the latest to oldest order
    });
  }
  //update task
  Future<void> updateTask(int itemkey, Map<String, String> uptask) async{
    await my_task_box.put(itemkey, uptask);
    fetchTask();

  }
  Future<void> deletTask(int itemkey) async {
    await my_task_box.delete(itemkey);
    fetchTask();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Successfully deleted')));
  }

  showTask(BuildContext context, int? itemkey) {
    if(itemkey != null){
      final existing_task= tasks.firstWhere((element) => element['id']==itemkey);
      title.text=existing_task['title'];
      task.text=existing_task['task'];

    }
    showModalBottomSheet(
        isScrollControlled: true,
        elevation: 5,
        context: context,
        builder: (ctx){
      return Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            right: 20,
            left: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                  hintText: "Title"
              ),
            ),
            TextField(
              controller: task,
              decoration: const InputDecoration(
                  hintText: "Task"
              ),
            ),
            ElevatedButton(onPressed: ()async{
              if( itemkey == null){
                createTask({
                  "title":title.text.trim(),
                  "task":task.text.trim(),
                });

              }
              if(itemkey != null){
                updateTask(itemkey,{
                  'title':title.text,
                  'task':task.text
                });
              }
              title.text="";
              task.text="";
              Navigator.of(context).pop();
            }, child: Text(itemkey == null ?"Create Task":"Update Task"))
          ],
        ),
      );
    });


  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ToDos"),),
      body: tasks.isEmpty ? const Text("No Task") : Container(
        child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder:(ctx,index){
              final mytask= tasks[index];
          return Card(
            child: ListTile(
              title: Text(mytask['title']),
              subtitle: Text(mytask['task']),
              trailing: Wrap(
                children: [
                   IconButton(onPressed: (){
                     showTask(context,mytask['id']);
                   }, icon: Icon(Icons.edit)),
                  IconButton(onPressed: (){
                    deletTask(mytask['id']);
                  }, icon: Icon(Icons.delete),)
                  ]
              ),
            ),
          );

        }),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()=>showTask(context,null),
      child: Icon(Icons.add),
      ),
    );
  }
}