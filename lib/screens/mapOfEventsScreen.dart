import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapOfEventsScreen extends StatefulWidget {
  @override
  State<MapOfEventsScreen> createState() => MapOfEventsScreenState();
}

class MapOfEventsScreenState extends State<MapOfEventsScreen> {
  GoogleMapController? _controller;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Colors.red,
            width: 5,
          ),
        },
      ),
    );
  }
}
