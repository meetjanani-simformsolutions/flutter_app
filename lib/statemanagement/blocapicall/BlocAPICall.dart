
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter_app/model/RandomUserModel.dart';

class BlocAPICall {
  final randomUsersController = StreamController<List<Result>>();

  Stream<List<Result>> get apiResponse => randomUsersController.stream;
  Function(List<Result>) get performAPICall => randomUsersController.sink.add;

  Future<void> getAPICall() async {
    final String apiUrl = "https://randomuser.me/api/?results=10";
    var result = await http.get(apiUrl);
    randomUsersController.sink.add((randomUserModelFromJson(result.body).results)); // add records
  }
  void dispose(){
    randomUsersController.close();
  }
}