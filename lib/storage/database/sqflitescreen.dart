import 'package:flutter/material.dart';
import 'package:flutter_app/storage/database/notemobx.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'notemodel.dart';

class SqfLiteScreen extends StatefulWidget {
  final String title;

  SqfLiteScreen({Key key, this.title}) : super(key: key);
  @override
  _SqfLiteScreenState createState() => _SqfLiteScreenState();
}

class _SqfLiteScreenState extends State<SqfLiteScreen> {
  NoteMobxStore noteMobxStore  = NoteMobxStore();
  TextEditingController controller = TextEditingController();
  String name;
  int curUserId;
  final formKey = new GlobalKey<FormState>();
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    isUpdating = false;
    refreshList();
  }

  refreshList() {
    noteMobxStore.displayNotes();
  }

  clearName() {
    controller.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        NoteModel e = NoteModel(curUserId, name, null);
        noteMobxStore.updateNote(e);
        setState(() {
          isUpdating = false;
        });
      } else {
        NoteModel e = NoteModel(null, name, null);
        noteMobxStore.addNote(e);
      }
      clearName();
      refreshList();
    }
  }

  form() {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (val) => val.length == 0 ? 'Enter Name' : null,
              onSaved: (val) => name = val,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: validate,
                  child: Text(isUpdating ? 'UPDATE' : 'ADD'),
                ),
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    clearName();
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView dataTable(List<NoteModel> employees) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('NAME'),
          ),
          DataColumn(
            label: Text('DELETE'),
          )
        ],
        rows: employees
            .map(
              (employee) => DataRow(cells: [
            DataCell(
              Text(employee.title),
              onTap: () {
                setState(() {
                  isUpdating = true;
                  curUserId = employee.id;
                });
                controller.text = employee.title;
              },
            ),
            DataCell(IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                noteMobxStore.deleteNote(employee.id);
                refreshList();
              },
            )),
          ]),
        )
            .toList(),
      ),
    );
  }

  list() {

    return Observer(builder: (context){
        print(noteMobxStore.noteList.length.toString() + " Final");
        return Expanded(child: dataTable(noteMobxStore.noteList));
      },);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter SQLITE CRUD DEMO'),
      ),
      body: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            form(),
            Observer(builder: (context){
              return Expanded(child: dataTable(noteMobxStore.noteList));
            },),
          ],
        ),
      ),
    );
  }
}
