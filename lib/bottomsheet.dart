import 'package:flutter/material.dart';

class PurchaseSheet extends StatefulWidget {
  @override
  State createState() => PurchaseSheetState();
}

class PurchaseSheetState extends State<PurchaseSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('How long do you want to park?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.00,
          )
        )
      )
    );
  }
}
