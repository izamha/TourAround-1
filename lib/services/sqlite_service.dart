import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'places.db'),
        onCreate: (database, version) async {
      await database.execute(
          "CREATE TABLE Places(id INTEGER PRIMARY KEY AUTOINCREMENT, lat INTEGER NOT NULL, lng INTEGER NOT NULL, placeName TEXT NOT NULL, placeDesc TEXT NULL,)");
    });
  }
}
