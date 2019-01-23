import 'package:flutter/material.dart';



class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("parking history"),
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
  }}