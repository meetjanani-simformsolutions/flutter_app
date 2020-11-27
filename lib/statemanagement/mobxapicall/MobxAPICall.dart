import 'package:flutter/material.dart';
import 'package:flutter_app/model/RandomUserModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'MobxAPICall.g.dart';

class MobXAPICallStore = MobXAPICall with _$MobXAPICallStore;

abstract class MobXAPICall with Store{

  @observable
  List<Result> randomUsers = List<Result>();

  @action
  Future<void> apiCall() async {
    final String apiUrl = "https://randomuser.me/api/?results=10";
    var result = await http.get(apiUrl);
    randomUsers = ((randomUserModelFromJson(result.body).results)); // add records
    Fluttertoast.showToast(
        msg: randomUsers.length.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.black,
        backgroundColor: Colors.transparent);
  }
}