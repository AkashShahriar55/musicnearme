import '/backend/backend.dart';
import '/components/shimmer_load_places_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/index.dart';
import 'search_page_widget.dart' show SearchPageWidget;
import 'package:flutter/material.dart';

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
