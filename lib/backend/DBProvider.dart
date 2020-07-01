import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Dall.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("""
          CREATE TABLE Service (
          id INTEGER PRIMARY KEY autoincrement,
          serviceName TEXT,
          serviceDesc TEXT
          serviceAddress TEXT
          servicePhone TEXT
          serviceWhats TEXT
          serviceNote TEXT
          categoryId INTEGER
          updatedAt TEXT,
          facebook TEXT,
          twitter TEXT,
          telegram TEXT
          )
          """);
    });
  }
/*
  saveServiceList(List<Service> items) async {
    for (var i = 0; i < items.length; i++) {
      Service item = items[i];
      var res = await _database
          .query('Service', where: "id = ?", whereArgs: [item.id]);
      if (res.isEmpty) {
        await _database.insert('Service', item.toJson());
      } else {
        await _database.update('Service', item.toJson(),
            where: "id = ?", whereArgs: [item.id]);
      }
    }
  }

  getServiceList(int categoryId) async {
    var res = await _database.query('Service', where: "categoryId = ?", whereArgs: [categoryId] );
    List<Service> list = res.isNotEmpty ? res.map((c) => Service.fromJson(c)).toList() : [];
    return list;
  }*/
}
