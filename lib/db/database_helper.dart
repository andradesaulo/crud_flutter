import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crud_flutter/model/personagem.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;
  DatabaseHelper.internal();
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute (
        'CREATE TABLE personagem('
            'id INTEGER PRIMARY KEY,'
            'nome TEXT,'
            'apelido TEXT,'
            'especie TEXT,'
            'anoCriacao INTEGER'
        ')'
    );
  }

  Future<int> inserirPersonagem(Personagem personagem) async {
    var dbClient = await db;
    var result = await dbClient.insert('personagem', personagem.toMap());
    return result;
  }

  Future<List> getPersonagens() async {
    var dbClient = await db;
    var result =
        await dbClient.query(
            "personagem",
            columns: [
              "id",
              "nome",
              "apelido",
              "especie",
              "anoCriacao"
            ]
        );

    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery('SELECT COUNT(1) FROM personagem')
    );
  }

  Future<Personagem> getPersonagem(int id) async {
    var dbClient = await db;
    List<Map> result =
      await dbClient.query(
        "personagem",
        columns: [
          "id",
          "nome",
          "apelido",
          "especie",
          "anoCriacao",
        ],
        where: 'id = ?',
        whereArgs: [id]
    );

    if (result.length > 0) {
      return new Personagem.fromMap(result.first);
    }
    return null;
  }

  Future<int> deletePersonagem(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      "personagem",
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<int> updatePersonagem(Personagem personagem) async {
    var dbClient = await db;
    return await dbClient.update(
      "personagem",
      personagem.toMap(),
      where:"id = ?",
      whereArgs: [personagem.id]
    );
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}