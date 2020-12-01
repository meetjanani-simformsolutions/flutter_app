// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notemobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteMobxStore on NoteMobx, Store {
  final _$themeDataAtom = Atom(name: 'NoteMobx.themeData');

  @override
  ThemeData get themeData {
    _$themeDataAtom.reportRead();
    return super.themeData;
  }

  @override
  set themeData(ThemeData value) {
    _$themeDataAtom.reportWrite(value, super.themeData, () {
      super.themeData = value;
    });
  }

  final _$noteListAtom = Atom(name: 'NoteMobx.noteList');

  @override
  List<NoteModel> get noteList {
    _$noteListAtom.reportRead();
    return super.noteList;
  }

  @override
  set noteList(List<NoteModel> value) {
    _$noteListAtom.reportWrite(value, super.noteList, () {
      super.noteList = value;
    });
  }

  final _$changeThemeAsyncAction = AsyncAction('NoteMobx.changeTheme');

  @override
  Future<void> changeTheme(String currentTheme) {
    return _$changeThemeAsyncAction.run(() => super.changeTheme(currentTheme));
  }

  final _$displayNotesAsyncAction = AsyncAction('NoteMobx.displayNotes');

  @override
  Future<void> displayNotes() {
    return _$displayNotesAsyncAction.run(() => super.displayNotes());
  }

  final _$addNoteAsyncAction = AsyncAction('NoteMobx.addNote');

  @override
  Future<void> addNote(NoteModel noteModel) {
    return _$addNoteAsyncAction.run(() => super.addNote(noteModel));
  }

  final _$updateNoteAsyncAction = AsyncAction('NoteMobx.updateNote');

  @override
  Future<void> updateNote(NoteModel noteModel) {
    return _$updateNoteAsyncAction.run(() => super.updateNote(noteModel));
  }

  final _$deleteNoteAsyncAction = AsyncAction('NoteMobx.deleteNote');

  @override
  Future<void> deleteNote(int noteId) {
    return _$deleteNoteAsyncAction.run(() => super.deleteNote(noteId));
  }

  @override
  String toString() {
    return '''
themeData: ${themeData},
noteList: ${noteList}
    ''';
  }
}
