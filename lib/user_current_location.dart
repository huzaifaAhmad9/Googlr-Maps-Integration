import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
//
  final Completer<GoogleMapController> _controller = Completer();


//
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
      31.41918682187527,
      74.23039392630363,
    ),
    zoom: 15,
  );



//
  final List<Marker> _markers = const <Marker> [
    Marker(
        markerId: MarkerId('1'),
      position: LatLng(31.41918682187527, 74.23039392630363,),
      infoWindow: InfoWindow(title: 'The Title of Marker')
    )
  ];



  //
  Future<Position> getUserCurrentlocation() async{
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace){
      print('error' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getUserCurrentlocation().then((value){
            print('Mu Current Location');
            print(value.latitude.toString() + " " + value.longitude.toString());
            

          });
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
