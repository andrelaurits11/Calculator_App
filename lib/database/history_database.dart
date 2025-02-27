import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/history_model.dart';

class HistoryDatabase {
  static final HistoryDatabase instance = HistoryDatabase._init();
  static Database? _database;

  HistoryDatabase._init();

  Future<Database> get database async {
    _database ??= await _initDB('history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            calculation TEXT NOT NULL,
            timestamp TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertHistory(HistoryEntry entry) async {
    final db = await instance.database;
    await db.insert('history', entry.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<HistoryEntry>> getHistory() async {
    final db = await instance.database;
    final maps = await db.query('history', orderBy: 'id DESC');
    return maps.map((map) => HistoryEntry.fromMap(map)).toList();
  }

  Future<void> clearHistory() async {
    final db = await instance.database;
    await db.delete('history');
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
