// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MobxAPICall.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MobXAPICallStore on MobXAPICall, Store {
  final _$randomUsersAtom = Atom(name: 'MobXAPICall.randomUsers');

  @override
  List<Result> get randomUsers {
    _$randomUsersAtom.reportRead();
    return super.randomUsers;
  }

  @override
  set randomUsers(List<Result> value) {
    _$randomUsersAtom.reportWrite(value, super.randomUsers, () {
      super.randomUsers = value;
    });
  }

  final _$apiCallAsyncAction = AsyncAction('MobXAPICall.apiCall');

  @override
  Future<void> apiCall() {
    return _$apiCallAsyncAction.run(() => super.apiCall());
  }

  @override
  String toString() {
    return '''
randomUsers: ${randomUsers}
    ''';
  }
}
