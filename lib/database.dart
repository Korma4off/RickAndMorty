import 'dart:io';
import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  factory DatabaseHelper() => instance;
  DatabaseHelper._internal();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    String path = join(documentsDirectory.path, 'example.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS Characters (id INTEGER, name TEXT, status TEXT, species TEXT, gender TEXT, image TEXT)''');
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS Locations (id INTEGER, name TEXT, type TEXT, dimension TEXT)''');
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS Episodes (id INTEGER, name TEXT, air_date TEXT, episode TEXT)''');
    return;
  }

  Future<List<Map<String, Object?>>> getObject(String objectType) async {
    Database db = await database;
    var object = await db.query(objectType, orderBy: 'id');
    return object;
  }

  Future<Map<String, Object?>> getObjectFromId(
      String objectType, int id) async {
    Database db = await database;
    var character =
        await db.query(objectType, where: 'id = ?', whereArgs: [id]);
    return character[0];
  }

  Future<int> addObject(String objectType, Map<String, dynamic> object) async {
    Database db = await database;
    var result =
        await db.query(objectType, where: 'id = ? ', whereArgs: [object['id']]);
    return result.isEmpty
        ? await db.insert(objectType, object)
        : await db.update(objectType, object,
            where: 'id = ?', whereArgs: [object['id']]);
  }

  Future<int> removeObject(String objectType, int id) async {
    Database db = await database;
    return await db.delete(objectType, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateObject(
      String objectType, Map<String, dynamic> object) async {
    Database db = await database;
    return await db
        .update(objectType, object, where: 'id = ?', whereArgs: [object['id']]);
  }
}
