import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

var location = new Location();

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  GoogleMapController mapController;

  void _centerOnCurrentLocation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Parking++')),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _centerOnCurrentLocation(),
          tooltip: '',
          child: Icon(Icons.arrow_forward),
          elevation: 2.0,
        ));
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });

    location.getLocation().then((Map<String, double> currentLocation) {
      var _position =
          LatLng(currentLocation["latitude"], currentLocation["longitude"]);

      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0.00,
          target: _position,
          tilt: 0,
          zoom: 18.0,
        ),
      ));
    });
  }
}
