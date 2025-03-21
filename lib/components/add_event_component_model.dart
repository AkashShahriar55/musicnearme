import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'add_event_component_widget.dart' show AddEventComponentWidget;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEventComponentModel extends FlutterFlowModel<AddEventComponentWidget> {
  ///  Local state fields for this component.

  FFUploadedFile? uploadedPhoto;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  DateTime? datePicked;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  EventsRecord? createdEvent;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
