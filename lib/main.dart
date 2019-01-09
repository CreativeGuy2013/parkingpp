import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

var currentLocation = <String, double>{};

var location = new Location();

void main() {
  location.onLocationChanged().listen((Map<String, double> currentLocation) {
    print(currentLocation["latitude"]);
    print(currentLocation["longitude"]);
    print(currentLocation["accuracy"]);
    print(currentLocation["altitude"]);
    print(currentLocation["speed"]);
    print(currentLocation["speed_accuracy"]); // Will always be 0 on iOS
  });

  runApp(MaterialApp(home: Home()));
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
        onPressed: () {},
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
