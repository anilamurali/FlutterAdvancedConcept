import 'package:advancedflutter/hive_todo/Hive%20using%20adapter/model/user_model.dart';
import 'package:hive/hive.dart';

class DataBasee{

  DataBasee._internal();

  static DataBasee instance = DataBasee._internal();

  factory DataBasee(){  // Factory Constructor for Creating singleton class

      return instance;// These class have only one instance
  }
  Future<void> userSignUp(User user) async{
    final db =await Hive.openBox<User>('user');
    db.put(user.id, user);
  }
// get all the registered user
 Future<List<User>> getUser() async {
    final db =await Hive.openBox<User>('user');
    return db.values.toList();

  }
}