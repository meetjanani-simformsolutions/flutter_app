import 'package:flutter/material.dart';
import 'package:flutter_app/loginpage.dart';
import 'package:flutter_app/sidedrawer.dart';

class BottomNavigationBarPersistantDataDemo extends StatefulWidget {
  @override
  _BottomNavigationBarPersistantDataDemoState createState() => _BottomNavigationBarPersistantDataDemoState();
}

class _BottomNavigationBarPersistantDataDemoState extends State<BottomNavigationBarPersistantDataDemo> {

  int _currentIndex = 0;
  PageController _pageController = PageController();

  final tabs = [
    CountProvider(buttonColor : Colors.red,child: LoginPage(value : "Hello Meet")),
    SideDrawerDemo(),
    ListView(),
    Center(child: Text("Profile"))
  ];

  void _onPageChanged(int index){
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BottomBar Demo"),
      ),
      body: PageView(
        controller: _pageController,
        children: tabs,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
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
          _pageController.jumpToPage(number);
          // setState(() {
          //   // _currentIndex = number;
          // });
        },
      ),);
  }
}
