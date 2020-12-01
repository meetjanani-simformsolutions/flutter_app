import 'package:flutter_app/storage/database/notemodel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;

class DBHelper{
  static Database _db;
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String NOTES = 'notes';
  static const String TABLE = 'Note';
  static const String DB_NAME = 'note1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $TITLE TEXT, $NOTES TEXT)");
  }

  Future<NoteModel> save(NoteModel noteModel) async {
    var dbClient = await db;
    noteModel.id = await dbClient.insert(TABLE, noteModel.toMap());
    return noteModel;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + noteModel.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<NoteModel>> getNotes() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, TITLE, NOTES]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<NoteModel> notes = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        notes.add(NoteModel.fromMap(maps[i]));
      }
    }
    return notes;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(NoteModel noteModel) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, noteModel.toMap(),
        where: '$ID = ?', whereArgs: [noteModel.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

}