import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dashboardscreen.dart';
import 'package:flutter_app/model/enum/ConnectivityStatus.dart';
import 'package:flutter_app/model/mobxstore/countermobx.dart';
import 'package:flutter_app/storage/database/notemobx.dart';
import 'package:flutter_app/storage/securestorage.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget customHomeWidget;
NoteMobxStore noteCommonObject = NoteMobxStore();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await noteCommonObject.updateCurrentTheme();
  SecureStorageDemo secureStorageDemo = SecureStorageDemo();
  await secureStorageDemo.readSecureData("isLogin").then((value) {
    print(value.toString());
    customHomeWidget = (value == true ? MyHomePage(title: 'Flutter Demo Home Page') : DashboardScreen());
    return value;
  });
  runApp(MyApp());
}

class MyApp extends StatelessObserverWidget {
  // This widget is th  e root of your application.
  @override
  Widget build(BuildContext context) {

    return  Observer(
      builder: (context){
        return MaterialApp(
          title: 'Flutter Demo',
          theme:noteCommonObject.themeData,
          home: customHomeWidget,
        );
      }
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
  bool isVisible = true;

  String textToDisplay;
  String textInputed;
  int _counter;

  void changeText() {
    setState(() {
      textToDisplay = textInputed;
    });
  }

  @override
  void initState() {
    getSharePreferenceData();
    super.initState();
  }

  void getSharePreferenceData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter');
    });
  }
  void setSharePreferenceData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('counter', (_prefs.getInt('counter') + 1));
    getSharePreferenceData();
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
          Observer(builder: (context) {
            return Text(
              '${counterMobxStore.counter}',
              // '$_counter',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            );
          }),
      Text(
        'Button tapped $_counter time${_counter == 1 ? '' : 's'}.\n\n'
            'This should persist across restarts.',
      ),
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
          Container(
            height: 100,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "https://homepages.cae.wisc.edu/~ece533/images/airplane.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  color: Colors.purpleAccent.withOpacity(0.1),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Flutter Demo",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          // colume with editText & Simple button

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
        onPressed: ()  {
          setSharePreferenceData();
          counterMobxStore.increment();
          if(FirebaseAuth.instance.currentUser != null){
            SecureStorageDemo secureStorageDemo = SecureStorageDemo();
            secureStorageDemo.writeSecureData("isLogin", false);
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pop();
          }
        },
        tooltip: 'Increment',
        backgroundColor: Colors.orange,
        child: Icon(Icons.logout),
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

Widget handleOpacity(ConnectivityStatus connectionStatus) {
  if (connectionStatus == ConnectivityStatus.WiFi) {
    return Container(
      height: 14,
      color: Colors.green,
      child: Text(
        "WIFI",
        textAlign: TextAlign.center,
      ),
    );
  } else if (connectionStatus == ConnectivityStatus.Cellular) {
    return Container(
      height: 14,
      color: Colors.yellowAccent,
      child: Text(
        "Mobile Data",
        textAlign: TextAlign.center,
      ),
    );
  } else {
    return Container(
      height: 14,
      color: Colors.grey,
      child: Text(
        "Offline",
        textAlign: TextAlign.center,
      ),
    );
  }
}
