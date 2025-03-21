import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'old_home_page_widget.dart' show OldHomePageWidget;
import 'package:flutter/material.dart';

class OldHomePageModel extends FlutterFlowModel<OldHomePageWidget> {
  ///  Local state fields for this page.

  List<String> filters = ['Venues', 'Shops', 'Lessons'];
  void addToFilters(String item) => filters.add(item);
  void removeFromFilters(String item) => filters.remove(item);
  void removeAtIndexFromFilters(int index) => filters.removeAt(index);
  void insertAtIndexInFilters(int index, String item) =>
      filters.insert(index, item);
  void updateFiltersAtIndex(int index, Function(String) updateFn) =>
      filters[index] = updateFn(filters[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Reverse Geocode)] action in oldHomePage widget.
  ApiCallResponse? locationOutput;
  InstantTimer? instantTimer;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
  }
}
