import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/admin_events_component_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'admin_view_place_widget.dart' show AdminViewPlaceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminViewPlaceModel extends FlutterFlowModel<AdminViewPlaceWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for yourFullName widget.
  FocusNode? yourFullNameFocusNode;
  TextEditingController? yourFullNameTextController;
  String? Function(BuildContext, String?)? yourFullNameTextControllerValidator;
  String? _yourFullNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  String? _emailAddressTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Invalid email address';
    }
    return null;
  }

  // State field(s) for businessName widget.
  FocusNode? businessNameFocusNode;
  TextEditingController? businessNameTextController;
  String? Function(BuildContext, String?)? businessNameTextControllerValidator;
  String? _businessNameTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for businessDescription widget.
  FocusNode? businessDescriptionFocusNode;
  TextEditingController? businessDescriptionTextController;
  String? Function(BuildContext, String?)?
      businessDescriptionTextControllerValidator;
  String? _businessDescriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  // State field(s) for websiteLink widget.
  FocusNode? websiteLinkFocusNode;
  TextEditingController? websiteLinkTextController;
  String? Function(BuildContext, String?)? websiteLinkTextControllerValidator;
  String? _websiteLinkTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorWebsiteRegex).hasMatch(val)) {
      return 'Invalid website';
    }
    return null;
  }

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Stores action output result for [Backend Call - API (Reverse Geocode)] action in Button widget.
  ApiCallResponse? results;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PlacesRecord? createdPlace;
  // Model for adminEventsComponent component.
  late AdminEventsComponentModel adminEventsComponentModel;

  @override
  void initState(BuildContext context) {
    yourFullNameTextControllerValidator = _yourFullNameTextControllerValidator;
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    businessNameTextControllerValidator = _businessNameTextControllerValidator;
    businessDescriptionTextControllerValidator =
        _businessDescriptionTextControllerValidator;
    websiteLinkTextControllerValidator = _websiteLinkTextControllerValidator;
    adminEventsComponentModel =
        createModel(context, () => AdminEventsComponentModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    yourFullNameFocusNode?.dispose();
    yourFullNameTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    businessNameFocusNode?.dispose();
    businessNameTextController?.dispose();

    businessDescriptionFocusNode?.dispose();
    businessDescriptionTextController?.dispose();

    websiteLinkFocusNode?.dispose();
    websiteLinkTextController?.dispose();

    adminEventsComponentModel.dispose();
  }
}
