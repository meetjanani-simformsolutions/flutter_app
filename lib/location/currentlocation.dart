import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

  String currentLat = "", currentLong = "";

  Future<void> initlocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentLat = position.latitude.toString();
      currentLong = position.longitude.toString();
    });
  }

  @override
  void initState()  {
    super.initState();
    initlocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Lat: $currentLat'),
            Text('Long: $currentLong'),
          ],
        ),
      ),
    );
  }
}
