import 'package:flutter/material.dart';
import 'package:flutter_app/model/data.dart';

class PassData extends StatefulWidget {
  Data data;
  PassData({Key key,this.data}) : super(key: key);

  @override
  PassDataState createState() => PassDataState();
}

class PassDataState extends State<PassData> {

  String value = "Page 1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Constructor — second page'),
      ),
      body: Container(
          padding: EdgeInsets.all(12.0),
          alignment: Alignment.center,
          child: Column(
              children: <Widget>[
              Container(
              height: 54.0,
              padding: EdgeInsets.all(12.0),
              child: Text('Data passed to this page:',
              style: TextStyle(fontWeight: FontWeight.w700))),
      Text('Text: $value'),
      Text('Counter: ${widget.data.counter}'),
      Text('Date: ${widget.data.dateTime}'),
    RaisedButton(
    onPressed: () {
      Navigator.pop(context, Data(text: "Popped Text")); // data back to the first screen},
    },
    child: Text("Back"),
    ),
      ],
    ),
    ),
    );
  }
  void updateText(String text) {
    setState(() {
      value = text;
    });
  }
}