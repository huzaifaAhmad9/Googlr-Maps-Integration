import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGooglemap extends StatefulWidget {
  const StyleGooglemap({super.key});

  @override
  State<StyleGooglemap> createState() => _StyleGooglemapState();
}

class _StyleGooglemapState extends State<StyleGooglemap> {
  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _marker = [];

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(31.515795241966867, 74.41747899905428),
    zoom: 12,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((value){
      mapTheme = value;
    });
    setState(() {
      _marker.add(
        Marker(
            markerId: MarkerId('1'),
            position: LatLng(31.515795241966867, 74.41747899905428),
            infoWindow: InfoWindow(
              title: 'My Marker',
              snippet: 'This is a marker snippet',
            )
        )
      );
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map Themes'),
        backgroundColor: Colors.cyan.withOpacity(.4),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: (){
                    _controller.future.then((value){
                      DefaultAssetBundle.of(context).loadString('assets/maptheme/silver_theme.json').then((string){
                        value.setMapStyle(string);
                      });
                    });
                  },
                    child: const Text('Silver')
                ),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString('assets/maptheme/night_theme.json').then((string){
                          value.setMapStyle(string);
                        });
                      });
                    },
                    child: const Text('Night')
                ),
                PopupMenuItem(
                    onTap: (){
                      _controller.future.then((value){
                        DefaultAssetBundle.of(context).loadString('assets/maptheme/retro_theme.json').then((string){
                          value.setMapStyle(string);
                        });
                      });
                    },
                    child: const Text('Retro')
                ),
              ]
          )
        ],
      ),
      body: SafeArea( // explore get map theme site on browser and copy json record
        child: GoogleMap(
          markers: Set<Marker>.of(_marker),
          initialCameraPosition: _kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            // controller.setMapStyle(mapTheme);
            _controller.complete(controller);
          },
        ),
      )
    );
  }
}
