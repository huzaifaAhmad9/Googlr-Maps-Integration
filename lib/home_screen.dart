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
    target: LatLng(
      31.41918682187527,
      74.23039392630363,
    ),
    zoom: 15,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(
        31.41918682187527,
        74.23039392630363,
      ),
      infoWindow: InfoWindow(title: 'My University'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(31.587703123698308, 74.32831329606834),
      infoWindow: InfoWindow(title: 'My Home'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(60.17050166223287, 24.924755470312558),
      infoWindow: InfoWindow(title: 'Finland'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          mapType: MapType.normal,
          compassEnabled: true,
          myLocationEnabled: true,
          markers: Set<Marker>.of(_marker),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(60.17050166223287, 24.924755470312558),
            zoom: 14
          )));
          setState(() {

          });
        },
        child: Icon(Icons.location_disabled_outlined),
      ),
    );
  }
}
