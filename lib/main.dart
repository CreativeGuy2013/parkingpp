import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'details.dart';
import 'croshair.dart';
import 'authentication.dart';
import 'history.dart';
import 'help.dart';
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
    if (mapController.cameraPosition.target.latitude != 0 &&
        mapController.cameraPosition.target.longitude != 0) {
      _viewCentre = mapController.cameraPosition.target;
    }
    ;
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
    fab = userState.isLogedIn()
        ? FloatingActionButton(
            onPressed: () => _continueToTimeSelect(),
            tooltip: 'Continue',
            child: Icon(Icons.arrow_forward),
            elevation: 2.0,
            heroTag: "continue",
          )
        : FloatingActionButton(
            onPressed: () => _signIn(),
            tooltip: 'Sign in',
            child: Icon(Icons.arrow_forward),
            elevation: 2.0,
          );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking++'),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return _menuList.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
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

  _setFab() {
    setState(() {
      fab = userState.isLogedIn()
          ? FloatingActionButton(
              onPressed: () => _continueToTimeSelect(),
              tooltip: 'Continue',
              child: Icon(Icons.arrow_forward),
              elevation: 2.0,
              heroTag: "continue",
            )
          : FloatingActionButton(
              onPressed: () => _signIn(),
              tooltip: 'Sign in',
              child: Icon(Icons.arrow_forward),
              elevation: 2.0,
            );
    });
  }

  List<Choice> _menuList;
  _selectHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryPage()),
    );
  }

  _selectHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpPage()),
    );
  }

  _select(Choice c) {
    c.callback();
  }

  HomeState() {
    fab = null;
    if (!userState.isInitialized()) {
      userState.onInitialized(_setFab);
    } else {
      _setFab();
    }

    _menuList = <Choice>[
      Choice(title: 'History', icon: Icons.history, callback: _selectHistory),
      Choice(title: 'Help', icon: Icons.help, callback: _selectHelp),
      Choice(
          title: 'Log out',
          icon: Icons.exit_to_app,
          callback: () => setState(() {
                userState.signOut();
                _setFab();
              })),
    ];

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
}

class Choice {
  const Choice({this.title, this.icon, this.callback});

  final Function callback;
  final String title;
  final IconData icon;
}
