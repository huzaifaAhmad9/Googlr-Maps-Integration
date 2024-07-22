import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleSearchPlaceApi extends StatefulWidget {
  const GoogleSearchPlaceApi({super.key});

  @override
  State<GoogleSearchPlaceApi> createState() => _GoogleSearchPlaceApiState();
}

class _GoogleSearchPlaceApiState extends State<GoogleSearchPlaceApi> {
  TextEditingController _controller = TextEditingController();
  var uuid = Uuid();
  String _sessionToken = '';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken.isEmpty) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAbEwS-6kyBW66udi_E6PnlyTtTHg3NsWA";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    print('Request: $request');

    var response = await http.get(Uri.parse(request));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body)['predictions'];
        print('Places List: $_placesList');
      });
    } else {
      throw Exception('Failed to Load Data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Google Search Places API'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Search Places with Names'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placesList[index]['description']),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
