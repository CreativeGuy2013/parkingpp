import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'time_selection.dart';
import 'croshair.dart';
import 'authentication.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  State createState() => HomeState();
}

class HomeState extends State<Home> {
  GoogleMapController mapController;

  var _signedIn = false;
  var location = new Location();

  _continueToTimeSelect() {
    var _latLng = mapController.cameraPosition.target;
    print(_latLng);

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return TimeSelectSheet();
        });
  }

  _signIn() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AuthenticationSheet();
        });
  }

  _signOut() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking++')),
      body: Container(
        foregroundDecoration: new StrikeThroughDecoration(),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
            trackCameraPosition: true,
          ),
        ),
      ),
      floatingActionButton: Row(
        children: _signedIn == true
            ? <Widget>[
                FloatingActionButton(
                  onPressed: () => _signOut(),
                  tooltip: 'Sign out',
                  mini: true,
                  child: Icon(Icons.exit_to_app),
                  elevation: 2.0,
                ),
                FloatingActionButton(
                  onPressed: () => _continueToTimeSelect(),
                  tooltip: 'Continue',
                  child: Icon(Icons.arrow_forward),
                  elevation: 2.0,
                )
              ]
            : <Widget>[
                FloatingActionButton(
                  onPressed: () => _signIn(),
                  tooltip: 'Sign out',
                  child: Icon(Icons.arrow_forward),
                  elevation: 2.0,
                ),
              ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
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
