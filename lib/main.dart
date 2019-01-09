import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

var currentLocation = <String, double>{};

var location = new Location();


void main() {

  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocation = await location.getLocation;
  } on PlatformException {
    currentLocation = null;
  }


  runApp(MaterialApp(
      home: Home()
    )
  );
}

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  GoogleMapController mapController;

  void centerLocation() {}  
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text('Parking++')),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () { },
          tooltip: 'Your Lcation',
          child: Icon(Icons.my_location),
          elevation: 2.0,
        ),
      );
  }


  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }
}
