import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:duration/duration.dart';
import 'authentication.dart';
import 'mini_map.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Parking History"),
        ),
        body: ListView(
          children: <Widget>[
            new StreamBuilder(
              stream: Firestore.instance
                  .collection("tickets")
                  .where("user", isEqualTo: userState.getID())
                  .orderBy("start", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new Column(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot ticket) {
                        return ListTile(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return MiniMapSheet(
                                        ticket['location'].latitude,
                                        ticket['location'].longitude);
                                  });
                            },
                            isThreeLine: true,
                            title: Text(
                              "${DateFormat.yMMMd().format(ticket['start'])} (Licence Plate: ${ticket['licencePlate']})",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: FutureBuilder(
                                future: getAdressFromLocation(
                                    ticket['location'].latitude,
                                    ticket['location'].longitude),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasError)
                                    return new Text('Error: ${snapshot.error}');
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return new Text('Loading...');
                                    default:
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("Close to ${snapshot.data}"),
                                          Text(
                                              "Price: €${(ticket['price'] / 100).toStringAsFixed(2)} (${printDuration(ticket['end'].difference(ticket['start']))})")
                                        ],
                                      );
                                  }
                                }));
                      }).toList(),
                    );
                }
              },
            )
          ],
        ));
  }

  getAdressFromLocation(double latitude, double longitude) {
    final coordinates = new Coordinates(latitude, longitude);
    return Geocoder.local
        .findAddressesFromCoordinates(coordinates)
        .then((addresses) {
      final first = addresses.first;
      print("${first.addressLine}");
      return first.thoroughfare + ", " + first.locality;
    }).catchError((err) {
      print(err);
    });
  }
}
