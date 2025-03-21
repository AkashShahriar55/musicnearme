import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

LatLng convertLatLong(
  String lat,
  String long,
) {
  return LatLng(double.parse(lat), double.parse(long));
}

String placeTypeSelector(String choiceChip) {
  if (choiceChip == 'Venues') {
    return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/music-near-me-0nf2cz/assets/iv7id3aus6il/musical-note.png';
  } else if (choiceChip == 'Shops') {
    return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/music-near-me-0nf2cz/assets/iv7id3aus6il/musical-note.png';
  } else if (choiceChip == 'Lessons') {
    return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/music-near-me-0nf2cz/assets/iv7id3aus6il/musical-note.png';
  }
  return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/music-near-me-0nf2cz/assets/iv7id3aus6il/musical-note.png';
}

List<DateTime> return30daysFN() {
  // Add your function code here!
  List<DateTime> dates = [];
  DateTime now = DateTime.now();
  for (int i = 0; i < 30; i++) {
    DateTime date = now.add(Duration(days: i));
    dates.add(date);
  }
  return dates;
}

String convertDateToString(DateTime date) {
  String year = date.year.toString();
  String month = date.month.toString().padLeft(2, '0');
  String day = date.day.toString().padLeft(2, '0');

  return '$year/$month/$day';
}

bool listContains(
  List<String> list,
  String string,
) {
  return list.contains(string);
}

List<EventObjStruct> createEventList(List<EventsRecord> listOfEvents) {
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

LatLng getLatLong(
  List<double> latitudes,
  List<double> longitudes,
  int index,
) {
  print('Latitudes: $latitudes');
  print('Longitudes: $longitudes');
  print('index: $index');

  return LatLng(latitudes[index], longitudes[index]);
  //return LatLng(-43, 12);
  //return 0;
}

List<LatLng> combineRoutePoints(
  LatLng startPoint,
  LatLng endPoint,
) {
  return [startPoint, endPoint];
}

double getLatOrLong(
  String choice,
  LatLng userLocation,
) {
  if (choice == "latitude") {
    return userLocation.latitude;
  } else if (choice == "longitude") {
    return userLocation.longitude;
  }
  return 0;
}

String makeAddressUrl(String addressAsString) {
  return Uri.encodeComponent(addressAsString).replaceAll('%20', '+');
}

List<PlacesRecord> returnCaseInsensitive(
  String input,
  List<PlacesRecord> places,
) {
  String lowerInput = input.toLowerCase();

  List<PlacesRecord> matchingPlaces = [];

  for (var place in places) {
    if (place.name.toLowerCase().contains(lowerInput)) {
      matchingPlaces.add(place);
    }
  }

  return matchingPlaces;
}

double haversineDistance(
  LatLng point1,
  LatLng point2,
) {
  const double R = 6371; // Earth's radius in kilometers
  double lat1 = point1.latitude;
  double lon1 = point1.longitude;
  double lat2 = point2.latitude;
  double lon2 = point2.longitude;

  double dLat = (lat2 - lat1) * (math.pi / 180.0);
  double dLon = (lon2 - lon1) * (math.pi / 180.0);

  double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1 * (math.pi / 180.0)) *
          math.cos(lat2 * (math.pi / 180.0)) *
          math.sin(dLon / 2) *
          math.sin(dLon / 2);
  double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

  return R * c; // Distance in kilometers
}

LatLng globalLocationAsLatLng(LatLng latlng) {
  return LatLng(latlng.latitude, latlng.longitude);
}

DocumentReference convertStringToRef(String refString) {
  DocumentReference ref = FirebaseFirestore.instance.doc(refString);
  return ref;
}

List<String> nameSplitFunction(String name) {
  List<String> result = [];
  name = name.toLowerCase(); // Convert the entire string to lowercase
  for (int i = 1; i <= name.length; i++) {
    result.add(name.substring(0, i));
  }
  return result;
}

List<PlacesRecord> returnWithinDistance(
  List<PlacesRecord> places,
  double distance,
  LatLng userLocation,
  String placeType,
) {
  List<MapEntry<PlacesRecord, double>> placesWithDistances = [];

  double calculateDistanceBetweenTwoPoints(LatLng point1, LatLng point2) {
    const double R = 6371; // Earth's radius in kilometers
    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    double dLat = (lat2 - lat1) * (math.pi / 180.0);
    double dLon = (lon2 - lon1) * (math.pi / 180.0);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1 * (math.pi / 180.0)) *
            math.cos(lat2 * (math.pi / 180.0)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  for (PlacesRecord place in places) {
    if (place.placeType == placeType || placeType == "All") {
      double distanceBetween =
          calculateDistanceBetweenTwoPoints(userLocation, place.coordinates!);
      if (distanceBetween < distance) {
        placesWithDistances.add(MapEntry(place, distanceBetween));
      }
    }
  }

  placesWithDistances.sort((a, b) => a.value.compareTo(b.value));

  // Extract the sorted places
  List<PlacesRecord> sortedPlaces =
      placesWithDistances.map((entry) => entry.key).toList();

  return sortedPlaces;
}

String makelowerCase(String input) {
  return input.toLowerCase();
}

String getCoordnateQueryString(LatLng location) {
  return "${location.longitude.toStringAsFixed(15)}%2C${location.latitude.toStringAsFixed(15)}";
}

List<FavoriteObjStruct> filteredFavorites(
  List<String> filterList,
  List<FavoriteObjStruct> favoriteObjects,
) {
  return favoriteObjects
      .where((favorite) => filterList.contains(favorite!.type))
      .toList();
}

List<EventsRecord> setEventsInArea(
  List<EventsRecord> currentEvents,
  List<EventsRecord> newEvents,
) {
  List<EventsRecord> allEvents = [];
  int i = 0, j = 0;

  // Merge two sorted lists
  while (i < currentEvents.length && j < newEvents.length) {
    if (currentEvents[i]!.startTime!.isBefore(newEvents[j].startTime!)) {
      allEvents.add(currentEvents[i++]);
    } else {
      allEvents.add(newEvents[j++]);
    }
  }

  // Append remaining elements
  while (i < currentEvents.length) {
    allEvents.add(currentEvents[i++]);
  }
  while (j < newEvents.length) {
    allEvents.add(newEvents[j++]);
  }

  return allEvents;
}
