import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'search_location_widget.dart' show SearchLocationWidget;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SearchLocationModel extends FlutterFlowModel<SearchLocationWidget> {
  ///  Local state fields for this page.

  List<LocationSuggestionStruct> locationInfos = [];
  void addToLocationInfos(LocationSuggestionStruct item) =>
      locationInfos.add(item);
  void removeFromLocationInfos(LocationSuggestionStruct item) =>
      locationInfos.remove(item);
  void removeAtIndexFromLocationInfos(int index) =>
      locationInfos.removeAt(index);
  void insertAtIndexInLocationInfos(int index, LocationSuggestionStruct item) =>
      locationInfos.insert(index, item);
  void updateLocationInfosAtIndex(
          int index, Function(LocationSuggestionStruct) updateFn) =>
      locationInfos[index] = updateFn(locationInfos[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
