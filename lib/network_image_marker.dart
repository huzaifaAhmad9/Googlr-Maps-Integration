import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({super.key});

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.515795241966867, 74.41747899905428),
    zoom: 15,
  );

  final List<LatLng> points = const [
    LatLng(31.515795241966867, 74.41747899905428),
    LatLng(31.604727973170405, 74.32169195383474),
    LatLng(31.65091608590131, 74.46897741046263),
    LatLng(31.621685766936018, 74.28907629327614),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    for (int i = 0; i < points.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://images.pexels.com/photos/20651735/pexels-photo-20651735/free-photo-of-portrait-of-man-wearing-anime-costume.jpeg?auto=compress&cs=tinysrgb&w=600');
      if (image != null) {
        final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
          image,
          targetHeight: 100,
          targetWidth: 100,
        );
        final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
        final ByteData? byteData = await frameInfo.image.toByteData(
            format: ui.ImageByteFormat.png);
        final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();

        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            position: points[i],
            icon: BitmapDescriptor.fromBytes(resizedImageMarker),
            infoWindow: const InfoWindow(
              title: 'Title of Marker',
            ),
          ),
        );
        setState(() {});
      }
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, _) => completer.complete(info)),
    );
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Image Marker'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: GoogleMap(
        markers: Set<Marker>.of(_markers),
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
