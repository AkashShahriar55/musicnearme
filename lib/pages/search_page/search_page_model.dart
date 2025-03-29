import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/shimmer_load_places_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:math';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'search_page_widget.dart' show SearchPageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchPageModel extends FlutterFlowModel<SearchPageWidget> {
  ///  Local state fields for this page.

  bool filterActivated = false;

  bool showPlacesCarousel = false;

  List<String> placeNames = [];
  void addToPlaceNames(String item) => placeNames.add(item);
  void removeFromPlaceNames(String item) => placeNames.remove(item);
  void removeAtIndexFromPlaceNames(int index) => placeNames.removeAt(index);
  void insertAtIndexInPlaceNames(int index, String item) =>
      placeNames.insert(index, item);
  void updatePlaceNamesAtIndex(int index, Function(String) updateFn) =>
      placeNames[index] = updateFn(placeNames[index]);

  bool showLoadingPlaces = false;

  DocumentReference? fovouritedPlaces;

  int? jumpingTo;

  bool gettingDirections = false;

  bool showEventsCarousel = false;

  DocumentReference? selectedPlaceFromCarousel;

  String? searchResults;

  String? searchedText;

  List<EventsRecord> eventsFromHomePage = [];
  void addToEventsFromHomePage(EventsRecord item) =>
      eventsFromHomePage.add(item);
  void removeFromEventsFromHomePage(EventsRecord item) =>
      eventsFromHomePage.remove(item);
  void removeAtIndexFromEventsFromHomePage(int index) =>
      eventsFromHomePage.removeAt(index);
  void insertAtIndexInEventsFromHomePage(int index, EventsRecord item) =>
      eventsFromHomePage.insert(index, item);
  void updateEventsFromHomePageAtIndex(
          int index, Function(EventsRecord) updateFn) =>
      eventsFromHomePage[index] = updateFn(eventsFromHomePage[index]);

  ///  State fields for stateful widgets in this page.

  InstantTimer? instantTimer;
  // Stores action output result for [Firestore Query - Query a collection] action in searchPage widget.
  List<EventsRecord>? allEvents;
  // State field(s) for Slider widget.
  double? sliderValue;
  // Model for shimmerLoadPlaces component.
  late ShimmerLoadPlacesModel shimmerLoadPlacesModel;

  @override
  void initState(BuildContext context) {
    shimmerLoadPlacesModel =
        createModel(context, () => ShimmerLoadPlacesModel());
  }

  @override
  void dispose() {
    instantTimer?.cancel();
    shimmerLoadPlacesModel.dispose();
  }
}
