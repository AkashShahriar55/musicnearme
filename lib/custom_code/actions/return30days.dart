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

Future<List<DateTime>> return30days() async {
  // Add your function code here!
  List<DateTime> dates = [];
  DateTime now = DateTime.now();
  for (int i = 0; i < 30; i++) {
    DateTime date = now.add(Duration(days: i));
    dates.add(date);
  }
  return dates;
}
