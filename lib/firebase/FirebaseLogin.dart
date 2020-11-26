import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseLogin extends StatefulWidget {
  @override
  _FirebaseLoginState createState() => _FirebaseLoginState();
}

class _FirebaseLoginState extends State<FirebaseLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Login"),
      ),
      body: Center(
        child: Column(
          children: [
            RaisedButton(
              onPressed: () {
                signInWithGoogle();
              },
              textColor: Colors.white,
              color: Colors.red[200],
              splashColor: Colors.cyan,
              elevation: 20,
              highlightElevation: 100,
              shape: Border.all(width: 6.0, color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "Google Sign IN",
                style: TextStyle(fontSize: 24),
              ),
            ),
            RaisedButton(
              onPressed: () {
                signUpWithFacebook();
              },
              textColor: Colors.white,
              color: Colors.red[200],
              splashColor: Colors.cyan,
              elevation: 20,
              highlightElevation: 100,
              shape: Border.all(width: 6.0, color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "Facebook Sign IN",
                style: TextStyle(fontSize: 24),
              ),
            ),
            RaisedButton(
              onPressed: () {
                signInWithApple();
              },
              textColor: Colors.white,
              color: Colors.red[200],
              splashColor: Colors.cyan,
              elevation: 20,
              highlightElevation: 100,
              shape: Border.all(width: 6.0, color: Colors.white),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "Apple Sign IN",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
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

    // Once signed in, return the UserCredential
    Fluttertoast.showToast(
        msg: (await FirebaseAuth.instance.signInWithCredential(credential)).user.email.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        textColor: Colors.white,
        backgroundColor: Colors.black);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'Flutter Demo Home Page')),
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
