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

Future<String> getAddressFromLocationGeocode(String? locationData) async {
// Check if locationData is null
  if (locationData == null) {
    return "No address found!"; // Return null if there's no data
  }

  try {
    // Parse the JSON string into a Map
    final Map<String, dynamic> parsedData = json.decode(locationData);

    // Navigate through the JSON structure to get the full address
    if (parsedData.containsKey('features') && parsedData['features'] is List) {
      final features = parsedData['features'] as List;

      // Check if there are any features available
      if (features.isNotEmpty) {
        final properties = features[0]['properties'];

        // Check if properties contains the full_address key
        if (properties != null && properties.containsKey('full_address')) {
          return properties['full_address'] as String;
        }
      }
    }
  } catch (e) {
    // Handle any parsing errors
    print('Error parsing location data: $e');
    return "No address found!";
  }

  return "No address found!";
}
