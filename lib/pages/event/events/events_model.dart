import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/add_event_component_widget.dart';
import '/components/events_component_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'events_widget.dart' show EventsWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class EventsModel extends FlutterFlowModel<EventsWidget> {
  ///  Local state fields for this page.

  String currentSelectedDate = '01/02/2000';

  DateTime? currentSelectedDay;

  int selectedView = 0;

  List<EventObjStruct> foundDates = [];
  void addToFoundDates(EventObjStruct item) => foundDates.add(item);
  void removeFromFoundDates(EventObjStruct item) => foundDates.remove(item);
  void removeAtIndexFromFoundDates(int index) => foundDates.removeAt(index);
  void insertAtIndexInFoundDates(int index, EventObjStruct item) =>
      foundDates.insert(index, item);
  void updateFoundDatesAtIndex(int index, Function(EventObjStruct) updateFn) =>
      foundDates[index] = updateFn(foundDates[index]);

  ///  State fields for stateful widgets in this page.

  // Model for eventsComponent component.
  late EventsComponentModel eventsComponentModel;

  @override
  void initState(BuildContext context) {
    eventsComponentModel = createModel(context, () => EventsComponentModel());
  }

  @override
  void dispose() {
    eventsComponentModel.dispose();
  }
}
