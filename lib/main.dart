import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'details.dart';
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

  var location = new Location();

  Widget mapsView;

  _continueToTimeSelect() {
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
      }).whenComplete((){
        setState((){ /* nothing, this is just necessary because we need to reload the widget */});
      });      
  }

  @override
  Widget build(BuildContext context) {
    /* 
      this is to only reload the google map once,
      otherwise it will fetch the data again, use more internet
      and have bad user experience.
    */
    if (mapsView == null){ 
      mapsView = GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
            trackCameraPosition: true,
          ),
        );
    }
    var fab = userState.isLogedIn()
    ?Container(
      child: Row(
        children: <Widget>[
                FloatingActionButton(
                  onPressed: () => setState(() => userState.signOut() ),
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
                ),
              ]
      ))
    :FloatingActionButton(
        onPressed: () => _signIn(),
        tooltip: 'Sign out',
        child: Icon(Icons.arrow_forward),
        elevation: 2.0,
      );


    return Scaffold(
      appBar: AppBar(title: const Text('Parking++')),
      body: Container(
        foregroundDecoration: new StrikeThroughDecoration(),
        child: mapsView,
      ),
      floatingActionButton: fab,
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
