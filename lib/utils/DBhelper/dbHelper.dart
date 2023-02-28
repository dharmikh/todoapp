import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
class DBHelper {

  static DBHelper dbHelper = DBHelper._();
  DBHelper._();
  Database? database;

  Future<Database?> checkDB() async {
    print("============= CheckDB");
    if (database != null) {
      return await database;
    } else {
      return createDB();
    }
  }

  Future<Database?> createDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'keep_notes.db');
    print("============= CreateDB");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db,version)
      {
        String query ="CREATE TABLE coding (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,std TEXT,address TEXT)";
        db.execute(query);
      },
    );
  }

  void insertData ({required String name, required String std,required String address}) async {
    database = await checkDB();
    print("============= InsertDB");
    database !.insert("coding",{"name":name,"std":std,"address":address});
  }

  Future<List<Map>> readData()
  async {
    database =await checkDB();
    String query="SELECT * FROM coding";
    print("============= ReadDB");
    List<Map> dataList = await database!.rawQuery(query);
    print("============= $dataList");
    return dataList;
  }

  Future<List<Map>> readDataname(String name)
  async {
    database =await checkDB();
    String query="SELECT * FROM coding WHERE name = ?";
    List<Map> dataList = await database!.rawQuery(query,[name]);
    print("======= $dataList");
    return dataList;
  }
}