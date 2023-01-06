import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dog_model.dart';

class DogDataSource {
  Future<Database> _createOrGetTable() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<List<Dog>> readDogs() async {
    final db = await _createOrGetTable();

    final List<Map<String, dynamic>> dogMaps = await db.query('dogs');

    return List.generate(dogMaps.length, (i) {
      return Dog(
        id: dogMaps[i]['id'],
        name: dogMaps[i]['name'],
        age: dogMaps[i]['age'],
      );
    });
  }

  Future<void> insertDog(Dog dog) async {
    try {
      final db = await _createOrGetTable();

      await db.insert(
        'dogs',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> updateDog(Dog dog) async {
    final db = await _createOrGetTable();
    try {
      await db.update(
        'dogs',
        dog.toMap(),
        where: 'id = ?',
        whereArgs: [dog.id],
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> deleteDog(int id) async {
    final db = await _createOrGetTable();

    try {
      await db.delete(
        'dogs',
        where: 'id = ?',
        whereArgs: [id],
      );
    } on Exception {
      rethrow;
    }
  }

  Future<void> closeDatabase() async {
    final db = await _createOrGetTable();
    await db.close();
  }
}
