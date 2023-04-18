import 'package:sqflite/sqflite.dart' as sql;
class SQLHelper{

static Future<void> createTables(sql.Database database) async {
  await database.execute("""CREATE TABLE todo(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        desc TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
}
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'mytodo.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static AddTask(String title, String desc) async{
  final db=await SQLHelper.db();
  final data= {'tilte':title,'desc':desc};
  final id= await db.insert('todo', data);
  }

}