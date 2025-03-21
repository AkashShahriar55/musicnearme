import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'search_page_copy_widget.dart' show SearchPageCopyWidget;
import 'package:flutter/material.dart';

class SearchPageCopyModel extends FlutterFlowModel<SearchPageCopyWidget> {
  ///  Local state fields for this page.

  String? output;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (Forward Geocode)] action in TextField widget.
  ApiCallResponse? apiResultjyu;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
