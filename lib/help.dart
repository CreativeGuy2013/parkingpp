import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Help"),
        ),
        body: ListView(
          children: <Widget>[
            Text('HeY!?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.00,
                )),
          ],
        ));
  }
}
