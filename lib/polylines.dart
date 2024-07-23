import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polylines extends StatefulWidget {
  const Polylines({super.key});

  @override
  State<Polylines> createState() => _PolylinesState();
}

class _PolylinesState extends State<Polylines> {

  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(
        31.515795241966867, 74.41747899905428
    ),
    zoom: 15,
  );
  final Set<Polyline> _polylines = {};
  final Set<Marker> _marker = {};
  List<LatLng> points = const [
    LatLng(31.515795241966867, 74.41747899905428),
    LatLng(31.604727973170405, 74.32169195383474),
    LatLng(31.65091608590131, 74.46897741046263),
    LatLng(31.621685766936018, 74.28907629327614),
    LatLng(31.40225775839049, 74.63257923924807),

  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0; i<points.length; i++){
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: points[i],
          infoWindow: const InfoWindow(
            title: 'Really Cold Place',
            snippet: '5 Star Rating'
          ),
          icon: BitmapDescriptor.defaultMarker
        )
      );
      setState(() {

      });

      _polylines.add(
          Polyline(
            polylineId: const PolylineId('1'),
            points: points,
          )
      );


    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygons'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: GoogleMap(
        polylines: _polylines,
        markers: _marker,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
