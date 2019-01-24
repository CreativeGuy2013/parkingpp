import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:duration/duration.dart';
import 'authentication.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryPage extends StatelessWidget {
  static MiniMapSheet map = MiniMapSheet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking History"),
      ),
      body: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: Firestore.instance
                .collection("tickets")
                .where("user", isEqualTo: userState.getID())
                .orderBy("start", descending: true)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Text('Loading...');
                default:
                  return Column(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot ticket) {
                      return ParkingLocation(
                        LatLng(ticket['location'].latitude, ticket['location'].longitude),
                        DateFormat.yMMMd().format(ticket['start']).toString(),
                        ticket['licencePlate'].toString(),
                        (ticket['price'] / 100).toStringAsFixed(2).toString(),
                        ticket['end'].difference(ticket['start']),
                        map
                      );
                    }).toList(),
                  );
              }
            },
          )
        ],
      ));
  }
}

class ParkingLocation extends ListTile {
  final LatLng loc;
  final String start;
  final String numberplate;
  final String price;
  final Duration duration;
  final MiniMapSheet mapsheet;

  ParkingLocation(this.loc, this.start, this.numberplate, this.price, this.duration, this.mapsheet);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _showMinMap(context, loc),
      isThreeLine: true,
      title: Text(
        "$start (Licence Plate: $numberplate)",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      subtitle: FutureBuilder(
        future: getAdressFromLocation(
            loc.latitude,
            loc.longitude),
        builder: (BuildContext context,
            AsyncSnapshot<String> snapshot) {
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Close to ${snapshot.data.toString()}"),
                  Text(
                      "Price: €$price (${_getTimeSpend()})")
                ],
              );
          }
        })
    );
  }

  getAdressFromLocation(double latitude, double longitude) {
    final coordinates = new Coordinates(latitude, longitude);
    return Geocoder.local
        .findAddressesFromCoordinates(coordinates)
        .then((addresses) {
      final first = addresses.first;
      return first.thoroughfare + ", " + first.locality;
    }).catchError((err) {
      print(err);
    });
  }

  _getTimeSpend(){
    return printDuration(duration);
  }

  Function _showMinMap(BuildContext context, LatLng loc){
    return (){
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return mapsheet;
        });
      mapsheet.setLocation(loc);
    };
  }

}


class MiniMapSheet extends StatelessWidget {
  static GoogleMapController mapController;
  static Widget mapsView;
  static LatLng loc;

  MiniMapSheet() {
    print("init new map");
    mapsView = Padding(
      padding: const EdgeInsets.all(0.0),
      child: GoogleMap(
        onMapCreated: _onMapCreated,
      ));
  }

  @override
  Widget build(BuildContext context) {
    print("building now the minimapsheet");
    return mapsView;
  }
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (loc != null){
     mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0.00,
          target: loc,
          tilt: 0,
          zoom: 18.0,
        ),
      ));
    }

    print("initiated maps view");
  }
  setLocation(LatLng target){
    mapController == null
      ? loc = target
      :(){
        mapController.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: 0.00,
            target: target,
            tilt: 0,
            zoom: 18.0,
          )));
        mapController.addMarker(MarkerOptions(
          draggable: false,
          position: target,
        ));
      }();

  }
    
}
