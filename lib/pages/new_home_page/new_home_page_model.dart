import '';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/advertisement_component_widget.dart';
import '/components/blank2_widget.dart';
import '/components/blank_find_places_widget.dart';
import '/components/blank_widget.dart';
import '/components/event_list_item_widget.dart';
import '/components/sort_by_home_page_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/pages/places/place_list_item/place_list_item_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'new_home_page_widget.dart' show NewHomePageWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class NewHomePageModel extends FlutterFlowModel<NewHomePageWidget> {
  ///  Local state fields for this page.

  List<String> filters = [];
  void addToFilters(String item) => filters.add(item);
  void removeFromFilters(String item) => filters.remove(item);
  void removeAtIndexFromFilters(int index) => filters.removeAt(index);
  void insertAtIndexInFilters(int index, String item) =>
      filters.insert(index, item);
  void updateFiltersAtIndex(int index, Function(String) updateFn) =>
      filters[index] = updateFn(filters[index]);

  bool searchingForStuff = false;

  List<PlacesRecord> placesInArea = [];
  void addToPlacesInArea(PlacesRecord item) => placesInArea.add(item);
  void removeFromPlacesInArea(PlacesRecord item) => placesInArea.remove(item);
  void removeAtIndexFromPlacesInArea(int index) => placesInArea.removeAt(index);
  void insertAtIndexInPlacesInArea(int index, PlacesRecord item) =>
      placesInArea.insert(index, item);
  void updatePlacesInAreaAtIndex(int index, Function(PlacesRecord) updateFn) =>
      placesInArea[index] = updateFn(placesInArea[index]);

  bool? foundPlaces;

  bool showEventsFilter = false;

  int placesCount = 0;

  List<EventsRecord> eventsInArea = [];
  void addToEventsInArea(EventsRecord item) => eventsInArea.add(item);
  void removeFromEventsInArea(EventsRecord item) => eventsInArea.remove(item);
  void removeAtIndexFromEventsInArea(int index) => eventsInArea.removeAt(index);
  void insertAtIndexInEventsInArea(int index, EventsRecord item) =>
      eventsInArea.insert(index, item);
  void updateEventsInAreaAtIndex(int index, Function(EventsRecord) updateFn) =>
      eventsInArea[index] = updateFn(eventsInArea[index]);

  bool everytingIsLoaded = false;

  bool readyToShow = false;

  List<AdvertisementsRecord> advertisement = [];
  void addToAdvertisement(AdvertisementsRecord item) => advertisement.add(item);
  void removeFromAdvertisement(AdvertisementsRecord item) =>
      advertisement.remove(item);
  void removeAtIndexFromAdvertisement(int index) =>
      advertisement.removeAt(index);
  void insertAtIndexInAdvertisement(int index, AdvertisementsRecord item) =>
      advertisement.insert(index, item);
  void updateAdvertisementAtIndex(
          int index, Function(AdvertisementsRecord) updateFn) =>
      advertisement[index] = updateFn(advertisement[index]);

  ///  State fields for stateful widgets in this page.

  InstantTimer? readyLocation;
  // Stores action output result for [Firestore Query - Query a collection] action in newHomePage widget.
  List<PlacesRecord>? allPlaces;
  // Stores action output result for [Firestore Query - Query a collection] action in newHomePage widget.
  List<EventsRecord>? eventsFromPlace;
  // Model for blankFindPlaces component.
  late BlankFindPlacesModel blankFindPlacesModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {
    blankFindPlacesModel = createModel(context, () => BlankFindPlacesModel());
  }

  @override
  void dispose() {
    readyLocation?.cancel();
    blankFindPlacesModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    tabBarController?.dispose();
  }
}
