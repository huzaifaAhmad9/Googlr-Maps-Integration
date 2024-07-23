import 'package:flutter/material.dart';
import 'package:google_maps_integration/convert_lat_lang_to_address.dart';
import 'package:google_maps_integration/custom_marker_screen.dart';
import 'package:google_maps_integration/google_search_place_api.dart';
import 'package:google_maps_integration/home_screen.dart';
import 'package:google_maps_integration/network_image_marker.dart';
import 'package:google_maps_integration/polygon_screen.dart';
import 'package:google_maps_integration/polylines.dart';
import 'package:google_maps_integration/user_current_location.dart';

import 'custom_marker_info_window.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NetworkImageMarker(),
    );
  }
}
