import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'details.dart';
import 'croshair.dart';
import 'authentication.dart';
import 'menu/history.dart';
import 'menu/help.dart';
import 'menu/menu.dart';
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

  LatLng _viewCentre;
  Widget mapsView;

  Widget fab;
  Menu menu;

  @override
  Widget build(BuildContext context) {

    if (fab == null || menu == null){
      _onloginChange();
      if (!userState.isInitialized()) {
        userState.onInitialized(()=>setState(_onloginChange));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appName),
        actions: <Widget>[
          menu,
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

    controller.moveCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0.00,
        target: _viewCentre,
        tilt: 0,
        zoom: 18.0,
      ),
    ));
  }
  Widget _getNewFab(){
    return userState.isLogedIn()
        ? FloatingActionButton(
            onPressed: () => _timeSelect(),
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

  Menu _getNewMenu(){
    return Menu(
      userState.isLogedIn()
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
                callback: _signOut,)
          ]
        : <Choice>[
            Choice(
                title: AppLocalizations.of(context).signin,
                callback: _signIn,)
          ]
    );
  }


  HomeState() {
    if (!userState.isInitialized()) {
      userState.onInitialized(_onloginChange);
    }

    Location().getLocation().then((Map<String, double> currentLocation) {
      _viewCentre =
          LatLng(currentLocation["latitude"], currentLocation["longitude"]);
    });

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

  void _timeSelect() {
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

  void _signIn() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AuthenticationSheet();
        }).whenComplete(()=>setState(_onloginChange));
  }

  void _signOut(){
    userState.signOut();
    setState(_onloginChange);
  }

  _onloginChange(){
    fab = _getNewFab();
    menu = _getNewMenu();
  }
}
