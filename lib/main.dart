import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/bottomnavigationbar.dart';
import 'package:flutter_app/bottomnavigationbarpersistantdata.dart';
import 'package:flutter_app/datapassintowidget/passData.dart';
import 'package:flutter_app/apiCall.dart';
import 'package:flutter_app/gridview.dart';
import 'package:flutter_app/listView.dart';
import 'package:flutter_app/loginpage.dart';
import 'package:flutter_app/model/bloc/CounterScreen.dart';
import 'package:flutter_app/model/bloc_1/block_1_screen.dart';
import 'package:flutter_app/model/data.dart';
import 'package:flutter_app/model/enum/ConnectivityStatus.dart';
import 'package:flutter_app/model/mobxstore/countermobx.dart';
import 'package:flutter_app/model/service/ConnectivityService.dart';
import 'package:flutter_app/model/service/NetworkSensitive.dart';
import 'package:flutter_app/pageview.dart';
import 'package:flutter_app/pagination.dart';
import 'package:flutter_app/permissionmodel/camera_screen.dart';
import 'package:flutter_app/permissionmodel/permissiondemo2.dart';
import 'package:flutter_app/permissionmodel/permissionhandlerdemo.dart';
import 'package:flutter_app/pulltorefreshdemo.dart';
import 'package:flutter_app/sidedrawer.dart';
import 'package:flutter_app/statemanagement/blocapicall/BlocAPICallScreen.dart';
import 'package:flutter_app/statemanagement/mobxapicall/MobxAPICallScreen.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'statemanagement/blocwetherapplication/WeatherAppScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is th  e root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityService().connectionStatusController,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<PassDataState> _keyChild1 = GlobalKey();
  int _counter = 0;
  bool isVisible = true;

  String textToDisplay;
  String textInputed;
  void changeText(){
    setState(() {
      textToDisplay = textInputed;
    });
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    CounterMobxStore counterMobxStore = CounterMobxStore();
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {
              Fluttertoast.showToast(
                  msg: 'Hello',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  textColor: Colors.black,
                  backgroundColor: Colors.transparent);
            },
          )
        ],
      ),
      backgroundColor: Colors.white70,
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          handleOpacity(connectionStatus),
          Text(
            'Times:',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.white,
                decoration: TextDecoration.combine(
                    [TextDecoration.underline, TextDecoration.overline]),
                decorationThickness: 4.0,
                decorationColor: Colors.green,
                decorationStyle: TextDecorationStyle.wavy,
                letterSpacing: 2,
                wordSpacing: 4,
                shadows: [
                  Shadow(
                      color: Colors.black,
                      blurRadius: 2.0,
                      offset: Offset(1, 1))
                ]),
          ),
          Observer(builder: (context){
            return Text(
               '${counterMobxStore.counter}',
              // '$_counter',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            );
          }),
          Visibility(
            visible: !isVisible,
            child: Row(
              children: <Widget>[
                Text("1"),
                Expanded(
                  child: Text(
                      "dhisgdigsidgsigdigesifkdpkgfjkgpfkpghkphpghpghgiphipigjfpgjpfjgpjfpgjpfjgpj"),
                ),
                Text(
                  "1",
                  style: TextStyle(foreground: Paint()..color = Colors.red),
                )
              ],
            ),
          ),
          Container(
            color: Colors.blue,
            transform: Matrix4.rotationZ(0.05),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: <Widget>[Text("1"), Text("2"), Text("3")],
            ),
          ),
          Row(
            children: [
              FlatButton(
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                padding: EdgeInsets.all(5),
                highlightColor: Colors.red,
                onPressed: () async {
                  Future.delayed(Duration(seconds: 3), (){_keyChild1.currentState.updateText("Update from Parent");});
                  final dataFromSecondPage = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PassData(
                            key: _keyChild1,
                            data: Data(counter: 1, dateTime: "06/11/2020", text: 'Lorem ipsum'),
                          )),
                    );
                  Fluttertoast.showToast(
                      msg: 'dataFromSecondPage.text',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.transparent);
                },
                child: Text(
                  "FlatButton",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CountProvider(buttonColor : Colors.red,child: LoginPage(value : "Hello Meet"))),
                  );
                },
                textColor: Colors.white,
                color: Colors.red[200],
                splashColor: Colors.cyan,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 6.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Login Screen",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          Container(
            height: 100,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network("https://homepages.cae.wisc.edu/~ece533/images/airplane.png",
                  fit: BoxFit.fill,),
                ),
                Container(
                  color: Colors.purpleAccent.withOpacity(0.1),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(20),
                  child: Text("Flutter Demo", style: TextStyle(color: Colors.white, fontSize: 25),),
                ),
              ],
            ),
          ),
          // colume with editText & Simple button
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListViewDemo()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "List Builder",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageViewDemo()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Page View",
                  style: TextStyle(fontSize: 24),
                ),
              )
            ],
          ),
         Row(
           children: [
             RaisedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => BottomNavigationBarDemo()),
                 );
               },
               textColor: Colors.white,
               color: Colors.blue,
               splashColor: Colors.green,
               elevation: 20,
               highlightElevation: 100,
               shape: Border.all(width: 4.0, color: Colors.white),
               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
               child: Text(
                 "Bottom Bar",
                 style: TextStyle(fontSize: 24),
               ),
             ),
             RaisedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => BottomNavigationBarPersistantDataDemo()),
                 );
               },
               textColor: Colors.white,
               color: Colors.blue,
               splashColor: Colors.green,
               elevation: 20,
               highlightElevation: 100,
               shape: Border.all(width: 4.0, color: Colors.white),
               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
               child: Text(
                 "Bottom Bar Persistant",
                 style: TextStyle(fontSize: 18),
               ),
             ),
           ],
         ),
         Row(
           children: [
             RaisedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => SideDrawerDemo()),
                 );
               },
               textColor: Colors.white,
               color: Colors.blue,
               splashColor: Colors.green,
               elevation: 20,
               highlightElevation: 100,
               shape: Border.all(width: 4.0, color: Colors.white),
               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
               child: Text(
                 "Side Drawer",
                 style: TextStyle(fontSize: 24),
               ),
             ),
             RaisedButton(
               onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => GridViewDemo()),
                 );
               },
               textColor: Colors.white,
               color: Colors.blue,
               splashColor: Colors.green,
               elevation: 20,
               highlightElevation: 100,
               shape: Border.all(width: 4.0, color: Colors.white),
               padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
               child: Text(
                 "Grid View",
                 style: TextStyle(fontSize: 24),
               ),
             )
           ],
         ),
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PullToRefreshDemo()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Pull To Refresh",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginationDemo()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Pagination",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetApiCall()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Http Get",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostApiCall()),
                  );
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
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Block_1_Screen()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Bloc",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MobXAPICallScreen()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Mobx API Call",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherAppScreen()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Bloc API Call",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
          Row(
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PermissionHandlerDemo()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Permission",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PermissionDemo2()),
                  );
                },
                textColor: Colors.white,
                color: Colors.blue,
                splashColor: Colors.green,
                elevation: 20,
                highlightElevation: 100,
                shape: Border.all(width: 4.0, color: Colors.white),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "Permission 2",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          )
         /* Column(
            children: [
              Text("$textToDisplay"),
              TextField(
                onChanged: (text){
                  textInputed = text;
                },
                keyboardType: TextInputType.number,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Hint Text",
                    labelText: "Label Text",
                    helperText: "Helper Text"
                ),
                maxLength: 20,
                // maxLines: 3 // obscureText can not be multiline
              ),
              RaisedButton(onPressed: changeText,
              child: Text("Press"),)
            ],
          ),*/

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          counterMobxStore.increment();
        },
        // onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),

      // Container(
      //   height: 150.0,
      //   width: 160.0,
      //   child: Align(
      //     alignment: Alignment.bottomLeft,
      //     child: Row(
      //       children: <Widget>[
      //         new Padding(
      //           padding: new EdgeInsets.symmetric(
      //             horizontal: 10.0,
      //           ),
      //         ),
      //         new FloatingActionButton(
      //           child: new Icon(Icons.remove),
      //           // onPressed: _incrementCounter,
      //         ),
      //         new Padding(
      //           padding: new EdgeInsets.symmetric(
      //             horizontal: 10.0,
      //           ),
      //         ),
      //         new FloatingActionButton(
      //           child: new Icon(Icons.add),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomAppBar(
          color: Colors.orange,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.import_contacts_sharp),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.access_alarm),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {},
                )
              ],
            ),
          )),
      persistentFooterButtons: [
        IconButton(
          icon: Icon(Icons.import_contacts_sharp),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.access_alarm),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {},
        )
      ],
    );
  }
}

Widget handleOpacity(ConnectivityStatus connectionStatus){
  if (connectionStatus == ConnectivityStatus.WiFi) {
    return Container(
      height: 14,
      color: Colors.green,
      child: Text("WIFI", textAlign: TextAlign.center,),
    );
  }
  else if (connectionStatus == ConnectivityStatus.Cellular) {
    return Container(
      height: 14,
      color: Colors.yellowAccent,
      child: Text("Mobile Data", textAlign: TextAlign.center,),
    );
  }
  else {
    return Container(
      height: 14,
      color: Colors.grey,
      child: Text("Offline", textAlign: TextAlign.center,),
    );
  }
}
