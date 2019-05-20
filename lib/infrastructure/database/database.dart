import "dart:async";
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelper<M> {
  Future<int> save(M);
  Future<int> delete(M);
  Future<int> deleteAll(M);
}

abstract class BaseDatabaseImplement<M> implements DatabaseHelper<M> {
  Database _db;
  String table;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  void setTable(String value) {
    table = value;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE User(id INTEGER PRIMARY KEY, name TEXT, username TEXT, email TEXT)");
    print("Table is created");
  }

  @override
  Future<int> save(M) async {
    var dbClient = await db;
    int id = M.id;
    List users = await dbClient.rawQuery('select * from $table where id = $id');
    if (users.length > 0) {
      try {
        await dbClient.update("$table", toMap(M), where: "id = ?", whereArgs: [id]);
      } catch(e) {
        e.toString();
      }
      return -1;
    }
    int res = await dbClient.insert("$table", toMap(M));
    return res;
  }

  @override
  Future<int> delete(M) async {
    var dbClient = await db;
    int id = M.id;
    int res = await dbClient.delete("$table", where: "id = ?", whereArgs: [id]);
    return res;
  }

  @override
  Future<int> deleteAll(M) async {
    final dbClient = await db;
    dbClient.rawDelete("Delete * from $table");
  }

  Map toMap(M object);
}