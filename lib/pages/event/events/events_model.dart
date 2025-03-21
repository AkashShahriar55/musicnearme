import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/events_component_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'events_widget.dart' show EventsWidget;
import 'package:flutter/material.dart';

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
