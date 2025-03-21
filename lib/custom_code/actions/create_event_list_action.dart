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

Future<List<EventObjStruct>> createEventListAction(
    List<EventsRecord> listOfEvents) async {
  List<EventObjStruct> eventObjList = [];
  Set<String> seenDates = {};

  for (EventsRecord event in listOfEvents) {
    bool isFirstInstance = !seenDates.contains(event.dateAsString);
    seenDates.add(event.dateAsString);

    eventObjList
        .add(EventObjStruct(event: event.reference, hasDate: isFirstInstance));
  }

  return eventObjList;
}
