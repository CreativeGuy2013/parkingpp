import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'bottomsheet.dart';

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

  void centerLocation() {
    location.getLocation().then((Map<String, double> currentLocation) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0.00,
          target: LatLng(currentLocation["latitude"], currentLocation["longitude"]),
          tilt: 0,
          zoom: 17.0,
        ),
      ));
      mapController.clearMarkers();
      mapController.addMarker(
        MarkerOptions(
          consumeTapEvents: true,  // <----- insert this line
          position: LatLng(currentLocation["latitude"], currentLocation["longitude"])
          
        ),
      );
      mapController.onMarkerTapped.add((Marker m){
        showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
          return PurchaseSheet();
        });
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking++')),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => centerLocation(),
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
