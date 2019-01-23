import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MiniMapSheet extends StatelessWidget {
  LatLng location;

  MiniMapSheet(double latitude, double longitude) {
    location = LatLng(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: GoogleMap(
          onMapCreated: (controller) {
            controller.moveCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                bearing: 0.00,
                target: location,
                tilt: 0,
                zoom: 18.0,
              ),
            ));

            controller.addMarker(MarkerOptions(
              draggable: false,
              position: location,
            ));
          },
        ));
  }
}
