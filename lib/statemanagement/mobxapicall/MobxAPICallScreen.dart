import 'package:flutter/material.dart';
import 'package:flutter_app/statemanagement/mobxapicall/MobxAPICall.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MobXAPICallScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MobXRandomUserList();
  }
}

class MobXRandomUserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MobXRandomUserListState();
  }
}

class _MobXRandomUserListState extends State<MobXRandomUserList> {
  MobXAPICallStore mobXAPICall = MobXAPICallStore();
  ScrollController _scrollController = ScrollController();

  Widget _buildList() {
    return Observer(builder: (context){
      if(mobXAPICall.randomUsers.length == 0){
        return CircularProgressIndicator();
      } else {
        return ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.all(8),
          itemCount: mobXAPICall.randomUsers.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            mobXAPICall.randomUsers[index].picture.large)),
                    title: Text(mobXAPICall.randomUsers[index].name.title + mobXAPICall.randomUsers[index].name.first + mobXAPICall.randomUsers[index].name.last),
                    subtitle: Text(mobXAPICall.randomUsers[index].location.country),
                    trailing: Text(mobXAPICall.randomUsers[index].dob.age.toString()),
                  )
                ],
              ),
            );
          });
    }},);
  }

  @override
  void initState() {
    super.initState();
    mobXAPICall.apiCall();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        mobXAPICall.apiCall();
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