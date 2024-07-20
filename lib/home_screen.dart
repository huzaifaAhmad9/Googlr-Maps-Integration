import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(31.41918682187527, 74.23039392630363,),
    zoom: 14,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
        },
        mapType: MapType.normal,
        compassEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
