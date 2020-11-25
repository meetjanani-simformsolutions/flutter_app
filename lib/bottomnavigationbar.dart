import 'package:flutter/material.dart';

class BottomNavigationBarDemo extends StatefulWidget {
  @override
  _BottomNavigationBarDemoState createState() => _BottomNavigationBarDemoState();
}

class _BottomNavigationBarDemoState extends State<BottomNavigationBarDemo> {

  int _currentIndex = 0;

  final tabs = [
    Center(child: Text("Home")),
    Center(child: Text("Search")),
    Center(child: Text("Camera")),
    Center(child: Text("Profile"))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BottomBar Demo"),
      ),
    body: tabs[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home",
          backgroundColor: Colors.blue
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "search",
            backgroundColor: Colors.blue
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: "camera",
            backgroundColor: Colors.blue
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "person",
            backgroundColor: Colors.blue
        )
      ],
      onTap: (number){
        setState(() {
          _currentIndex = number;
        });
      },
    ),);
  }
}
