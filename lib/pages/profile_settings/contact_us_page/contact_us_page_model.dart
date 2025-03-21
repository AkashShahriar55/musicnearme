import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'contact_us_page_widget.dart' show ContactUsPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
