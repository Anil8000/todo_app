import 'package:sqflite/sqflite.dart';
import 'package:todo_demo/models/device_model.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> initDatabase() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'api_cache.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE items(id TEXT PRIMARY KEY, name TEXT, data TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> cacheData(List<DeviceModel> items) async {
    if (_database == null) await initDatabase();
    await _database!.delete('items');
    for (var item in items) {
      await _database!.insert('items', item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<List<DeviceModel>> getCachedData() async {
    if (_database == null) await initDatabase();
    final cachedData = await _database!.query('items');
    return cachedData.map((map) => DeviceModel.fromMap(map)).toList();
  }
}
