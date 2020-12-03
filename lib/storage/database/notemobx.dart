
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/storage/database/DBHelper.dart';
import 'package:flutter_app/storage/database/notemodel.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'notemobx.g.dart';

class NoteMobxStore = NoteMobx with _$NoteMobxStore;

abstract class NoteMobx with Store{

  DBHelper dbHelper = DBHelper();

  @observable
  ThemeData themeData = ThemeData( primarySwatch: Colors.blue,
      brightness: Brightness.light);

  @action
  Future<void> changeTheme(String currentTheme) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('currentTheme', currentTheme);
    updateCurrentTheme();
  }

  Future<void> updateCurrentTheme () async {
    var currentTheme = '';
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentTheme = _prefs.getString('currentTheme');
    if(currentTheme == 'light'){
      themeData = ThemeData( primarySwatch: Colors.blue,
          brightness: Brightness.light);
    }
    else if(currentTheme == 'dark'){
      themeData = ThemeData( primarySwatch: Colors.blue,
          brightness: Brightness.dark);
    }
    else {
      themeData = ThemeData( primarySwatch: Colors.blue,
          brightness: Brightness.light);
    }
  }

  @observable
  List<NoteModel> noteList = List<NoteModel>();

  @action
  Future<void> displayNotes() async {
    noteList =  (await dbHelper.getNotes());
  }

  @action
  Future<void> addNote(NoteModel noteModel) async{
    await dbHelper.save(noteModel);
    displayNotes();
  }

  @action
  Future<void> updateNote(NoteModel noteModel) async{
    await dbHelper.update(noteModel);
    displayNotes();
  }

  @action
  Future<void> deleteNote(int noteId) async {
    await dbHelper.delete(noteId);
  }

}