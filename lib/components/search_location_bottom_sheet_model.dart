import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/location_info_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/permissions_util.dart';
import 'search_location_bottom_sheet_widget.dart'
    show SearchLocationBottomSheetWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchLocationBottomSheetModel
    extends FlutterFlowModel<SearchLocationBottomSheetWidget> {
  ///  Local state fields for this component.

  List<LocationSuggestionStruct> locationSuggestions = [];
  void addToLocationSuggestions(LocationSuggestionStruct item) =>
      locationSuggestions.add(item);
  void removeFromLocationSuggestions(LocationSuggestionStruct item) =>
      locationSuggestions.remove(item);
  void removeAtIndexFromLocationSuggestions(int index) =>
      locationSuggestions.removeAt(index);
  void insertAtIndexInLocationSuggestions(
          int index, LocationSuggestionStruct item) =>
      locationSuggestions.insert(index, item);
  void updateLocationSuggestionsAtIndex(
          int index, Function(LocationSuggestionStruct) updateFn) =>
      locationSuggestions[index] = updateFn(locationSuggestions[index]);

  bool isSuggestionLoading = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Location suggest)] action in TextField widget.
  ApiCallResponse? searchedLocations;
  // Stores action output result for [Backend Call - API (Location retreive)] action in LocationInfoItem widget.
  ApiCallResponse? getLocationInfo;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
