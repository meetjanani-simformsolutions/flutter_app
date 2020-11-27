import 'package:flutter/material.dart';
import 'package:flutter_app/model/RandomUserModel.dart';
import 'package:flutter_app/statemanagement/blocapicall/BlocAPICall.dart';

class BlocAPICallScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocRandomUserList();
  }
}

class BlocRandomUserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BlocRandomUserListState();
  }
}

class _BlocRandomUserListState extends State<BlocRandomUserList> {
  final bloc = BlocAPICall();
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    bloc.getAPICall();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        bloc.getAPICall();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    bloc.dispose();
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
          child: StreamBuilder<List<Result>>(
              stream: bloc.apiResponse,
              builder: (context, snapshot)  {
                var listResult = snapshot.data;
                if(listResult != null){
                  if(listResult.length == 0){
                    return CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(8),
                        itemCount: listResult.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: NetworkImage(
                                          listResult[index].picture.large)),
                                  title: Text(listResult[index].name.title +
                                      listResult[index].name.first +
                                      listResult[index].name.last),
                                  subtitle: Text(
                                      listResult[index].location.country),
                                  trailing: Text(
                                      listResult[index].dob.age.toString()),
                                )
                              ],
                            ),
                          );
                        });
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },),
        ),
      ),
    );
  }
}