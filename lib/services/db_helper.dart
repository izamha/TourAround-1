import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tour_around/models/user.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'users.db');
    print("db location: $path");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY,
      username TEXT NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL,
      userType TEXT NOT NULL,
      photoUrl TEXT NOT NULL,
      uid TEXT NOT NULL
    )
 ''');
  }

  Future<List<User>> getUsers() async {
    Database db = await instance.database;
    var users = await db.query('users', orderBy: 'username');
    List<User> usersList =
        users.isNotEmpty ? users.map((c) => User.fromJson(c)).toList() : [];
    return usersList;
  }

  Future<User?> signInUserWithLocalEmailAndPassword(
    String email,
    String password,
  ) async {
    Database db = await instance.database;
    var response = await db.rawQuery(
        "SELECT * FROM users WHERE email = '$email' and password = '$password'");

    if (response.isNotEmpty) {
      return User.fromJson(response.first);
    }

    return null;
  }

  Future<int> addUser(User user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toJson());
  }

  Future<int> removeUser(int id) async {
    Database db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    return await db.update('users', user.toJson(),
        where: 'uid = ?', whereArgs: [user.uid]);
  }
}
