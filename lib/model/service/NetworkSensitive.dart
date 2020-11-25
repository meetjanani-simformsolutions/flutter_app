import 'package:flutter/material.dart';
import 'package:flutter_app/model/enum/ConnectivityStatus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

typedef EditTextValue = void Function(String);

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;
  final EditTextValue onChange;

  NetworkSensitive({
    this.child,
    this.opacity = 0.5,
    this.onChange
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi) {
      Fluttertoast.showToast(
          msg: 'WIFI',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.transparent);
      return child;
    }
    else if (connectionStatus == ConnectivityStatus.Cellular) {
      Fluttertoast.showToast(
          msg: 'MOBILE DATA',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.transparent);
      return Opacity(
        opacity: opacity,
        child: child,
      );
    }
    else {
      Fluttertoast.showToast(
          msg: 'OFFLINE',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          textColor: Colors.white,
          backgroundColor: Colors.transparent);
      return Opacity(
        opacity: 0.1,
        child: child,
      );
    }
  }
}