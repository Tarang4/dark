import 'package:demo_of/modals/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:demo_of/modals/task.dart';

class DatabaseUtils {
  DatabaseUtils._();

  static final DatabaseUtils db = DatabaseUtils._();

  Database? _database;
  String? path;

  String demoTable = "CREATE TABLE etc ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "title TEXT,"
      "note TEXT,"
      "date TEXT,"
      "startTime TEXT,"
      "endTime TEXT,"
      "color INTEGER,"
      "remind INTEGER,"
      "repeat TEXT"
      ")";

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    try {
      String demoPath = await getDatabasesPath();
      path = join(demoPath, "notes.db");
      return await openDatabase(path ?? "", version: 1,
          onCreate: (Database database, int version) async {
        await database.execute(demoTable);
      });
    } catch (e) {}
  }

  insertDatabase(
    String title,
    String note,
    String date,
    String startTime,
    String endTime,
    int color,
    int remind,
    String repeat,
  ) async {
    try {
      final db = await database;
      // Map<String,dynamic> map={};
      // map["title"]="tarang";
      UserModel model = UserModel(
          title: title,
          note: note,
          date: date,
          startTime: startTime,
          endTime: endTime,
          color: color,
          remind: remind,
          repeat: repeat);
      final result = await db?.insert("etc", model.toJson());
    } catch (e) {}
  }

  deleteData(String title) async {
    try {
      final db = await database;
      await db?.rawDelete('DELETE FROM etc WHERE title=?', [title]);
    } catch (e) {}
  }

  // Future<List<UserModel>> updateModel(
  //   String title,
  //   String note,
  //   String date,
  //   String startTime,
  //   String endTime,
  //   int color,
  //   int remind,
  //   String repeat,
  // ) async {
  //   List<UserModel> userList = [];
  //   UserModel userModel = UserModel();
  //   Map row = userModel.toJson();
  //   try {
  //     final db = await database;
  //     UserModel model = UserModel(
  //         title: title,
  //         note: note,
  //         date: date,
  //         startTime: startTime,
  //         endTime: endTime,
  //         color: color,
  //         remind: remind,
  //         repeat: repeat);
  //     // var result = await db?.update('etc',model.toJson(),
  //     //     where: "title = ?", whereArgs: [UserModel().title]);
  //     var result = await db
  //         ?.rawUpdate("UPDATE etc SET title='okboss',note='jjiui' WHERE id=16");
  //     result?.forEach((element) {
  //       userModel = UserModel.fromJson(element);
  //       userList.add(userModel);
  //     });
  //   } catch (e) {}
  //   return userList;
  // }

  Future<void> updateDog() async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db
        ?.rawUpdate("UPDATE etc SET title='okboss',note='jjiui' WHERE id=16");
  }

  Future<void> updateDogBox(int update,
    String title,
    String note,
    String date,
    String startTime,
    String endTime,
    int color,
    int remind,
    String repeat,
  ) async {
    // Get a reference to the database.
    final db = await database;

    UserModel model = UserModel(
        title: title,
        note: note,
        date: date,
        startTime: startTime,
        endTime: endTime,
        color: color,
        remind: remind,
        repeat: repeat);
    await db?.rawUpdate(
        "UPDATE etc SET title='${model.title}',note='${model.note}' ,date='${model.date}',startTime='${model.startTime}',endTime='${model.endTime}',color=${model.color},remind=${model.remind},repeat='${model.repeat}' WHERE id=$update");
  }

  Future<List<UserModel>> getData() async {
    List<UserModel> userList = [];
    UserModel userModel = UserModel();
    try {
      final db = await database;
      final result = await db?.rawQuery("SELECT * FROM etc");
      result?.forEach((element) {
        userModel = UserModel.fromJson(element);
        userList.add(userModel);
      });
    } catch (e) {}
    return userList;
  }
}
