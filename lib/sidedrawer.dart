import 'package:flutter/material.dart';

class SideDrawerDemo extends StatefulWidget {
  @override
  _SideDrawerDemoState createState() => _SideDrawerDemoState();
}

class _SideDrawerDemoState extends State<SideDrawerDemo> {

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
          title: Text("Drawer Menu"),
          centerTitle: true,
        ),
        drawer: MainDrawer(onTap: (ctx, i) {
          setState(() {
            _currentIndex = i;
            Navigator.pop(ctx);
          });
        },),
        body: tabs[_currentIndex]
    );
  }
}


// drawer design

class MainDrawer extends StatelessWidget {

  final Function onTap;

  MainDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Theme
                  .of(context)
                  .primaryColor,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: AssetImage(
                            'assets/usa.png'),
                            fit: BoxFit.fill
                        ),
                      ),
                    ),
                    Text(("Meet Janani"),
                      style: TextStyle(fontSize: 22, color: Colors.white),),
                    Text(("MeetJanani47@gmail.com"),
                      style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("home", style: TextStyle(fontSize: 18),),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("search", style: TextStyle(fontSize: 18),),
              onTap: () => onTap(context, 1),
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text("camera", style: TextStyle(fontSize: 18),),
              onTap: () => onTap(context, 2),
            ),
          ],
        ),
      ),
    );
  }
}
