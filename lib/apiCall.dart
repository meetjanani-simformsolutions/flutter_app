import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/StudentModel.dart';
import 'package:flutter_app/model/service/ConnectivityService.dart';
import 'package:flutter_app/model/enum/ConnectivityStatus.dart';
import 'package:flutter_app/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http ;
import 'package:provider/provider.dart';

class GetApiCall extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      // ignore: deprecated_member_use
      builder: (context) => ConnectivityService().connectionStatusController,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Get API Call"),
            centerTitle: true,
          ),
          body: Center(
            child: FutureBuilder<StudentModel>(
              future: getStudent(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  final student = snapshot.data;
                  return Text("name: ${student.name} \n skill: ${student.skill}");
                } else if(snapshot.hasError) {
                  return Text("${snapshot.error.toString()}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}


Future<StudentModel> getStudent() async {
  final response = await http.get("https://api.jsonbin.io/b/5e1219328d761771cc8b9394");
  if(response.statusCode == 200){
    final jsonStudent = jsonDecode(response.body);
    return StudentModel.fromJson(jsonStudent);
  } else {
    throw Exception();
  }
}


class PostApiCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post API Call"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () async {
              final UserModel user = await postUser();
              Fluttertoast.showToast(
                  msg: '${user.name} : ${user.job} -> ${user.id}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  textColor: Colors.black,
                  backgroundColor: Colors.transparent);
            },
            textColor: Colors.white,
            color: Colors.blue,
            splashColor: Colors.green,
            elevation: 20,
            highlightElevation: 100,
            shape: Border.all(width: 4.0, color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(
              "Http Post",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }
}


Future<UserModel> postUser() async{
  final String baseUrl = "https://reqres.in/api/users";
  final response = await http.post(baseUrl, body: {
    "name": "morpheus",
    "job": "leader"
  });

  if(response.statusCode == 201){
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    throw Exception();
  }
}