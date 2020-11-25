import 'package:flutter/material.dart';

class GridViewDemo extends StatefulWidget {
  @override
  _GridViewDemoState createState() => _GridViewDemoState();
}

class _GridViewDemoState extends State<GridViewDemo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.count(crossAxisCount: 2,
        children: [
          Card(
            color: Colors.blue,
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.wifi, size: 50, color: Colors.white,),
                ),
                Container(
                  margin: EdgeInsets.only(top: 160, left: 120),
                  child: Text("Wi-Fi", style: TextStyle(color: Colors.white, fontSize: 15),),
                )
              ],
            ),
          ),
          Card(
            color: Colors.blue,
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.wifi, size: 50, color: Colors.white,),
                ),
                Container(
                  margin: EdgeInsets.only(top: 160, left: 120),
                  child: Text("Wi-Fi", style: TextStyle(color: Colors.white, fontSize: 15),),
                )
              ],
            ),
          ),
          Card(
            color: Colors.blue,
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.wifi, size: 50, color: Colors.white,),
                ),
                Container(
                  margin: EdgeInsets.only(top: 160, left: 120),
                  child: Text("Wi-Fi", style: TextStyle(color: Colors.white, fontSize: 15),),
                )
              ],
            ),
          )
        ],),
      ),
    );
  }
}


