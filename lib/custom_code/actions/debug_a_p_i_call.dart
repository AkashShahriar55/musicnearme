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

Future debugAPICall(dynamic apiOutput) async {
  // Add your function code here!
  try {
    // Convert the API output to a JSON string
    String jsonString = jsonEncode(apiOutput);

    // Print the JSON string to the console
    print(jsonString);
  } catch (e) {
    // Handle any errors that might occur during encoding
    print('Error encoding API output to JSON: $e');
  }
}
