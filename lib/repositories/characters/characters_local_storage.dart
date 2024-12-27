import 'dart:async';
import 'package:flutter_application_3/database.dart';
import 'package:flutter_application_3/models/character.dart';

class CharactersLocalStorage {
  static final CharactersLocalStorage instance =
      CharactersLocalStorage._internal();
  factory CharactersLocalStorage() => instance;
  CharactersLocalStorage._internal();

  Future<List<Character>> getCharacters() async {
    DatabaseHelper db = DatabaseHelper();
    var characters = await db.getObject('Characters');
    List<Character> charactersList = characters.isNotEmpty
        ? characters.map((c) => Character.fromMap(c)).toList()
        : [];
    return charactersList;
  }

  Future<Character> getCharacterFromId(int id) async {
    DatabaseHelper db = DatabaseHelper();
    var character = await db.getObjectFromId('Characters', id);
    return Character.fromMap(character);
  }

  Future<int> addCharacter(Character character) async {
    DatabaseHelper db = DatabaseHelper();
    var result = await db.addObject('Characters', character.toMap());
    return result;
  }

  Future<int> removeCharacter(int id) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.removeObject('Characters', id);
  }

  Future<int> updateCharacter(Character character) async {
    DatabaseHelper db = DatabaseHelper();
    return await db.updateObject('Characters', character.toMap());
  }
}
// import 'dart:io';
// import 'dart:async';

// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart';

// import 'package:flutter_application_3/models/character.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class CharactersLocalStorage {
//   static final CharactersLocalStorage instance =
//       CharactersLocalStorage._internal();
//   factory CharactersLocalStorage() => instance;
//   CharactersLocalStorage._internal();

//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();

//   Future<Database> _initDatabase() async {
//     Directory documentsDirectory = await getApplicationSupportDirectory();
//     String path = join(documentsDirectory.path, 'example.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute(
//         '''CREATE TABLE IF NOT EXISTS Characters (id INTEGER, name TEXT, status TEXT, species TEXT, gender TEXT, image TEXT)''');
//   }

//   Future<List<Character>> getCharacters() async {
//     Database db = await database;
//     var characters = await db.query('Characters', orderBy: 'id');
//     List<Character> charactersList = characters.isNotEmpty
//         ? characters.map((c) => Character.fromMap(c)).toList()
//         : [];
//     return charactersList;
//   }

//   Future<Character> getCharacterFromId(int id) async {
//     Database db = await database;
//     var character =
//         await db.query('Characters', where: 'id = ?', whereArgs: [id]);
//     return Character.fromMap(character[0]);
//   }

//   Future<int> addCharacter(Character character) async {
//     Database db = await database;
//     var result = await db
//         .query('Characters', where: 'id = ? ', whereArgs: [character.id]);
//     return result.isEmpty
//         ? await db.insert('Characters', character.toMap())
//         : await db.update('Characters', character.toMap(),
//             where: 'id = ?', whereArgs: [character.id]);
//   }

//   Future<int> removeCharacter(int id) async {
//     Database db = await database;
//     return await db.delete('Characters', where: 'id = ?', whereArgs: [id]);
//   }

//   Future<int> updateCharacter(Character character) async {
//     Database db = await database;
//     return await db.update('Characters', character.toMap(),
//         where: 'id = ?', whereArgs: [character.id]);
//   }
// }
