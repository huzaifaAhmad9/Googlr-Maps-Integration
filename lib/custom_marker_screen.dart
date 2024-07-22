import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? markerImage;
  List<String> images = ['images/bycicle.png', 'images/camera.png', 'images/car.png', 'images/social.png', 'images/truck.png', ];
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = <LatLng>[
    LatLng(31.60058427033085, 74.33888539912142),
    LatLng(31.59375877864665, 74.32944487810866),
    LatLng(31.58928115476228, 74.38164194659413),
    LatLng(31.55226095751286, 74.27293631187466),
    LatLng(31.729688657709396, 73.98713945324229),
  ];

  static const CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(31.60058427033085, 74.33888539912142),
    zoom: 14
  );


  Future<Uint8List> getBytesFromImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List() , targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for(int i=0; i<images.length; i++){
      final Uint8List markerIcon = await getBytesFromImages( images[i], 100);
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
          position: _latlng[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'This is title marker: ' + i.toString()
          )
        )
      );
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: GoogleMap(
              initialCameraPosition: _cameraPosition,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers),
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
            },
          ),
      ),
    );
  }
}
