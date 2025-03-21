import '/flutter_flow/flutter_flow_util.dart';
import 'contact_us_page_widget.dart' show ContactUsPageWidget;
import 'package:flutter/material.dart';

class ContactUsPageModel extends FlutterFlowModel<ContactUsPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for contactArea widget.
  FocusNode? contactAreaFocusNode;
  TextEditingController? contactAreaTextController;
  String? Function(BuildContext, String?)? contactAreaTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    contactAreaFocusNode?.dispose();
    contactAreaTextController?.dispose();
  }
}
