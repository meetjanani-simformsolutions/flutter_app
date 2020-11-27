import 'package:flutter/material.dart';
import 'package:flutter_app/permissionmodel/phonelogs_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerDemo extends StatefulWidget {
  // final List<CameraDescription> cameras;
  @override
  _PermissionHandlerDemoState createState() => _PermissionHandlerDemoState();
}

class _PermissionHandlerDemoState extends State<PermissionHandlerDemo> {
  // final CameraDescription camera;
  // List<CameraDescription> cameras = await availableCameras();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Permission Handler"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: IconButton(
                  onPressed: checkAllPermissionOpenCamera,
                  icon: Icon(Icons.camera),
                  iconSize: 42,
                  color: Colors.white,
                ),
                color: Colors.amber,
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height - 80) / 2,
              ),
              Container(
                child: IconButton(
                    onPressed: checkPermissionPhoneLogs,
                    icon: Icon(Icons.phone),
                    iconSize: 42,
                    color: Colors.white),
                color: Colors.deepPurple,
                width: MediaQuery.of(context).size.width,
                height: (MediaQuery.of(context).size.height - 80) / 2,
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  openCamera() async {
    await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    // var gallery = await ImagePicker.pickImage(
    //   source: ImageSource.gallery,
    // );
    // var cam1 = await availableCameras();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => CameraScreen(
    //       camera: cam1[0],
    //     ),
    //   ),
    // );
  }

  openPhonelogs() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhonelogsScreen(),
      ),
    );
  }

  checkAllPermissionOpenCamera() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    if (statuses[Permission.camera].isGranted) {
      if (statuses[Permission.microphone].isGranted) {
        displayToastMessage(" Camera permission to use camera.");
        openCamera();
      } else {
        displayToastMessage(
            "Camera needs to access your microphone, please provide permission");
      }
    } else {
      displayToastMessage("Provide Camera permission to use camera.");
    }
  }

  checkPermissionOpenCamera() async {
    var cameraStatus = await Permission.camera.status;
    var microphoneStatus = await Permission.microphone.status;

    print(cameraStatus);
    print(microphoneStatus);
    //cameraStatus.isGranted == has access to application
    //cameraStatus.isDenied == does not have access to application, you can request again for the permission.
    //cameraStatus.isPermanentlyDenied == does not have access to application, you cannot request again for the permission.
    //cameraStatus.isRestricted == because of security/parental control you cannot use this permission.
    //cameraStatus.isUndetermined == permission has not asked before.

    if (!cameraStatus.isGranted) await Permission.camera.request();

    if (!microphoneStatus.isGranted) await Permission.microphone.request();

    if (await Permission.camera.isGranted) {
      if (await Permission.microphone.isGranted) {
        openCamera();
      } else {
        displayToastMessage(
            "Camera needs to access your microphone, please provide permission");
      }
    } else {
      displayToastMessage("Provide Camera permission to use camera.");
    }
  }

  checkPermissionPhoneLogs() async {
    if (await Permission.phone.request().isGranted) {
      openPhonelogs();
    } else {
      displayToastMessage(
          "Provide Phone permission to make a call and view logs.");
    }
  }

  displayToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.white,
        backgroundColor: Colors.black);
  }

  locationITEM(){

  }
}
