import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginationDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserList();
  }
}

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserListState();
  }
}

class _UserListState extends State<UserList> {
  final String apiUrl = "https://randomuser.me/api/?results=10";
  ScrollController _scrollController = ScrollController();
  List<dynamic> _users = [];

  void fetchUsers() async {
    var result = await http.get(apiUrl);
    setState(() {
      // _users = json.decode(result.body)['results']; // replace records
      _users.addAll(json.decode(result.body)['results']); // add records

      Fluttertoast.showToast(
          msg: _users.length.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.black,
          backgroundColor: Colors.transparent);
    });
    // if(result.statusCode == 200){
    //   setState(() {
    //     // _users = json.decode(result.body)['results']; // replace records
    //     _users.addAll(json.decode(result.body)['results']); // add records
    //   });
    // } else {
    //   throw Exception('Failed To load data');
    // }
  }

  String _name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _location(dynamic user) {
    return user['location']['country'];
  }

  String _age(Map<dynamic, dynamic> user) {
    return "Age: " + user['dob']['age'].toString();
  }

  Widget _buildList() {
    return ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          _users[index]['picture']['large'])),
                  title: Text(_name(_users[index])),
                  subtitle: Text(_location(_users[index])),
                  trailing: Text(_age(_users[index])),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        fetchUsers();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
        ),
        body: Container(
          child: _buildList(),
        ),
      ),
    );
  }
}