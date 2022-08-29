import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  static const CameraPosition initialCameraPosition =
      CameraPosition(target: LatLng(47.2382327, -1.5603345), zoom: 12);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: GoogleMap(
      initialCameraPosition: initialCameraPosition,
    ));
  }
}
