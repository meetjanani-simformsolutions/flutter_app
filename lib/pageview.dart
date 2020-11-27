
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageViewDemo extends StatefulWidget {
  @override
  _PageViewDemoState createState() => _PageViewDemoState();
}

class _PageViewDemoState extends State<PageViewDemo> {
  @override
  Widget build(BuildContext context) {

    PageController pageController = PageController();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("List View Demo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: PageView(
        children: [
          Container(
            child: Center(
              child: Text("Page 1"),
            ),
            color: Colors.blue[200],
          ),
          Container(
            child: Center(
              child: Text("Page 2"),
            ),
            color: Colors.red[200],
          )
        ],
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (number){
          // pageController.jumpToPage(0);
          Fluttertoast.showToast(
              msg: "Page Number : $number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.black,
              backgroundColor: Colors.transparent);
        },
      ),
    );
  }
}
