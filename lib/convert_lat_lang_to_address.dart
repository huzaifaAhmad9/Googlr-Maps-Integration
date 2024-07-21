import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() => _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String stAddress = '';
  String stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks = await placemarkFromCoordinates(31.41918682187527, 74.23039392630363);

                setState(() {
                  stAddress = locations.last.longitude.toString() + " " + locations.last.latitude.toString();
                  stAdd = placemarks.reversed.last.country.toString();
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green
                ),
                child: Center(
                  child: Text('Convert'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
