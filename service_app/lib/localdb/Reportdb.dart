import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model/reportmodel.dart';

class ReportsDb{
  static final ReportsDb instance=ReportsDb._init();
  static Database? _database;

  ReportsDb._init();

  Future<Database>get database async{
    if(_database!= null)return _database!;
    _database = await _initDB('reports.db');
    return _database!;
  }
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableReports ( 
  ${ReportsFields.id} $idType, 
  ${ReportsFields.name} $textType,
  ${ReportsFields.address} $textType,
  ${ReportsFields.incident} $textType,
  ${ReportsFields.description} $textType,
  ${ReportsFields.time} $textType
  )
''');
  }

  Future<Reports> create(Reports reports) async {
    final db = await instance.database;

    // final json = note.toJson();
    // final columns =
    //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
    // final values =
    //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
    // final id = await db
    //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

    final id = await db.insert(tableReports, reports.toJson());
    return reports.copy(id: id);
  }
  Future<Reports> readReport(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableReports,
      columns: ReportsFields.values,
      where: '${ReportsFields.id} = ?',
      whereArgs: [id],
    );
print(maps);
    if (maps.isNotEmpty) {
      return Reports.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  Future<List<Reports>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${ReportsFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableReports, orderBy: orderBy);

    return result.map((json) => Reports.fromJson(json)).toList();
  }

  Future<int> update(Reports reports) async {
    final db = await instance.database;

    return db.update(
      tableReports,
      reports.toJson(),
      where: '${ReportsFields.id} = ?',
      whereArgs: [reports.id],
    );
  }
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableReports,
      where: '${ReportsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}