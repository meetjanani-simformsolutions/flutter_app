import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/apiCall.dart';
import 'package:flutter_app/bottomnavigationbar.dart';
import 'package:flutter_app/bottomnavigationbarpersistantdata.dart';
import 'package:flutter_app/customwidgets.dart';
import 'package:flutter_app/datapassintowidget/passData.dart';
import 'package:flutter_app/gridview.dart';
import 'package:flutter_app/listView.dart';
import 'package:flutter_app/loginpage.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/model/bloc_1/block_screen.dart';
import 'package:flutter_app/model/data.dart';
import 'package:flutter_app/pageview.dart';
import 'package:flutter_app/pagination.dart';
import 'package:flutter_app/permissionmodel/permissiondemo2.dart';
import 'package:flutter_app/permissionmodel/permissionhandlerdemo.dart';
import 'package:flutter_app/pulltorefreshdemo.dart';
import 'package:flutter_app/sidedrawer.dart';
import 'package:flutter_app/statemanagement/blocwetherapplication/WeatherAppScreen.dart';
import 'package:flutter_app/statemanagement/mobxapicall/MobxAPICallScreen.dart';
import 'package:flutter_app/storage/database/noteApp.dart';
import 'package:flutter_app/storage/database/sqflitescreen.dart';
import 'package:flutter_app/storage/localstorage.dart';
import 'package:flutter_app/storage/securestorage.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<PassDataState> _keyChild1 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Dashboard"),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomRow(
            childrens: [
              CustomRaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
                    );
                  },
                  buttonLable: "Dashboard"
              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () async {
                  Fluttertoast.showToast(
                      msg: 'dataFromSecondPage.text',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.transparent);

                  Future.delayed(Duration(seconds: 3), () {
                    _keyChild1.currentState.updateText("Update from Parent");
                  });
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PassData(
                              key: _keyChild1,
                              data: Data(
                                  counter: 1,
                                  dateTime: "06/11/2020",
                                  text: 'Lorem ipsum'),
                            )),
                  );
                  print("CallBack");
                  Fluttertoast.showToast(
                      msg: 'dataFromSecondPage.text',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      textColor: Colors.white,
                      backgroundColor: Colors.transparent);
                },
                buttonLable: "Navigation"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CountProvider(
                            buttonColor: Colors.red,
                            child: LoginPage(value: "Hello Meet"))),
                  );
                },
                buttonLable: "Login Page"

              ),
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListViewDemo()),
                  );
                },
                buttonLable: "List Builder"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PageViewDemo()),
                  );
                },
                buttonLable: "Page View"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationBarDemo()),
                  );
                },
                buttonLable: "Bottom Bar"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BottomNavigationBarPersistantDataDemo()),
                  );
                },
                buttonLable: "Bottom Bar Persistant"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SideDrawerDemo()),
                  );
                },
                buttonLable: "Side Drawer"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GridViewDemo()),
                  );
                },
                buttonLable: "Grid View"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PullToRefreshDemo()),
                  );
                },
                buttonLable: "Pull To Refresh"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginationDemo()),
                  );
                },
                buttonLable: "Pagination"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetApiCall()),
                  );
                },
                buttonLable: "Get API"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PostApiCall()),
                  );
                },
                buttonLable: "Post API"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BlockScreen()),
                  );
                },
                buttonLable: "Bloc"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MobXAPICallScreen()),
                  );
                },
                buttonLable: "Mobx API Call"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherAppScreen()),
                  );
                },
                buttonLable: "Weather App"

              ),
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PermissionHandlerDemo()),
                  );
                },
                buttonLable: "Permission"

              )
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PermissionDemo2()),
                  );
                },
                buttonLable: "Permission List"

              ),
              CustomRaisedButton(
                  onPressed: signInWithApple,
                  buttonLable: "Apple SignIn"
              ),
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: signInWithGoogle,
                buttonLable: "Google SignIn"

              ),
              CustomRaisedButton(
                onPressed: signUpWithFacebook,
                buttonLable: "FaceBook SignIn"

              ),
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocalStorageDemo()),
                  );
                },
                buttonLable: "Local Storage"
              ),
              CustomRaisedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SqfLiteScreen()),
                  );
                },
                buttonLable: "Flutter Database"
              ),
            ],
          ),
          CustomRow(
            childrens: [
              CustomRaisedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoteAppDemo()),
                  );
                },
                buttonLable: "Note APP"
              ),
            ],
          )
        ],
      ),
    );
  }


  Future<UserCredential> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    SecureStorageDemo secureStorageDemo = SecureStorageDemo();
    secureStorageDemo.writeSecureData("isLogin", true);

    // Once signed in, return the UserCredential
    Fluttertoast.showToast(
        msg: userCredential.user.displayName.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.white,
        backgroundColor: Colors.black);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
    );
    return userCredential;
  }

  Future<void> signUpWithFacebook() async{
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
        final User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        Fluttertoast.showToast(
            msg: user.displayName,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            textColor: Colors.white,
            backgroundColor: Colors.black);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
        );
        return user;
      }
    }catch (e) {
      print(e.message);
    }
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

}
