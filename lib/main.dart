import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'paymentSheet.dart';

var location = new Location();

void main() {
  //print("hey");
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  GoogleMapController mapController;

  _continueToTimeSelect() {
    var _latLng = mapController.cameraPosition.target;
    print(_latLng);

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return TimeSelectSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Parking++')),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
            trackCameraPosition: true,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _continueToTimeSelect(),
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

      controller.moveCamera(CameraUpdate.newCameraPosition(
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
