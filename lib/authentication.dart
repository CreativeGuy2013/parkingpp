import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class AuthenticationSheet extends StatefulWidget {
  @override
  State createState() => AuthenticationSheetState();
}

class AuthenticationSheetState extends State<AuthenticationSheet> {
  Future<FirebaseUser> _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print("signed in " + user.displayName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text("Authenticate"),
        RaisedButton(
          child: Text("Sign in"),
          onPressed: () => _handleSignIn()
              .then((FirebaseUser user) => print(user))
              .catchError((e) => print(e)),
        )
      ],
    ));
  }
}
