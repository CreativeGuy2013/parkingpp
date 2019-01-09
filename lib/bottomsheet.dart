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
        padding: const EdgeInsets.all(32.0),
        child: Text('Blablablabla here we are paying for a parking spot :/.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 24.0
          )
        )
      )
    );
  }
}
