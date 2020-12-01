import 'package:flutter/material.dart';
import 'package:flutter_app/model/data.dart';
import 'package:flutter_app/storage/database/notemobx.dart';
import 'package:flutter_app/storage/database/notemodel.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteModel preFieldModel;
  final bool isUpdating;

  AddNoteScreen({Key key, this.preFieldModel, this.isUpdating})
      : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  NoteMobxStore noteMobxStore = NoteMobxStore();
  final formKey = new GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String title, note;
  int curUserId;
  bool isUpdating = false, isReadOnly = true, isReadOnlyVisibility = true;

  @override
  void initState() {
    super.initState();
    isUpdating = widget.isUpdating;
    if (widget.preFieldModel.id != 0) {
      titleController.text = widget.preFieldModel.title;
      noteController.text = widget.preFieldModel.notes;
      curUserId = widget.preFieldModel.id;
    } else {
      setState(() {
        isReadOnlyVisibility = false;
        isReadOnly = false;
      });
    }
  }

  clearName() {
    titleController.text = '';
    noteController.text = '';
  }

  validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (isUpdating) {
        NoteModel e = NoteModel(curUserId, title, note);
        noteMobxStore.updateNote(e);
      } else {
        NoteModel e = NoteModel(null, title, note);
        noteMobxStore.addNote(e);
      }
      clearName();
      Navigator.pop(context, Data(text: "Popped Text"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add/Update Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: isReadOnlyVisibility,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isReadOnly = false;
                          isReadOnlyVisibility = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: ClipOval(
                          child: Container(
                            color: Colors.lightBlue,
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              Icons.edit,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      hintText: 'Enter Title',
                      labelText: 'Enter Title',
                    ),
                    maxLines: 1,
                    readOnly: isReadOnly,
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    validator: (val) => val.length == 0 ? 'Enter Title' : null,
                    onSaved: (val) => title = val,
                  ),
                  SizedBox(
                    width: 0,
                    height: 30,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      hintText: 'Enter Note',
                      labelText: 'Enter Note',
                    ),
                    maxLines: 10,
                    readOnly: isReadOnly,
                    controller: noteController,
                    validator: (val) => val.length == 0 ? 'Enter Note' : null,
                    onSaved: (val) => note = val,
                  ),
                  SizedBox(
                    width: 0,
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Visibility(
                        visible: !isReadOnlyVisibility,
                        child: FlatButton(
                          color: Colors.orange,
                          textColor: Colors.white,
                          onPressed: validate,
                          child:
                              Text((isUpdating ? 'UPDATE' : 'ADD') + ' NOTE'),
                        ),
                      ),
                      FlatButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          Widget okButton = FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                              clearName();
                              Navigator.of(context).pop(); // dismiss dialog
                              Navigator.pop(context, Data(text: "Popped Text"));
                            },
                          );

                          Widget cancleButton = FlatButton(
                            child: Text("Cancle"),
                            onPressed: () {
                              Navigator.of(context).pop(); // dismiss dialog
                            },
                          );
                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Are you Sure ?"),
                            content: Text("Are you Sure ?"),
                            actions: [
                              okButton,
                              cancleButton
                            ],
                          );
                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        child: Text('CANCEL'),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
