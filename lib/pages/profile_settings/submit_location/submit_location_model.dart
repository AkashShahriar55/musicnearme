import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'submit_location_widget.dart' show SubmitLocationWidget;
import 'package:flutter/material.dart';

class SubmitLocationModel extends FlutterFlowModel<SubmitLocationWidget> {
  ///  Local state fields for this page.
  /// this is json data of location
  dynamic locationDatajson;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (Reverse Geocode)] action in submitLocation widget.
  ApiCallResponse? locationData;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for yourFullName widget.
  FocusNode? yourFullNameFocusNode1;
  TextEditingController? yourFullNameTextController1;
  String? Function(BuildContext, String?)? yourFullNameTextController1Validator;
  // State field(s) for yourFullName widget.
  FocusNode? yourFullNameFocusNode2;
  TextEditingController? yourFullNameTextController2;
  String? Function(BuildContext, String?)? yourFullNameTextController2Validator;
  String? _yourFullNameTextController2Validator(
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

  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  PlacesRecord? createdPlace;

  @override
  void initState(BuildContext context) {
    yourFullNameTextController2Validator =
        _yourFullNameTextController2Validator;
    emailAddressTextControllerValidator = _emailAddressTextControllerValidator;
    businessNameTextControllerValidator = _businessNameTextControllerValidator;
    businessDescriptionTextControllerValidator =
        _businessDescriptionTextControllerValidator;
    websiteLinkTextControllerValidator = _websiteLinkTextControllerValidator;
  }

  @override
  void dispose() {
    yourFullNameFocusNode1?.dispose();
    yourFullNameTextController1?.dispose();

    yourFullNameFocusNode2?.dispose();
    yourFullNameTextController2?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    businessNameFocusNode?.dispose();
    businessNameTextController?.dispose();

    businessDescriptionFocusNode?.dispose();
    businessDescriptionTextController?.dispose();

    websiteLinkFocusNode?.dispose();
    websiteLinkTextController?.dispose();
  }
}
