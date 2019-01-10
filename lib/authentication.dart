import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

FirebaseUser user;
bool isSignedIn = false;

startAuth() {
  _auth.onAuthStateChanged.listen((u) {
    user = u;
    isSignedIn = !(u == null);
  }).isPaused;
}

Future<FirebaseUser> handleSignIn() async {
  GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  FirebaseUser user = await _auth.signInWithGoogle(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  print("signed in " + user.displayName);
  return user;
}

Future<void> handleSignOut() async {
  await _auth.signOut();
  print("signed out");
}

class AuthenticationSheet extends StatefulWidget {
  @override
  State createState() => AuthenticationSheetState();
}

class AuthenticationSheetState extends State<AuthenticationSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text("Authenticate"),
        RaisedButton(
          child: Text("Sign in"),
          onPressed: () => handleSignIn()
              .then((FirebaseUser user) => print(user))
              .catchError((e) => print(e)),
        )
      ],
    ));
  }
}
