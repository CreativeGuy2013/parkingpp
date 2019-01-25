import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'details.dart';
import 'croshair.dart';
import 'authentication.dart';
import 'history.dart';
import 'help.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localizations.dart';

void main() {
  runApp(MaterialApp(
      home: Home(),
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('nl'), // Dutch
        const Locale('de'), // German
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context).appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.lightBlue[600],

        fontFamily: 'Montserrat',

        textTheme: TextTheme(
          headline: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          body1: TextStyle(fontSize: 18.0, fontFamily: 'Hind'),
          body2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      )));
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
  List<Choice> menuList;

  void _continueToTimeSelect() {
    if (mapController.cameraPosition.target.latitude != 0 &&
        mapController.cameraPosition.target.longitude != 0) {
      _viewCentre = mapController.cameraPosition.target;
    }

    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return TimeSelectSheet(_viewCentre);
        });
  }

  void _signIn() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AuthenticationSheet();
        }).whenComplete(() {
      _setFab();
      _setMenuList();
    });
  }

  @override
  Widget build(BuildContext context) {
    fab = _getFab();
    menuList = _getMenuList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appName),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return menuList.map((Choice choice) {
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

  void _setFab() {
    setState(() {
      fab = _getFab();
    });
  }

  FloatingActionButton _getFab() {
    return userState.isLogedIn()
        ? FloatingActionButton(
            onPressed: () => _continueToTimeSelect(),
            tooltip: AppLocalizations.of(context).continueToDetails,
            child: Icon(Icons.arrow_forward),
            elevation: 2.0,
            heroTag: "continue",
          )
        : FloatingActionButton(
            onPressed: () => _signIn(),
            tooltip: AppLocalizations.of(context).signin,
            child: Icon(Icons.arrow_forward),
            elevation: 2.0,
          );
  }

  void _setMenuList() {
    setState(() {
      menuList = _getMenuList();
    });
  }

  List<Choice> _getMenuList() {
    return userState.isLogedIn()
        ? <Choice>[
            Choice(
                title: AppLocalizations.of(context).history,
                icon: Icons.history,
                callback: _selectHistory),
            Choice(
                title: AppLocalizations.of(context).help,
                icon: Icons.help,
                callback: _selectHelp),
            Choice(
                title: AppLocalizations.of(context).signout,
                icon: Icons.exit_to_app,
                callback: () => setState(() {
                      userState.signOut();
                      _setFab();
                      _setMenuList();
                    })),
          ]
        : <Choice>[
            Choice(
                title: AppLocalizations.of(context).signin,
                callback: () => setState(() {
                      _signIn();
                      _setFab();
                      _setMenuList();
                    })),
          ];
  }

  void _selectHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryPage()),
    );
  }

  void _selectHelp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HelpPage()),
    );
  }

  _select(Choice c) {
    c.callback();
  }

  HomeState() {
    print(userState.isInitialized());
    if (!userState.isInitialized()) {
      userState.onInitialized(() {
        _setFab();
        _setMenuList();
      });
    } else {
      _setFab();
      _setMenuList();
    }

    mapsView = Container(
      foregroundDecoration: StrikeThroughDecoration(),
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        trackCameraPosition: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
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
