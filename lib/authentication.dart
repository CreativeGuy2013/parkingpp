import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
final UserControl userState = UserControl();

class AuthenticationSheet extends StatefulWidget {
  @override
  State createState() => AuthenticationSheetState();
}

class AuthenticationSheetState extends State<AuthenticationSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      Text("Authenticate"),
      RaisedButton(
          child: Text("Sign in"),
          onPressed: () async {
            await userState.signIn().catchError((e) => print(e));
            if (userState.isLogedIn()) {
              Navigator.pop(context);
            }
          }),
    ]);
  }
}

class UserControl {
  var _initialized = false;
  Function _onInitialization;
  FirebaseUser _user;

  bool isInitialized() {
    return _initialized;
  }

  onInitialized(Function callback) {
    _onInitialization = callback;
  }

  UserControl() {
    storage.read(key: "usertoken").then((String usertoken) async {
      var idtoken = await storage.read(key: "idtoken");
      print(idtoken);
      print(usertoken);
      if (usertoken != null && idtoken != null) {
        _user = await _auth
            .signInWithGoogle(
              accessToken: usertoken,
              idToken: idtoken,
            )
            .catchError((e) => print(e));
      }
      _initialized = true;
      _onInitialization();
    });
  }

  signIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    storage.write(key: "usertoken", value: googleAuth.accessToken);
    storage.write(key: "idtoken", value: googleAuth.idToken);
    _user = await _auth
        .signInWithGoogle(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        )
        .catchError((e) => print(e));

    print("signed in " + _user.displayName);
  }

  String getID() {
    return _user.uid;
  }

  isLogedIn() {
    print(_user != null);
    return _user != null;
  }

  signOut() {
    _auth.signOut();
    _user = null;
    storage.delete(key: "usertoken");
    storage.delete(key: "idtoken");
    print("signed out");
    print(_user);
  }
}
