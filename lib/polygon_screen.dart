import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_integration/google_search_place_api.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({super.key});

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  final Completer<GoogleMapController> _controller = Completer();

   final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(
        31.515795241966867, 74.41747899905428
    ),
    zoom: 15,
  );
   final Set<Polygon> _polygon = HashSet<Polygon>();
   List<LatLng> points = const [
     LatLng(31.515795241966867, 74.41747899905428),
     LatLng(31.604727973170405, 74.32169195383474),
     LatLng(31.65091608590131, 74.46897741046263),
     LatLng(31.621685766936018, 74.28907629327614),
     LatLng(31.40225775839049, 74.63257923924807),
     LatLng(31.515795241966867, 74.41747899905428),

   ];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(
          polygonId: PolygonId('1'),
        points: points,
        fillColor: Colors.redAccent,
        geodesic: true,
        strokeWidth: 4

      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Info Window'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        polygons: _polygon,
        myLocationEnabled: false,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
