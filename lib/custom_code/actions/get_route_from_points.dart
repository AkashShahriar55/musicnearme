// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> getRouteFromPoints(
  String accessToken,
  List<LatLng> points,
  String travelType,
) async {
  String directions =
      points.map((point) => "${point.longitude},${point.latitude}").join(";");

  final response = await http.get(
      Uri.parse(
          'https://api.mapbox.com/directions/v5/mapbox/$travelType/$directions.json?&steps=true&geometries=geojson&access_token=$accessToken'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      });
  if (response.statusCode == 200) {
    print('Directions successfully calculated');
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    final List<dynamic> routes = jsonResponse['routes'];
    List<LatLng> allCoordinates = [];
    List<String> allDirections = [];
    final Map<String, dynamic> route = routes[0];
    List<dynamic> steps = route['legs'][0]['steps'];
    List<dynamic> coordinates = route['geometry']['coordinates'];
    for (var step in steps) {
      String instruction = step['maneuver']['instruction'];
      allDirections.add(instruction);
    }
    for (var coordinate in coordinates) {
      double lat = coordinate[1];
      double lng = coordinate[0];
      allCoordinates.add(LatLng(lat, lng));
    }
    FFAppState().routeDirections = allDirections;
    FFAppState().routeCoordinates = allCoordinates;
    return allDirections;
  } else {
    print('Error calculating directions: ${response.statusCode}');
    print('Response body: ${response.body}');
    return [];
  }
}
