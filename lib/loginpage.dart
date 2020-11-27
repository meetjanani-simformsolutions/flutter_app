import 'package:flutter/material.dart';
import 'package:flutter_app/customwidgets.dart';

class LoginPage extends StatefulWidget{
  final String value ;
  LoginPage({this.value});
  @override
  _LoginPageState createState() => _LoginPageState(value);
}

class _LoginPageState extends State<LoginPage> with AutomaticKeepAliveClientMixin {
  String value;
  _LoginPageState(this.value);
  var isSignInScreen = true;
  String userEnail = "", userPass = "";
  var _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  CountProvider counterProvider;

  // void showInSnackBar(String value) {
  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(value)));
  // }

  handleScreenVisibility(bool value){
    setState(() {
      isSignInScreen = value;
    });
  }

  @override
  void didChangeDependencies() {
    counterProvider = CountProvider.of(context);
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Image.network("https://i.pinimg.com/originals/f5/99/40/f59940ae190b66e1d0a7224bfb83c949.jpg",
                  fit: BoxFit.fill,),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              child: Text("Sign in", style: TextStyle(color:  isSignInScreen ? Colors.white : Colors.white70, fontSize: 24, fontWeight: isSignInScreen ? FontWeight.bold : FontWeight.normal),),
                          onTap: (){
                            isSignInScreen = true;
                            handleScreenVisibility(isSignInScreen);
                          },),
                          GestureDetector(
                              onTap: (){
                                isSignInScreen = false;
                                handleScreenVisibility(isSignInScreen);
                              },
                              child: Text("Sign up", style: TextStyle(color: isSignInScreen ? Colors.white70 : Colors.white, fontSize: 24, fontWeight: isSignInScreen ? FontWeight.normal : FontWeight.bold),)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                      child: Column(
                        children: [
                          Visibility(// Sign In
                            visible: true,
                            child:  Column(
                              children: [
                                EditTextWidget(
                                  validator: (value){
                                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value) ? null : "Please Enter Valid Email Address";
                                  },
                                  hintLable: "Email Address",
                                  iconData: Icons.email,
                                  focuse: () => FocusScope.of(context).nextFocus(),
                                  action: TextInputAction.next,
                                ),
                                EditTextWidget(
                                  onChange: (value){
                                    userPass = value;
                                  },
                                  validator: (value){
                                    return value.length >= 6 ? null : "Please Enter Password more then 6 Character";
                                  },
                                  hintLable: "Password",
                                  iconData: Icons.lock,
                                  focuse: () => FocusScope.of(context).unfocus(),
                                  action: TextInputAction.done,
                                  obSecoreText: true,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !isSignInScreen,
                            child: Column( // Sign Up
                              children: [
                                EditTextWidget(
                                  onChange: (value){
                                    userEnail = value;
                                    // Fluttertoast.showToast(
                                    //     msg: value,
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.CENTER,
                                    //     timeInSecForIos: 1,
                                    //     textColor: Colors.black,
                                    //     backgroundColor: Colors.transparent);
                                  },
                                  validator: (value){
                                      return value.isEmpty ? "Please enter valid Name" : null;
                                  },
                                  hintLable: "Name",
                                  defaultLable: value,
                                  iconData: Icons.person,
                                  focuse: () => FocusScope.of(context).nextFocus(),
                                  action: TextInputAction.next,
                                ),
                                EditTextWidget(
                                  validator: (value){
                                    return userPass == value  ? null : "Please Enter Correct Password";
                                  },
                                  hintLable: "Confirm Password",
                                  iconData: Icons.lock,
                                  focuse: () => FocusScope.of(context).unfocus(),
                                  action: TextInputAction.done,
                                  obSecoreText: true,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                                child: RaisedButton(
                                  onPressed: (){
                                    if(_formKey.currentState.validate()){
                                      _formKey.currentState.save();

                                      final snackBar = SnackBar(
                                        content: Text("$userEnail"),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      _scaffoldKey.currentState.showSnackBar(snackBar);
                                    }
                                  },
                                  color: counterProvider.buttonColor,
                                  child: Text("Continue", style: TextStyle(color: Colors.white),),
                                ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CountProvider extends InheritedWidget {
  final Widget child;
  final Color buttonColor;

  CountProvider({Key key,this.child, this.buttonColor})
      : super(key : key,child: child);

  static CountProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CountProvider>();
  }

  @override
  bool updateShouldNotify(CountProvider oldWidget) {
    return true;
  }
}