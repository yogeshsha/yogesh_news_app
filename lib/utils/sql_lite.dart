import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'app.dart';

class DatabaseHelper {
  static const String _databaseName = 'files.db';
  static const String searchTable = 'searchTable';

  static Database? _database;

  Future<Database> get database async {
    _database = await openDatabase(_databaseName);

    await _database!.execute(
      '''
        CREATE TABLE IF NOT EXISTS $searchTable (
          tableId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
          title TEXT,
          subTitle TEXT
        )
      ''',
    );
    return _database!;
  }




  Future<void> deleteRowSearchTable(int id) async {
    final Database db = await database;
    await db.delete(
      searchTable,
      where: "tableId = $id",

    );
  }


  Future<List<Map<String, dynamic>>> getSearchTable(String variable) async {
    final Database db = await database;
    final List<Map<String, dynamic>> files = await db.query(variable,orderBy:"tableId DESC" );
    AppHelper.myPrint("--------------- Get Search Table --------------");
    AppHelper.myPrint(files);
    AppHelper.myPrint("-----------------------------");
    return files;
  }
  
  
  Future<List<Map<String, dynamic>>> get(String variable) async {
    final Database db = await database;
    final List<Map<String, dynamic>> files = await db.query(variable,orderBy:"id DESC" );
    AppHelper.myPrint("--------------- Get Search Table --------------");
    AppHelper.myPrint(files);
    AppHelper.myPrint("-----------------------------");
    return files;
  }

  Future<int> createSearch({required dynamic model,required String tableName}) async {
    AppHelper.myPrint("---------------- Add Entry Table -------------------");
    AppHelper.myPrint(model.toJson().keys.join(","));
    AppHelper.myPrint(model.toJson().values.join(","));
    final Database db = await database;
    final title = model.title as String;
    final checkQuery = 'SELECT tableId FROM $tableName WHERE title = ?';
    final existingNumber = await db.rawQuery(checkQuery, [title]);
    AppHelper.myPrint("-------------------- Existing Number ----------------");
    AppHelper.myPrint(existingNumber);
    AppHelper.myPrint("------------------------------------");
    if (existingNumber.isNotEmpty) {
     await  deleteRowSearchTable(model.tableId ?? 0);
    }
    return await db.insert(
      tableName,
      model.toJson(),

      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  
  
  
  Future<void> clearTable({required String tableName}) async {
    final Database db = await database;
    await db.delete(tableName);
  }

  Future<void> updateRow({required int id,required dynamic model,required String tableName}) async {
    final Database db = await database;
    await db.update(
      tableName,
      model.toJson(),
      where: 'id = $id',
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
