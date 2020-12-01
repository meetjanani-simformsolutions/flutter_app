import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/storage/database/addNoteScreen.dart';
import 'package:flutter_app/storage/database/notemodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
class NoteAppDemo extends StatefulWidget {
  @override
  _NoteAppDemoState createState() => _NoteAppDemoState();
}

class _NoteAppDemoState extends State<NoteAppDemo> {

  getNotes() {
    noteCommonObject.displayNotes();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotes();
  }

  void choiceAction(String choice){
    if(choice == Constants.light){
      noteCommonObject.changeTheme('light');
    }
    else if(choice == Constants.dark){
      noteCommonObject.changeTheme('dark');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Note App"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: choiceAction,
              itemBuilder: (BuildContext context){
                return Constants.choices.map((String choice){
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),);
                }).toList();
              }
              ,)]
          ,),
        body: Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Visibility(
                visible: true,
                child: Observer(
                  builder: (context) {
                    return Expanded(
                      child: SlideListView(
                        itemBuilder: (bc, index) {
                          final cuttentNote = noteCommonObject.noteList[index];
                          return GestureDetector(
                            child: Container(
                                padding: EdgeInsets.all(10),
                                child: Card(
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddNoteScreen(
                                                      preFieldModel: NoteModel(
                                                          cuttentNote.id,
                                                          cuttentNote.title,
                                                          cuttentNote.notes),
                                                      isUpdating: true,
                                                    )
                                            ),
                                          );
                                          setState(() {
                                            getNotes();
                                          });
                                        },
                                        title: Text(noteCommonObject
                                            .noteList[index].title
                                            .toString()),
                                        subtitle: Text(noteCommonObject
                                            .noteList[index].notes),
                                      )
                                    ],
                                  ),
                                )),
                            onTap: () {
                              print('tap ${cuttentNote.title}');
                            },
                            behavior: HitTestBehavior.translucent,
                          );
                        },
                        actionWidgetDelegate: ActionWidgetDelegate(2,
                            (actionIndex, listIndex) {
                          if (actionIndex == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.delete),
                                Text('delete')
                              ],
                            );
                          } else {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(Icons.edit),
                                Text('Edit')
                              ],
                            );
                          }
                        }, (int indexInList, int index,
                                BaseSlideItem item) async {
                          var cuttentNote = noteCommonObject.noteList[indexInList];
                          if (index == 0) {
                            // set up the button
                            Widget okButton = FlatButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // dismiss dialog
                                item.remove();
                                noteCommonObject.deleteNote(
                                    noteCommonObject.noteList[indexInList].id);
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
                          } else {
                            // item.close();
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNoteScreen(
                                        preFieldModel: NoteModel(
                                            cuttentNote.id,
                                            cuttentNote.title,
                                            cuttentNote.notes),
                                        isUpdating: true,
                                      )
                              ),
                            );
                            setState(() {
                              getNotes();
                            });
                          }
                        }, [Colors.redAccent, Colors.blueAccent]),
                        dataList: noteCommonObject.noteList,
                        refreshCallback: () async {
                          setState(() {
                            getNotes();
                          });
                          await Future.delayed(Duration(seconds: 2));
                          return;
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNoteScreen(
                        preFieldModel: NoteModel(0, '', ''),
                        isUpdating: false)),
              );
              setState(() {
                getNotes();
              });
            },
            tooltip: 'Increment',
            backgroundColor: Colors.orange,
            child: Icon(Icons.add)));
  }
}

class Constants{
  static const String light = 'Light Theme';
  static const String dark = 'Dark Theme';
  static const List<String> choices = <String>[ light, dark ];
}
