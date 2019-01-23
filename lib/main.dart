import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'details.dart';
import 'croshair.dart';
import 'authentication.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

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
  LatLng _viewCentre;
  Widget mapsView;
  Widget fab;

  _continueToTimeSelect() {
    if (mapController.cameraPosition.target.latitude != 0 && mapController.cameraPosition.target.longitude != 0){
      _viewCentre = mapController.cameraPosition.target;
    };
    print(_viewCentre);

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return TimeSelectSheet(_viewCentre);
        });
  }

  _signIn() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AuthenticationSheet();
        }).whenComplete(() {
          setState(() {
            /* nothing, this is just necessary because we need to reload the widget */
          });
          
        });
        
  }

  @override
  Widget build(BuildContext context) {
    /* 
      this is to only reload the google map once,
      otherwise it will fetch the data again, use more internet
      and have bad user experience.
    */
    if (mapsView == null) {
      mapsView = Container(
        foregroundDecoration: StrikeThroughDecoration(),
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          options: GoogleMapOptions(
            myLocationEnabled: true,
            trackCameraPosition: true,
          ),
        ),
      );
    }
    if (!userState.isInitialized()) {
      fab = null;
      userState.onInitialized(() {
        setState(() {
          /* nothing, this is just necessary because we need to reload the widget */
        });
      });
    } else {
      fab = userState.isLogedIn()
          ? Container(
              child: Row(children: <Widget>[
              FloatingActionButton(
                onPressed: () => setState(() => userState.signOut()),
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
            ]))
          : FloatingActionButton(
              onPressed: () => _signIn(),
              tooltip: 'Sign out',
              child: Icon(Icons.arrow_forward),
              elevation: 2.0,
            );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Parking++')),
      body: ModalProgressHUD(
        child: mapsView,
        inAsyncCall: !userState.isInitialized(),
        opacity: 0.2,
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
      _viewCentre =
          LatLng(currentLocation["latitude"], currentLocation["longitude"]);

      controller.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0.00,
          target: _viewCentre,
          tilt: 0,
          zoom: 18.0,
        ),
      ));
    });
  }
}